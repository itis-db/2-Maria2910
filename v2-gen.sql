drop table if exists orders;
drop table if exists customers;
drop table if exists products;
drop table if exists categories;
drop table if exists employees;
drop table if exists suppliers;

create table if not exists customers
(
    customer_id serial primary key,
    name        text not null,
    phone       text,
    email       text unique,
    address     text
);

create table if not exists employees
(
    employee_id serial primary key,
    name        text not null,
    position    text,
    hire_date   date default current_date
);

create table if not exists orders
(
    order_id    serial primary key,
    order_date  date default current_date,
    customer_id integer not null references customers(customer_id),
    employee_id integer not null references employees(employee_id)
);

create table if not exists categories
(
    category_id serial primary key,
    name        text not null unique,
    description text
);

create table if not exists suppliers
(
    supplier_id serial primary key,
    name        text not null,
    phone       text,
    email       text unique,
    address     text
);

create table if not exists products
(
    product_id   serial primary key,
    name         text not null,
    price        numeric(10, 2) not null,
    stock        integer check (stock >= 0),
    category_id  integer not null references categories(category_id),
    supplier_id  integer not null references suppliers(supplier_id)
);

insert into categories(name, description)
select 'Category '  i, 'Description for category '  i
from generate_series(1, 500) as i;

insert into suppliers(name, phone, email, address)
select 'Supplier ' || i,
       '+7' || lpad((random() * 1000000000)::int::text, 10, '0'),
       'supplier'  i  '@example.com',
       'Address ' || i
from generate_series(1, 500) as i;

insert into products(name, price, stock, category_id, supplier_id)
select 'Product ' || i,
       round(random() * 1000 + 10)::numeric(10, 2),
       (random() * 100)::int,
       (random() * (select count(*) from categories) + 1)::int,
       (random() * (select count(*) from suppliers) + 1)::int
from generate_series(1, 500) as i;


insert into customers(name, phone, email, address)
select 'Customer ' || i,
       '+7' || lpad((random() * 1000000000)::int::text, 10, '0'),
       'customer'  i  '@example.com',
       'Address ' || i
from generate_series(1, 500) as i;

insert into employees(name, position, hire_date)
select 'Employee ' || i,
       'Position ' || (random() * 5 + 1)::int,
       current_date - (random() * 365 * 5)::int
from generate_series(1, 500) as i;

insert into orders(order_date, customer_id, employee_id)
select current_date - (random() * 365)::int,
       (random() * 499 + 1)::int,
       (random() * 499 + 1)::int
from generate_series(1, 500) as i;
