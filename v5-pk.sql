BEGIN;

CREATE UNIQUE INDEX IF NOT EXISTS customers_phone_email_idx ON customers (phone, email);

CREATE UNIQUE INDEX IF NOT EXISTS employees_name_hire_date_idx ON employees (name, hire_date);

CREATE UNIQUE INDEX IF NOT EXISTS suppliers_phone_email_idx ON suppliers (phone, email);

CREATE UNIQUE INDEX IF NOT EXISTS products_name_category_idx ON products (name, category_id);

CREATE UNIQUE INDEX IF NOT EXISTS orders_order_date_customer_employee_idx ON orders (order_date, customer_id, employee_id);

ALTER TABLE orders DROP CONSTRAINT orders_customer_id_fkey;
ALTER TABLE orders DROP CONSTRAINT orders_employee_id_fkey;
ALTER TABLE orders ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (order_date, customer_id, employee_id) REFERENCES orders (order_date, customer_id, employee_id);
ALTER TABLE orders ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (order_date, customer_id, employee_id) REFERENCES orders (order_date, customer_id, employee_id);
ALTER TABLE orders DROP COLUMN order_id;
ALTER TABLE orders ADD PRIMARY KEY (order_date, customer_id, employee_id);

ALTER TABLE products DROP CONSTRAINT products_category_id_fkey;
ALTER TABLE products DROP CONSTRAINT products_supplier_id_fkey;
ALTER TABLE products ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (name, category_id) REFERENCES products (name, category_id);
ALTER TABLE products ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (name, category_id) REFERENCES products (name, category_id);
ALTER TABLE products DROP COLUMN product_id;
ALTER TABLE products ADD PRIMARY KEY (name, category_id);

ALTER TABLE customers DROP CONSTRAINT customers_pkey;
ALTER TABLE customers ADD PRIMARY KEY (phone, email);

ALTER TABLE employees DROP CONSTRAINT employees_pkey;
ALTER TABLE employees ADD PRIMARY KEY (name, hire_date);

ALTER TABLE suppliers DROP CONSTRAINT suppliers_pkey;
ALTER TABLE suppliers ADD PRIMARY KEY (phone, email);

ALTER TABLE categories DROP CONSTRAINT categories_pkey;
ALTER TABLE categories ADD PRIMARY KEY (name);

COMMIT;


BEGIN;

ALTER TABLE orders DROP CONSTRAINT orders_pkey;
ALTER TABLE orders ADD COLUMN order_id serial primary key;
ALTER TABLE orders DROP CONSTRAINT orders_customer_id_fkey;
ALTER TABLE orders DROP CONSTRAINT orders_employee_id_fkey;
ALTER TABLE orders ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE orders ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE products DROP CONSTRAINT products_pkey;
ALTER TABLE products ADD COLUMN product_id serial primary key;
ALTER TABLE products DROP CONSTRAINT products_category_id_fkey;
ALTER TABLE products DROP CONSTRAINT products_supplier_id_fkey;
ALTER TABLE products ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);
ALTER TABLE products ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);

ALTER TABLE customers DROP CONSTRAINT customers_pkey;
ALTER TABLE customers ADD COLUMN customer_id serial primary key;

ALTER TABLE employees DROP CONSTRAINT employees_pkey;
ALTER TABLE employees ADD COLUMN employee_id serial primary key;

ALTER TABLE suppliers DROP CONSTRAINT suppliers_pkey;
ALTER TABLE suppliers ADD COLUMN supplier_id serial primary key;

ALTER TABLE categories DROP CONSTRAINT categories_pkey;
ALTER TABLE categories ADD COLUMN category_id serial primary key;

DROP INDEX IF EXISTS customers_phone_email_idx;
DROP INDEX IF EXISTS employees_name_hire_date_idx;
DROP INDEX IF EXISTS suppliers_phone_email_idx;
DROP INDEX IF EXISTS products_name_category_idx;
DROP INDEX IF EXISTS orders_order_date_customer_employee_idx;

COMMIT;
