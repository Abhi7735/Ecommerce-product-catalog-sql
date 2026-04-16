CREATE TABLE products(
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sku_code CHAR(8) UNIQUE NOT NULL,
  price NUMERIC(10,2) CHECK (price > 0),
  stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
  is_available BOOLEAN DEFAULT TRUE,
  category TEXT NOT NULL,
  adden_on DATE DEFAULT CURRENT_DATE,
  last_update TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (name, sku_code, price , stock_quantity, is_available, category)
VALUES
('Wireless Mouse', 'WM123456', 699.99, 50, TRUE, 'Electronics'),
('Bluetooth Speaker', 'BS234567', 1499.00, 30, TRUE, 'Electronics'),
('Laptop Stand', 'LS345678', 799.50, 20, TRUE, 'Accessories'),
('USB-C Hub', 'UC456789', 1299.99, 15, TRUE, 'Accessories'),
('Notebook', 'NB567890', 99.99, 100, TRUE, 'Stationery'),
('Pen Set', 'PS678901', 199.00, 200, TRUE, 'Stationery'),
('Coffee Mug', 'CM789012', 299.00, 75, TRUE, 'Home & Kitchen'),
('LED Desk Lamp', 'DL890123', 899.00, 40, TRUE, 'Home & Kitchen'),
('Yoga Mat', 'YM901234', 499.00, 25, TRUE, 'Fitness'),
('Water Bottle', 'WB012345', 349.00, 60, TRUE, 'Fitness');



-- TEST :- 1(CLAUSES)
select *from Products;
--  Show the name and price of all products.
select name,price from products;
-- Show all products where the category is 'Electronics'.
select * from products where category = 'Electronics'
--  Group products by category. Show each category once.
select category from products Group by category;
-- Show categories that have more than 1 product.
select category, count(*) from products group by category having count(*)>1
-- Show all products sorted by price in ascending order.
select * from products order by price ASC;
-- Show only the first 3 products from the table.
select * from products limit 3;
-- Show product name as "Item\_Name" and price as "Item\_Price".
select name as item_name , price as item_price from products;
-- Show all the unique categories from the products table.
select  distinct category from products;


-- TEST:-2(OPERATORS)

-- Q1. Display the name and price of the cheapest product in the entire table.
select name , price from products
where price =(select min(price)from products);
-- ind the average price of products that belong to 'Home & Kitchen' or 'Fitness'.
select avg(price) as avg_price from products where category in ('Home & Kitchen','Fitness');
-- Q3. Show product names and stock quantity where product is available, stock > 50, and price != 299.
select name , stock_quantity from products where is_available = true and stock_quantity>50 and price!=299;
-- Q4. Find the most expensive product in each category.
select category , max(price) as max_price from products group by category;
-- Show all unique categories in uppercase, sorted in descending order.
select distinct upper (category)  as cat_upper from products order by cat_upper desc;

-- TEST :- 3(CASE)
-- one important question inside is_available column you have boolean true and false. show case a new column to with in_stock and out of stock 
select name ,
case
  When is_available then 'in_stock'
  else 'out of stock'
 end as availabily_stock
 from products;

-- Show pro duct, name, stock, quantity, and label: 
-- High stock, if quantity, > 100
-- Medium if between 30 and 100
-- Low stock otherwise

select name,stock_quantity,
case 
 when stock_quantity>100 then 'High stock'
 when stock_quantity between 30 and 100 then 'Medium stock'
 else 'low stock'
 end as stocklevel
 from products;

 
