CREATE DATABASE IF NOT EXISTS gamegear_store CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gamegear_store;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS order_details, cart_details, orders, cart, contacts, products, categories, users;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE users (
 user_id INT AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(120) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL,
 phone VARCHAR(20) NULL,
 address VARCHAR(255) NULL,
 role ENUM('customer','admin') NOT NULL DEFAULT 'customer',
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE categories (
 category_id INT AUTO_INCREMENT PRIMARY KEY,
 category_name VARCHAR(100) NOT NULL UNIQUE,
 description TEXT NULL
) ENGINE=InnoDB;
CREATE TABLE products (
 product_id INT AUTO_INCREMENT PRIMARY KEY,
 category_id INT NULL,
 product_name VARCHAR(180) NOT NULL,
 price DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK(price >= 0),
 quantity INT NOT NULL DEFAULT 0 CHECK(quantity >= 0),
 image VARCHAR(500) NULL,
 description TEXT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_products_category FOREIGN KEY(category_id) REFERENCES categories(category_id) ON UPDATE CASCADE ON DELETE SET NULL,
 INDEX idx_products_name(product_name), INDEX idx_products_category(category_id)
) ENGINE=InnoDB;
CREATE TABLE cart (
 cart_id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_cart_user FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE cart_details (
 cart_detail_id INT AUTO_INCREMENT PRIMARY KEY,
 cart_id INT NOT NULL,
 product_id INT NOT NULL,
 quantity INT NOT NULL DEFAULT 1 CHECK(quantity > 0),
 CONSTRAINT fk_cart_details_cart FOREIGN KEY(cart_id) REFERENCES cart(cart_id) ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT fk_cart_details_product FOREIGN KEY(product_id) REFERENCES products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT,
 UNIQUE KEY uq_cart_product(cart_id,product_id)
) ENGINE=InnoDB;
CREATE TABLE orders (
 order_id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NULL,
 customer_name VARCHAR(120) NOT NULL,
 phone VARCHAR(20) NOT NULL,
 order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 total_amount DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK(total_amount >= 0),
 status ENUM('Chờ xác nhận','Đã xác nhận','Đang giao','Hoàn thành','Đã hủy') NOT NULL DEFAULT 'Chờ xác nhận',
 payment_method ENUM('COD','Bank transfer') NOT NULL DEFAULT 'COD',
 shipping_address VARCHAR(255) NOT NULL,
 CONSTRAINT fk_orders_user FOREIGN KEY(user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE SET NULL,
 INDEX idx_orders_date(order_date), INDEX idx_orders_status(status)
) ENGINE=InnoDB;
CREATE TABLE order_details (
 detail_id INT AUTO_INCREMENT PRIMARY KEY,
 order_id INT NOT NULL,
 product_id INT NOT NULL,
 quantity INT NOT NULL CHECK(quantity > 0),
 unit_price DECIMAL(12,2) NOT NULL CHECK(unit_price >= 0),
 CONSTRAINT fk_order_details_order FOREIGN KEY(order_id) REFERENCES orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE,
 CONSTRAINT fk_order_details_product FOREIGN KEY(product_id) REFERENCES products(product_id) ON UPDATE CASCADE ON DELETE RESTRICT,
 UNIQUE KEY uq_order_product(order_id,product_id)
) ENGINE=InnoDB;
CREATE TABLE contacts (
 contact_id INT AUTO_INCREMENT PRIMARY KEY,
 full_name VARCHAR(120) NOT NULL,
 email VARCHAR(150) NOT NULL,
 subject VARCHAR(180) NULL,
 message TEXT NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
INSERT INTO categories(category_name,description) VALUES
('Chuột gaming','Chuột có dây và không dây dành cho chơi game'),
('Bàn phím cơ','Bàn phím cơ gaming nhiều kích thước'),
('Tai nghe','Tai nghe chơi game có microphone'),
('Phụ kiện','Lót chuột, tay cầm và phụ kiện khác');
INSERT INTO products(category_id,product_name,price,quantity,image,description) VALUES
(1,'Dareu EM911X Gaming Mouse',399000,25,'https://placehold.co/600x400/20232b/ffffff?text=Gaming+Mouse','Chuột gaming thiết kế gọn nhẹ, phù hợp chơi game hằng ngày.'),
(2,'GameGear Mechanical Keyboard TKL',899000,15,'https://placehold.co/600x400/20232b/ffffff?text=Mechanical+Keyboard','Bàn phím cơ layout TKL, phù hợp góc máy gaming.'),
(3,'GameGear Surround Headset',699000,18,'https://placehold.co/600x400/20232b/ffffff?text=Gaming+Headset','Tai nghe gaming có microphone và đệm tai êm.'),
(4,'RGB Gaming Mouse Pad',199000,30,'https://placehold.co/600x400/20232b/ffffff?text=Mouse+Pad','Lót chuột gaming bề mặt rộng, có viền trang trí.'),
(1,'Wireless Pro Gaming Mouse',799000,12,'https://placehold.co/600x400/20232b/ffffff?text=Wireless+Mouse','Chuột không dây phục vụ học tập và chơi game.'),
(4,'USB Game Controller',599000,10,'https://placehold.co/600x400/20232b/ffffff?text=Controller','Tay cầm USB dùng với các trò chơi tương thích.');
-- Tài khoản admin mẫu: admin@gamegear.local / Admin@123
-- Hash được tạo bằng password_hash() của PHP; có thể tạo lại bằng register.php rồi đổi role thành admin.
