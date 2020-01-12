# Author: Amin Amani
drop database if exists my_shopping;

############# Creating Tables #############

CREATE DATABASE my_shopping; 

USE
    my_shopping;

DROP TABLE IF EXISTS
    users;
CREATE TABLE IF NOT EXISTS users(
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    PASSWORD VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('M', 'F'),
    phone VARCHAR(11),
    PRIMARY KEY(id)
); 
DESCRIBE
    users;

DROP TABLE IF EXISTS
    user_addresses;
CREATE TABLE IF NOT EXISTS user_addresses(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    address_type ENUM('billing', 'shipping') NOT NULL,
    address_line_1 VARCHAR(250) NOT NULL,
    address_line_2 VARCHAR(250),
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
DESCRIBE
    user_addresses;

DROP TABLE IF EXISTS
    user_payment_methods;
CREATE TABLE IF NOT EXISTS user_payment_methods(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    payment_type ENUM('debit', 'credit') NOT NULL,
    card_number VARCHAR(16) NOT NULL,
    cvv2 VARCHAR(3),
    billing_address_id INT,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(billing_address_id) REFERENCES user_addresses(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
); 
DESCRIBE
    user_payment_methods;

DROP TABLE IF EXISTS
    sellers;
CREATE TABLE IF NOT EXISTS sellers(
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    PASSWORD VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100) NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('M', 'F'),
    phone VARCHAR(11),
    PRIMARY KEY(id)
); 
DESCRIBE
    sellers;
	
DROP TABLE IF EXISTS
    products;
CREATE TABLE IF NOT EXISTS products(
    id INT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(250) NOT NULL,
    description VARCHAR(10000) NULL,
    image VARCHAR(250) NOT NULL,
    unit_price DOUBLE(9, 2) NOT NULL,
    seller_id INT NOT NULL,
    FOREIGN KEY(seller_id) REFERENCES sellers(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
DESCRIBE
    products;

DROP TABLE IF EXISTS
    categories;
CREATE TABLE IF NOT EXISTS categories(
    id INT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(250) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE KEY(NAME)
);
DESCRIBE
    categories;

DROP TABLE IF EXISTS
    product_categories;
CREATE TABLE IF NOT EXISTS product_categories(
    id INT NOT NULL AUTO_INCREMENT,
    product_id INT,
    category_id INT,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
DESCRIBE
    product_categories;

DROP TABLE IF EXISTS
    cart;
CREATE TABLE IF NOT EXISTS cart(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
DESCRIBE
    cart;

DROP TABLE IF EXISTS
    orders;
CREATE TABLE IF NOT EXISTS orders(
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT,
    shipping_address_id INT,
    payment_method_id INT,
    order_date DATE NOT NULL,
    shipped_date DATE,
    delivered_date DATE,
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(shipping_address_id) REFERENCES user_addresses(id) ON DELETE CASCADE,
    FOREIGN KEY(payment_method_id) REFERENCES user_payment_methods(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
); 
DESCRIBE
    orders;

DROP TABLE IF EXISTS
    order_items;
CREATE TABLE IF NOT EXISTS order_items(
    id INT NOT NULL AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    unit_price DOUBLE(9, 2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE,
    PRIMARY KEY(id)
);
DESCRIBE
    order_items;
	
	
	
	
############# Initial Inserts #############

DELETE FROM users;
INSERT INTO users
(id, username, password, email, first_name, middle_name, last_name, gender, phone)
VALUES
(1, 'amin_01', 'amin_01', 'amin_01@myahoo.com', 'Amin1', 'A', 'Amani1', 'M', 15556501001),
(2, 'amin_02', 'amin_02', 'amin_02@myahoo.com', 'Amin2', 'B', 'Amani2', 'M', 15556501002),
(3, 'amin_03', 'amin_03', 'amin_03@myahoo.com', 'Amin3', 'C', 'Amani3', 'M', 15556501003),
(4, 'amin_04', 'amin_04', 'amin_04@myahoo.com', 'Amin4', 'D', 'Amani4', 'M', 15556501004),
(5, 'amin_05', 'amin_05', 'amin_05@myahoo.com', 'Amin5', 'E', 'Amani5', 'M', 15556501005);

DELETE FROM user_addresses;
INSERT INTO user_addresses
(id, user_id, address_type, address_line_1, address_line_2, city, province, country, postal_code)
VALUES
(1, 1, 'billing', '1010 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H1B 1R1'),
(2, 1, 'shipping', '2020 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H2B 2R2'),
(3, 2, 'billing', '3030 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H3B 3R3'),
(4, 2, 'shipping', '4040 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H4B 4R4'),
(5, 3, 'billing', '5050 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H5B 5R5'),
(6, 3, 'shipping', '6060 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H6B 6R6'),
(7, 4, 'billing', '7070 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H7B 7R7'),
(8, 4, 'shipping', '8080 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H8B 8R8'),
(9, 5, 'billing', '9090 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H9B 9R9'),
(10, 5, 'shipping', '1010 Sherbrook Ave', '', 'Montreal', 'QC', 'CA', 'H1B 1R1');

DELETE FROM user_payment_methods;
INSERT INTO user_payment_methods
(id, user_id, payment_type, card_number, cvv2, billing_address_id)
VALUES
(1, 1, 'debit', 1000000000000001, 111, 1),
(2, 2, 'debit', 1000000000000002, 222, 3),
(3, 3, 'credit', 1000000000000003, 333, 5),
(4, 4, 'debit', 1000000000000004, 444, 7),
(5, 5, 'debit', 1000000000000005, 555, 9);

DELETE FROM sellers;
INSERT INTO sellers
(id, username, password, email, first_name, middle_name, last_name, gender, phone)
VALUES
(1, 'John_01', 'John_01', 'John_01@myahoo.com', 'John1', 'A', 'Doe1', 'M', 15556502001),
(2, 'John_02', 'John_02', 'John_02@myahoo.com', 'John2', 'B', 'Doe2', 'M', 15556502002),
(3, 'John_03', 'John_03', 'John_03@myahoo.com', 'John3', 'C', 'Doe3', 'M', 15556502003),
(4, 'John_04', 'John_04', 'John_04@myahoo.com', 'John4', 'D', 'Doe4', 'M', 15556502004),
(5, 'John_05', 'John_05', 'John_05@myahoo.com', 'John5', 'E', 'Doe5', 'M', 15556502005);

DELETE FROM products;
INSERT INTO products
(id, name, description, image, unit_price, seller_id)
VALUES
(1, 'Samsung S6', 'Flagship cellphone from 2015', 'img/samsung_s6.jpg', '300.00', 1),
(2, 'Samsung S6 Edge', 'Another Flagship cellphone from 2015', 'img/samsung_s6e.jpg', '350.00', 1),
(3, 'Samsung S7', 'Flagship cellphone from 2016', 'img/samsung_s7.jpg', '400.00', 2),
(4, 'Samsung S7 Edge', 'Another Flagship cellphone from 2016', 'img/samsung_s7e.jpg', '450.00', 2),
(5, 'Samsung S8', 'Flagship cellphone from 2017', 'img/samsung_s8.jpg', '500.00', 3),
(6, 'Samsung S8 Edge', 'Another Flagship cellphone from 2017', 'img/samsung_s8e.jpg', '550.00', 3),
(7, 'Samsung S9', 'Flagship cellphone from 2018', 'img/samsung_s9.jpg', '600.00', 4),
(8, 'Samsung S9 Edge', 'Another Flagship cellphone from 2018', 'img/samsung_s9e.jpg', '650.00', 4),
(9, 'Samsung S10', 'Flagship cellphone from 2019', 'img/samsung_s10.jpg', '700.00', 4),
(10, 'Learn Java By Examples', 'First Edition', 'img/learn_java_1.jpg', '40.00', 1),
(11, 'Learn Python By Examples', 'Second Edition', 'img/learn_python_2.jpg', '30.00', 1);

DELETE FROM categories;
INSERT INTO categories
(id, name)
VALUES
(1, 'Phones'),
(2, 'Technology'),
(3, 'Ebooks');

DELETE FROM product_categories;
INSERT INTO product_categories
(id, product_id, category_id)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2),
(5, 3, 1),
(6, 3, 2),
(7, 4, 1),
(8, 4, 2),
(9, 5, 1),
(10, 5, 2),
(11, 6, 1),
(12, 6, 2),
(13, 7, 1),
(14, 7, 2),
(15, 8, 1),
(16, 8, 2),
(17, 9, 1),
(18, 9, 2),
(19, 10, 2),
(20, 10, 3),
(21, 11, 2),
(22, 11, 3);

DELETE FROM cart;
INSERT INTO cart
(id, user_id, product_id, quantity)
VALUES
(1, 2, 3, 1),
(2, 4, 10, 2),
(3, 3, 6, 1),
(4, 5, 9, 2),
(5, 5, 8, 1);

DELETE FROM orders;
INSERT INTO orders 
(id, user_id, shipping_address_id, payment_method_id, order_date, shipped_date, delivered_date)
VALUES
(1, 1, 2, 1, '2019-02-02', '2019-03-03', NULL),
(2, 2, 4, 2, '2018-02-02', '2018-03-03', '2018-04-04'),
(3, 2, 4, 2, '2018-06-06', '2018-07-07', '2018-08-08'),
(4, 5, 10, 5, '2019-06-06', NULL, NULL),
(5, 4, 8, 4, '2017-03-03', '2017-04-04', '2017-05-05');

DELETE FROM order_items;
INSERT INTO order_items 
(id, order_id, product_id, unit_price, quantity)
VALUES
(1, 1, 1, '300.00', 2),
(2, 1, 2, '350.00', 1),
(3, 2, 3, '400.00', 1),
(4, 3, 4, '450.00', 5),
(5, 3, 5, '500.00', 1),
(6, 3, 6, '550.00', 2),
(7, 4, 7, '600.00', 3),
(8, 4, 8, '650.00', 1),
(9, 4, 9, '700.00', 2),
(10, 4, 10, '40.00', 1),
(11, 5, 11, '30.00', 10),
(12, 5, 1, '300.00', 3),
(13, 5, 3, '400.00', 5),
(14, 5, 7, '600.00', 1);


############# Views #############

# accounting_items_1
# All products ordered for a date period (not grouped)
CREATE OR REPLACE VIEW v_accounting_items_1 AS
	SELECT
		oi.product_id,
		oi.unit_price,
		oi.quantity,
		oi.unit_price * oi.quantity as total_payment,
		o.id as order_id,
		o.order_date
	FROM
		order_items as oi
		left join
		orders as o on o.id = oi.order_id
	where
		o.order_date BETWEEN '2010-01-01' AND '2020-02-02';

SELECT
    *
FROM
    v_accounting_items_1;	
	


# accounting_items_2
# All products ordered for a date period (grouped)
CREATE OR REPLACE VIEW v_accounting_items_2 AS
	SELECT
		oi.product_id,
		oi.unit_price,
		SUM(oi.quantity) as quantity,
		oi.unit_price * SUM(oi.quantity) as total_payment
	FROM
		orders as o
		join
		order_items as oi on o.id = oi.order_id
	where
		o.order_date BETWEEN '2010-01-01' AND '2020-02-02'
	group by
		oi.product_id;
	
SELECT
*
FROM
v_accounting_items_2;



# accounting_total_1
# All orders for a date period + total payment for each order
CREATE OR REPLACE VIEW v_accounting_total_1 AS
	SELECT 
		src.order_id,
		src.order_date,
		SUM(src.total_payment) as total_payment
	FROM 
		(SELECT
			oi.unit_price * oi.quantity as total_payment,
			o.id as order_id,
			o.order_date as order_date
		FROM
			order_items as oi
			left join
			orders as o on o.id = oi.order_id
		where
			o.order_date BETWEEN '2010-01-01' AND '2022-02-02') AS src
	GROUP BY src.order_id;
	
SELECT
    *
FROM
    v_accounting_total_1;



# accounting_total_2
# Total income for a date period
CREATE OR REPLACE VIEW v_accounting_total_2 AS
	SELECT 
		SUM(src.total_payment) as total_payment
	FROM 
		(SELECT
			oi.unit_price * oi.quantity as total_payment,
			o.id as order_id,
			o.order_date as order_date
		FROM
			order_items as oi
			left join
			orders as o on o.id = oi.order_id
		where
			o.order_date BETWEEN '2010-01-01' AND '2020-02-02') AS src;

SELECT
    *
FROM
    v_accounting_total_2;
	


############# Triggers #############


# Convert negative price to zero
DELIMITER $$
CREATE TRIGGER t_negative_price_check BEFORE INSERT ON
    products FOR EACH ROW
BEGIN
    IF NEW.unit_price < 0 THEN
		SET NEW.unit_price = 0.00;
	END IF; 
END $$
DELIMITER ;
	
# test it
DELETE FROM
    products
WHERE
    unit_price = 0;
	
INSERT INTO products(
    name,
    description,
    image,
    unit_price,
    seller_id
)
VALUES(
    'Samsung S10 Plus',
    'Flagship cellphone from 2019',
    'img/samsung_s10p.jpg',
    '-900.00',
    3
);

SELECT
    *
FROM
    products;
	



############# Queries #############
# 1. Add a new item as a seller
# Add a seller
INSERT INTO sellers(
    username,
    password,
    email,
    first_name,
    middle_name,
    last_name,
    gender,
    phone
)
VALUES(
    'John_06',
    'John_06',
    'John_06@yahoo.com',
    'John6',
    'A',
    'Doe6',
    'M',
    15556502006
);

SELECT
    *
FROM
    sellers;


# B. Add a product
INSERT INTO products(
    name,
    description,
    image,
    unit_price,
    seller_id
)
VALUES(
    'Samsung S10 XS',
    'Flagship cellphone from 2020',
    'img/samsung_s10xs.jpg',
    '1000.00',
    2
);


# 2. Total number of sold items in past month
SELECT
    SUM(src.quantity)
FROM
    (
    SELECT
        oi.product_id,
        oi.unit_price,
        SUM(oi.quantity) AS quantity,
        oi.unit_price * SUM(oi.quantity) AS total_payment
    FROM
        orders AS o
    JOIN order_items AS oi
    ON
        o.id = oi.order_id
    WHERE
        o.order_date BETWEEN '2010-01-01' AND '2020-02-02'
	) AS src;


# 3. Query for total income in CAD (using Views)
SELECT
    *
FROM
    v_accounting_total_2;

	
# 4. Add number of item to shopping cart
INSERT INTO cart
	(user_id, product_id, quantity)
VALUES
	(5, 7, 1),
	(5, 8, 2);


# 5. Set the shipping address
INSERT INTO user_addresses(
    user_id,
    address_type,
    address_line_1,
    address_line_2,
    city,
    province,
    country,
    postal_code
)
VALUES(
    5,
    'shipping',
    '2020 Sherbrook Ave',
    '',
    'Montreal',
    'QC',
    'CA',
    'H2B 2R2'
);


# 6. Set the payment method
INSERT INTO user_payment_methods(
    user_id,
    payment_type,
    card_number,
    cvv2,
    billing_address_id
)
VALUES(
    5,
    'credit',
    7000000000000007,
    789,
    9
);


# Using info from #5 and #6:
INSERT INTO orders(
    user_id,
    shipping_address_id,
    payment_method_id,
    order_date,
    shipped_date,
    delivered_date
)
VALUES(
    5,
    11,
    6,
    '2020-01-01',
    NULL,
    NULL
);