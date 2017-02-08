CREATE TABLE Customer (
  id INT identity(1, 1) primary key,
  name VARCHAR(45) NOT NULL ,
  email VARCHAR(45) NOT NULL ,
  phone VARCHAR(45) NOT NULL ,
  address VARCHAR(45) NOT NULL ,
  city_region VARCHAR(2) NOT NULL ,
  cc_number VARCHAR(19) NOT NULL
  );

CREATE TABLE CustomerOrder (
  id INT identity(1, 1) primary key,
  amount DECIMAL(6,2) NOT NULL ,
  date_created datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  confirmation_number INT NOT NULL ,
  customer_id INT NOT NULL ,
  INDEX fk_customer_order_customer (customer_id ASC) ,
  CONSTRAINT fk_customer_order_customer
    FOREIGN KEY (customer_id )
    REFERENCES customer (id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
	);

CREATE TABLE Category (
  id TINYINT identity(1, 1) primary key,
  name VARCHAR(45) NOT NULL
  );

CREATE TABLE Product (
  id INT identity(1, 1) primary key,
  name VARCHAR(45) NOT NULL ,
  price DECIMAL(5,2) NOT NULL ,
  description nvarchar(50) NULL ,
  last_update datetime not null default current_timestamp,
  category_id TINYINT NOT NULL ,
  INDEX fk_product_category (category_id ASC) ,
  CONSTRAINT fk_product_category
    FOREIGN KEY (category_id )
    REFERENCES category (id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE OrderedProduct (
  customer_order_id INT not null,
  product_id INT NOT NULL ,
  quantity SMALLINT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (customer_order_id, product_id) ,
  INDEX fk_ordered_product_customer_order (customer_order_id ASC) ,
  INDEX fk_ordered_product_product (product_id ASC) ,
  CONSTRAINT fk_ordered_product_customer_order
    FOREIGN KEY (customer_order_id )
    REFERENCES customerorder (id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ordered_product_product
    FOREIGN KEY (product_id )
    REFERENCES product (id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO category (name) VALUES ('dairy'),('meats'),('bakery'),('fruit & veg');

select * from Category

INSERT INTO product (name, price, description, category_id) VALUES ('Milk', 1.70, 'Semi skimmed (1L)', 1);
INSERT INTO product (name, price, description, category_id) VALUES ('Cheese', 2.39, 'Mild cheddar (330g)', 1);
INSERT INTO product (name, price, description, category_id) VALUES ('Butter', 1.09, 'Unsalted (250g)', 1);
INSERT INTO product (name, price, description, category_id) VALUES ('Free range eggs', 1.76, 'Medium-sized (6 eggs)', 1);

INSERT INTO product (name, price, description, category_id) VALUES ('Organic meat patties', 2.29, 'Rolled in fresh herbs<br>2 patties (250g)', 2);
INSERT INTO product (name, price, description, category_id) VALUES ('Parma ham', 3.49, 'Matured, organic (70g)', 2);
INSERT INTO product (name, price, description, category_id) VALUES ('Chicken leg', 2.59, 'Free range (250g)', 2);
INSERT INTO product (name, price, description, category_id) VALUES ('Sausages', 3.55, 'Reduced fat, pork<br>3 sausages (350g)', 2);

INSERT INTO product (name, price, description, category_id) VALUES ('Sunflower seed loaf', 1.89, '600g', 3);
INSERT INTO product (name, price, description, category_id) VALUES ('Sesame seed bagel', 1.19, '4 bagels', 3);
INSERT INTO product (name, price, description, category_id) VALUES ('Pumpkin seed bun', 1.15, '4 buns', 3);
INSERT INTO product (name, price, description, category_id) VALUES ('Chocolate cookies', 2.39, 'Contain peanuts<br>(3 cookies)', 3);

INSERT INTO product (name, price, description, category_id) VALUES ('Corn on the cob', 1.59, '2 pieces', 4);
INSERT INTO product (name, price, description, category_id) VALUES ('Red currants', 2.49, '150g', 4);
INSERT INTO product (name, price, description, category_id) VALUES ('Broccoli', 1.29, '500g', 4);
INSERT INTO product (name, price, description, category_id) VALUES ('Seedless watermelon', 1.49, '250g', 4);

SELECT * from Product

SELECT * FROM category, product WHERE category.id = product.category_id

select * from Product

select name from product where category_id = 4