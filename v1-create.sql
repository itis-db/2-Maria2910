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


create table if not exists orders
(
    order_id    serial primary key,
    order_date  date default current_date,
    customer_id integer not null references customers(customer_id),
    employee_id integer not null references employees(employee_id)
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

create table if not exists categories
(
    category_id serial primary key,
    name        text not null unique,
    description text
);

create table if not exists employees
(
    employee_id serial primary key,
    name        text not null,
    position    text,
    hire_date   date default current_date
);

create table if not exists suppliers
(
    supplier_id serial primary key,
    name        text not null,
    phone       text,
    email       text unique,
    address     text
);

insert into customers(name, phone, email, address)
values
    ('Иван Иванов', '+7123456789', 'ivan.ivanov@example.com', 'ул. Ленина, д. 1'),
    ('Мария Смирнова', '+7987654321', 'maria.smirnova@example.com', 'ул. Пушкина, д. 10'),
    ('Алексей Кузнецов', '+7192837465', 'alexey.kuznetsov@example.com', 'ул. Чехова, д. 20');

insert into employees(name, position)
values
    ('Алина Соколова', 'Менеджер'),
    ('Борис Петров', 'Продавец-консультант'),
    ('Виктория Орлова', 'Специалист поддержки');

insert into categories(name, description)
values
    ('Электроника', 'Электронные устройства и аксессуары'),
    ('Бытовая техника', 'Приборы для дома'),
    ('Книги', 'Различные жанры книг');

insert into suppliers(name, phone, email, address)
values
    ('Техно Поставка', '+7987654321', 'contact@technosupply.ru', 'пр-т Технопарковый, д. 5'),
    ('Домашние Товары', '+7564738291', 'info@homegoods.ru', 'ул. Домашняя, д. 15'),
    ('Мир Книг', '+7123987654', 'support@bookworld.ru', 'ул. Книжная, д. 25');

insert into products(name, price, stock, category_id, supplier_id)
values
    ('Смартфон', 500.00, 50, 1, 1),
    ('Ноутбук', 1200.00, 30, 1, 1),
    ('Холодильник', 800.00, 20, 2, 2),
    ('Микроволновка', 150.00, 40, 2, 2),
    ('Роман', 15.00, 100, 3, 3),
    ('Научная книга', 25.00, 60, 3, 3);

insert into orders(order_date, customer_id, employee_id)
values
    (current_date, 1, 1),
    (current_date, 2, 2),
    (current_date, 3, 3);
