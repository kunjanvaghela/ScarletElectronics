const {google} = require('googleapis');
const keyfilepath = __dirname + '/../util/scarletelectronics-aad28cbbe2ee.json';
const parentFolder = ['18JECWflK5JGaS1zvmIjA2UyyNB-6H605'];
const fs = require('fs');
const { Model } = require('sequelize');

const auth = new google.auth.GoogleAuth({
  keyFile: keyfilepath,
  scopes: ['https://www.googleapis.com/auth/drive'],
});


async function listFiles() {
    const drive = google.drive({version: 'v3', auth});
    const res = await drive.files.list({
        pageSize: 10,
        fields: 'nextPageToken, files(id, name)',
    });
    const files = res.data.files;
    if (files.length === 0) {
        console.log('No files found.');
        return;
    }

    console.log('Files:');
    files.map((file) => {
        console.log(`${file.name} (${file.id})`);
    });
}


async function createDrive(folderName) {
    const drive = google.drive({version: 'v3', auth});
    const folderMetaData = {
        name: folderName,
        mimeType: "application/vnd.google-apps.folder",
        parents: parentFolder,
    };

    const res = await drive.files.create({
        fields: "id",
        resource: folderMetaData,
    }).catch((err) => console.log(err));
    console.log("Created folder with id : " + res.data.id);
    return res.data.id
}

async function uploadFile(folderId, filePath, fileName, mimeGiven) {
    const drive = google.drive({version: 'v3', auth});
    const fileMetaData = {
        name: fileName,
        parents: [folderId],
    };

    const media = {
        mimeType: mimeGiven,
        body: fs.createReadStream(filePath),
    };

    const res = await drive.files.create({
        requestBody: fileMetaData,
        media,
        fields: "id",
    }).catch((err) => console.log(err));
    const fileId= res.data.id
    console.log("Uploaded file with id : " + fileId);
    // Grant permission for anyone with the link to view the file
    // const permissionsResponse = await drive.permissions.create({
    //     fileId: res.data.id,
    //     role: 'reader',
    //     type: 'anyone',
    // }).then((result) => {
    //     console.log("Permission updated for fileId: " + res.data.id);
    // }).catch((err) => {
    //     console.log("Error encountered in updating permission: " + err);
    // });
    const permissionsResponse = await changePermision(fileId);
    return fileId;
}

async function getImagesInFolder(folderId) {
    const drive = google.drive({ version: 'v3', auth });

    // const query = `mimeType = 'image/' and '${folderId}' in parents`;
    const query = `'${folderId}' in parents`;
    const response = await drive.files.list({
        q: query,
        fields: 'files(id, name)',
    });

    // console.log("Response : " + JSON.stringify(response, null, 2));

    const imageFiles = response.data.files;
    console.log(`Found ${imageFiles.length} image files in folder ${folderId}:`);
    imageFiles.forEach((file) => {
        console.log(`- ${file.name} (${file.id})`);
    });

    if (!imageFiles) {
        return [{"id" : ""}];
    }
    return imageFiles;
}


async function changePermision(fileId) {
    const drive = google.drive({version: 'v3', auth});
    const permissionsResponse = await drive.permissions.create({
        fileId: fileId,
        // role: 'reader',
        // type: 'anyone',
        requestBody: {
            role: 'reader',
            type: 'anyone',
        },
    }).then((result) => {
        // console.log('Result : ' + JSON.stringify(result, null, 2));
        console.log('Permission updated succesfully for fileId : ' + fileId);
        return result;
    }).catch((err) => {
        console.log('err : ' + err);
        return err;
    });
}


module.exports = {listFiles, createDrive, uploadFile, getImagesInFolder, changePermision};