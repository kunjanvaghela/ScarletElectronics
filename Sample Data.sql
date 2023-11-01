-- Insert entries for mobile category
INSERT INTO ref_catalog (name, description, category, cpu, gpu, ram, storage, operating_system, screen_size, screen_type, screen_resolution, front_camera, rear_camera, listing_Status, approval_Status, created_on, created_by, remarks, updated_by, updated_on)
VALUES
  ('iPhone 13', 'The latest iPhone with A15 Bionic chip and dual-camera system.', 'mobile', 'A15 Bionic', 'Apple GPU', '4GB', '128GB', 'iOS 15', '6.1 inches', 'Super Retina XDR', '1170x2532', '12MP', '12MP', 'Active', 'Approved', NOW(), 1, 'Top-selling mobile', 'Admin', NOW()),
  ('Samsung Galaxy S21', 'High-performance Android smartphone with Snapdragon 888 and 120Hz display.', 'mobile', 'Snapdragon 888', 'Adreno 660', '8GB', '128GB', 'Android 11', '6.2 inches', 'Dynamic AMOLED 2X', '1080x2340', '10MP', '12MP', 'Active', 'Approved', NOW(), 1, 'Best Android phone', 'Admin', NOW());

-- Insert entries for laptop category
INSERT INTO ref_catalog (name, description, category, cpu, gpu, ram, storage, operating_system, screen_size, screen_type, screen_resolution, listing_Status, approval_Status, created_on, created_by, remarks, updated_by, updated_on)
VALUES
  ('Dell XPS 13', 'Ultra-thin laptop with Intel Core i7 and InfinityEdge display.', 'laptop', 'Intel Core i7', 'Intel Iris Xe', '16GB', '512GB SSD', 'Windows 10', '13.4 inches', 'InfinityEdge', '3840x2400', 'Active', 'Approved', NOW(), 1, 'Premium ultrabook', 'Admin', NOW()),
  ('HP Spectre x360', 'Convertible laptop with AMD Ryzen 7 and OLED touchscreen.', 'laptop', 'AMD Ryzen 7', 'AMD Radeon Graphics', '16GB', '1TB SSD', 'Windows 11', '13.3 inches', 'OLED', '3840x2160', 'Active', 'Approved', NOW(), 1, '2-in-1 laptop', 'Admin', NOW());

-- Insert entries for television category
INSERT INTO ref_catalog (name, description, category, screen_size, screen_type, screen_resolution, listing_Status, approval_Status, created_on, created_by, remarks, updated_by, updated_on)
VALUES
  ('Sony Bravia X900H', '55-inch 4K Smart TV with HDR and Android TV.', 'television', '55 inches', 'LED', '3840x2160', 'Active', 'Approved', NOW(), 1, 'Crisp picture quality', 'Admin', NOW()),
  ('LG OLED C1', '65-inch OLED 4K TV with Dolby Vision and webOS.', 'television', '65 inches', 'OLED', '3840x2160', 'Active', 'Approved', NOW(), 1, 'Perfect for movies', 'Admin', NOW());
