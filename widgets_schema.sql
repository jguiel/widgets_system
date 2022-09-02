-- Initialize DB
create database widget_sales;
use widget_sales;
show tables;

-- Create widget product table
CREATE TABLE `widget_sales`.`widgets` (
  `widget_id` INT UNSIGNED NOT NULL,
  `widget_name` VARCHAR(45) NOT NULL,
  `cost_manufacture` VARCHAR(45) NOT NULL,
  `min_quantity` VARCHAR(45) NULL,
  PRIMARY KEY (`widget_id`));
  
-- Create order item table
CREATE TABLE `widget_sales`.`order_item` (
  `order_item_id` INT UNSIGNED NOT NULL,
  `widget_id` INT UNSIGNED NOT NULL,
  `quantity_per_package` INT UNSIGNED NOT NULL,
  `supplier_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_item_id`));
  
-- Create supplier table
CREATE TABLE `widget_sales`.`supplier` (
  `supplier_id` INT UNSIGNED NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `warehouse_location` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`supplier_id`));
  
-- Create orders table
CREATE TABLE `widget_sales`.`orders` (
  `order_id` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  `widget_id` INT UNSIGNED NOT NULL,
  `supplier_id` INT UNSIGNED NOT NULL,
  `order_item_id` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `price` DECIMAL NOT NULL,
  PRIMARY KEY (`order_id`));
  
-- Create customer table
CREATE TABLE `widget_sales`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`));
  
-- Create FK references
ALTER TABLE `widget_sales`.`orders` 
ADD INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE,
ADD INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
ADD INDEX `widget_id_idx` (`widget_id` ASC) VISIBLE,
ADD INDEX `order_item_id_idx` (`order_item_id` ASC) VISIBLE;
;
ALTER TABLE `widget_sales`.`orders` 
ADD CONSTRAINT `customer_id`
  FOREIGN KEY (`customer_id`)
  REFERENCES `widget_sales`.`customer` (`customer_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `supplier_id`
  FOREIGN KEY (`supplier_id`)
  REFERENCES `widget_sales`.`supplier` (`supplier_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `widget_id`
  FOREIGN KEY (`widget_id`)
  REFERENCES `widget_sales`.`widgets` (`widget_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `order_item_id`
  FOREIGN KEY (`order_item_id`)
  REFERENCES `widget_sales`.`order_item` (`order_item_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `widget_sales`.`order_item` 
ADD INDEX `widget_id_idx` (`widget_id` ASC) VISIBLE,
ADD INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE;
;
ALTER TABLE `widget_sales`.`order_item` 
ADD CONSTRAINT `order_item_widget_id`
  FOREIGN KEY (`widget_id`)
  REFERENCES `widget_sales`.`widgets` (`widget_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `order_item_supplier_id`
  FOREIGN KEY (`supplier_id`)
  REFERENCES `widget_sales`.`supplier` (`supplier_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;