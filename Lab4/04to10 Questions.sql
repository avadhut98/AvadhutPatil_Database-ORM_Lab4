-- 4) Display the total number of customers based on gender who have placed individual orders of worth at least Rs.3000.
SELECT COUNT(o.CUS_ID) NoOfCustomers, c.CUS_GENDER FROM `order` o
	JOIN customer c
    ON o.CUS_ID = c.CUS_ID
	WHERE o.ORD_AMOUNT >= 3000
    GROUP BY c.CUS_GENDER;

-- SELECT * FROM `order`;


-- 5) Display all the orders along with product name ordered by a customer having Customer_Id=2

SELECT o.*, p.PRO_ID
	FROM `order` o 
	JOIN supplier_pricing sp JOIN product p
    ON (o.PRICING_ID = sp.PRICING_ID AND sp.PRO_ID = P.PRO_ID)
    WHERE CUS_ID = 2;



-- 6) Display the Supplier details who can supply more than one product.

SELECT s.*, NoOfProducts 
	FROM supplier s  JOIN 
		(SELECT SUPP_ID, COUNT(PRO_ID) NoOfProducts FROM supplier_pricing
        GROUP BY SUPP_ID
        HAVING NoOfProducts > 1) sp
	ON s.SUPP_ID = sp.SUPP_ID;



-- 7) Find the least expensive product from each category and print the table with category id, name, product name and price of the product

SELECT c.*, p.PRO_NAME, MIN(sp.SUPP_PRICE) Minimal_Product_Price 
	FROM category c JOIN supplier_pricing sp JOIN product p 
    ON c.CAT_ID = p.CAT_ID AND p.PRO_ID = sp.PRO_ID
    GROUP BY sp.PRO_ID;
    

/*
SELECT CAT_ID, PRO_NAME, MIN(SUPP_PRICE) Minimal_Product_Price 
FROM
	(SELECT c.*, p.PRO_NAME, sp.SUPP_PRICE Product_Price 
		FROM category c JOIN supplier_pricing sp JOIN product p 
		ON c.CAT_ID = p.CAT_ID AND p.PRO_ID = sp.PRO_ID) a
GROUP BY CAT_ID;
desc `ORDER`;	
DESC supplier_pricing;
alter table `ORDER` rename COLUMN ORDER_DATE TO ORD_DATE;
    
    */
    
-- 8) Display the Id and Name of the Product ordered after “2021-10-05”.

SELECT p.PRO_ID, p.PRO_NAME
	FROM product p JOIN supplier_pricing sp JOIN `order` o 
    ON p.PRO_ID = sp.PRO_ID AND sp.PRICING_ID = o.PRICING_ID
    WHERE o.ORD_DATE >= '2021-10-05'
    GROUP BY p.PRO_ID;



-- 9) Display customer name and gender whose names start or end with character 'A'.

SELECT CUS_NAME, CUS_GENDER
	FROM customer
    WHERE CUS_NAME LIKE 'A%';


-- 10) Create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and
-- Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average
-- Service” else print “Poor Service”. Note that there should be one rating per supplier.

-- Procedure

DELIMITER &&
CREATE
	DEFINER = `root`@`localhost` 
    PROCEDURE `DisplaySupplierRatingDetails`()
BEGIN
	SELECT SUPP_ID, SUPP_NAME, AverageRating, 
		CASE
			WHEN AverageRating = 5 THEN 'Excellent Service'
			WHEN AverageRating > 4 THEN 'Good Service'
			WHEN AverageRating > 2 THEN 'Average Service'
			ELSE 'Poor Service'
		END As ServiceType
	FROM (
		SELECT s.SUPP_ID, s.SUPP_NAME, avg(r.RAT_RATSTARS) AverageRating
		FROM rating r
			JOIN `order` o
			JOIN supplier_pricing sp
			JOIN supplier s
		ON (
			r.ORD_ID = o.ORD_ID AND
			o.PRICING_ID = sp.PRICING_ID AND
			sp.SUPP_ID = s.SUPP_ID)
		GROUP BY supp_id
		) as sr;
END;&&

DELIMITER ; 


-- Call Procedure

call DisplaySupplierRatingDetails();



