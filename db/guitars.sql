DROP TABLE IF EXISTS guitars;
DROP TABLE IF EXISTS shops;
DROP TABLE IF EXISTS manufacturers;

CREATE TABLE manufacturers
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);
CREATE TABLE shops
(
  id SERIAL PRIMARY KEY,
  till INT
);
CREATE TABLE guitars
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  description VARCHAR(255),
  stock_quantity INT,
  buying_cost INT,
  selling_price INT,
  manufacturer_id INT REFERENCES manufacturers(id),
  shop_id INT REFERENCES shops(id)
);
