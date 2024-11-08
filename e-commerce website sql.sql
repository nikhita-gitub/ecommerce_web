create database Ecommerce;
CREATE TABLE `tblcart`(
`id` bigint NOT NULL AUTO_INCREMENT,
`discount_ price` varchar(200) DEFAULT NULL,
`quantity` int NOT NULL,
`total_price` varchar(200) DEFAULT NULL,
`item_price` varchar(100) Default NULL,
`product_id` bigint NOT NULL,
`coupon_code` varchar(200) default NULL,
primary key(`id`));


Create table tbladmin(
	`id` bigint not null auto_increment,
    `added_date` datetime not null,
    `email` varchar(100) not null,
    `password` varchar(100) not null,
    `name` varchar(100) not null,
    primary key(`id`));
    
CREATE TABLE `tblcustomer` (
 `id` int NOT NULL AUTO_INCREMENT,
 `address` varchar(255) NOT NULL,
 `added_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
 `email` varchar(100) NOT NULL,
 `gender` varchar(6) NOT NULL,
 `name` varchar(50) NOT NULL,
 `password` varchar(60) NOT NULL,
 `phone` varchar(200) NOT NULL,
 `pin_code` varchar(255) NOT NULL,
 PRIMARY KEY (`id`)
) ;

Alter table tblcustomer drop column address;
Alter table tblcustomer drop column gender;
Alter table tblcustomer drop column phone;
Alter table tblcustomer drop column pin_code;
ALTER TABLE tblcustomer ADD COLUMN password1 VARCHAR(255);


CREATE TABLE `tblorders` (
 `id` int NOT NULL AUTO_INCREMENT,
 `order_no` int DEFAULT NULL,
 `customer_name` varchar(200) DEFAULT NULL,
 `mobile_number` varchar(100) DEFAULT NULL,
 `email_id` varchar(100) DEFAULT NULL,
 `address` varchar(400) DEFAULT NULL,
 `address_type` varchar(100) DEFAULT NULL,
 `pincode` varchar(100) DEFAULT NULL,
 `image` varchar(200) DEFAULT NULL,
 `product_name` varchar(400) DEFAULT NULL,
 `quantity` int(11) DEFAULT NULL,
 `product_price` varchar(100) DEFAULT NULL,
 `product_selling_price` varchar(100) DEFAULT NULL,
 `product_total_price` varchar(100) DEFAULT NULL,
 `order_status` varchar(100) DEFAULT NULL,
 `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
 
 PRIMARY KEY (`id`)
) ;

CREATE TABLE `tblproduct` (
 `id` bigint NOT NULL AUTO_INCREMENT,
 `active` varchar(100) DEFAULT NULL,
 `code` varchar(5) DEFAULT NULL,
 `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `description` varchar(255) DEFAULT NULL,
 `image` varchar(100) DEFAULT NULL,
 `image_name` varchar(400) DEFAULT NULL,
 `name` varchar(30) DEFAULT NULL,
 `price` varchar(200) DEFAULT NULL,
 `mrp_price` varchar(200) DEFAULT NULL,
 `product_category` varchar(100) DEFAULT NULL,
 PRIMARY KEY (`id`)
) ;

INSERT IGNORE INTO tbladmin(email,password,name) VALUES('admin@gmail.com','admin','admin');
select* from tblcustomer;
    