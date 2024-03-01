-- Table Creation for ecommerce databases

-- 1. table supplier
CREATE TABLE 
	IF NOT EXISTS supplier (
		SUPP_ID INT primary key,
        SUPP_NAME VARCHAR(50) NOT NULL,
        SUPP_CITY VARCHAR(50) NOT NULL,
        SUPP_PHONE VARCHAR(50) NOT NULL
        );
        
-- DESC supplier;

-- 2. Table Customer

 CREATE TABLE 
	IF NOT EXISTS customer (
		CUS_ID INT PRIMARY KEY,
        CUS_NAME VARCHAR(20) NOT NULL,
        CUS_PHONE VARCHAR(10) NOT NULL,
        CUS_CITY VARCHAR(30) NOT NULL,
        CUS_GENDER CHAR
        );
        
-- DESC customer;

-- 3. Category

CREATE TABLE 
	IF NOT EXISTS category (
		CAT_ID INT PRIMARY KEY,
        CAT_NAME VARCHAR(20) NOT NULL
        );
        
-- DESC category;


-- 4. Product

CREATE TABLE 
	IF NOT EXISTS product (
		PRO_ID INT PRIMARY KEY,
        PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
        PRO_DESC VARCHAR(60),
        CAT_ID INT NOT NUll,
        FOREIGN KEY (CAT_ID) REFERENCES category (CAT_ID)
        );
        
-- DESC product;


-- 5. Supplier_Pricing

CREATE TABLE 
	IF NOT EXISTS supplier_pricing (
		PRICING_ID INT PRIMARY KEY,
        PRO_ID INT NOT NULL,
        SUPP_ID INT NOT NULL,
        SUPP_PRICE INT DEFAULT 0,
        FOREIGN KEY (PRO_ID) REFERENCES product (PRO_ID),
        FOREIGN KEY (SUPP_ID) REFERENCES supplier (SUPP_ID)
        );
        
-- DESC supplier_pricing;

-- 6. Order
CREATE TABLE 
	IF NOT EXISTS `order` (
		ORD_ID INT PRIMARY KEY,
        ORD_AMOUNT INT NOT NULL,
        ORD_DATE DATE NOT NULL,
        CUS_ID INT NOT NULL,
        PRICING_ID INT NOT NULL,
        FOREIGN KEY (CUS_ID) REFERENCES customer (CUS_ID),
        FOREIGN KEY (PRICING_ID) REFERENCES supplier_pricing (PRICING_ID)
        );
        
-- DESC `order`;

-- 7. rating

CREATE TABLE 
	IF NOT EXISTS rating (
		RAT_ID INT PRIMARY KEY,
        ORD_ID INT NOT NUll,
        RAT_RATSTARS INT NOT NULL,
        FOREIGN KEY (ORD_ID) REFERENCES `order` (ORD_ID)
        );
        
-- DESC rating;

-- show tables;








        