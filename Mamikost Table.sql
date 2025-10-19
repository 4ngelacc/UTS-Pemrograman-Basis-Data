CREATE TABLE owner (
    owner_id serial primary key,
    owner_name varchar(100) not null,
    address text not null,
    phone_number varchar(20) not null,
    email varchar(100) not null,
    created_at timestamp default current_timestamp
);

CREATE TABLE users (
    user_id serial primary key,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    password varchar(255) not null,
    birth_date date not null,
    gender varchar(10) not null check (gender in ('male', 'female')),
    phone_number varchar(20) not null,
    created_at timestamp default current_timestamp
);

CREATE TABLE user_emergency_contacts (
    contact_id serial primary key,
    user_id int not null references users(user_id) on delete cascade,
    contact_name varchar(100) not null,
    relationship varchar(50) not null check (relationship in ('father', 'mother', 'brother', 'sister', 'friend', 'spouse', 'guardian', 'other')),
    phone_number varchar(20) not null,
    is_primary boolean default false,
    created_at timestamp default current_timestamp
);

CREATE TABLE kost (
    kost_id serial primary key,
    kost_name varchar(100) not null,
    total_room int not null default 0,
    number_of_floor int not null,
    type_of_kost varchar(50) not null check (type_of_kost in ('male', 'female', 'mixed')),
    address text not null,
    owner_id int not null references owner(owner_id),
    created_at timestamp default current_timestamp
);

CREATE TABLE room (
    room_id serial primary key,
    room_number varchar(10) not null,
    type varchar(50) not null check (type in ('standard', 'premium', 'vip')),
    price decimal(12,2) not null,
    kost_id int not null references kost(kost_id) on delete cascade,
    is_available boolean default true,
    created_at timestamp default current_timestamp
);

CREATE TABLE payment_methods (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id serial primary key,
    period int not null check (period > 0),
    payment_method_id int not null references payment_methods(id),
    order_date date not null default current_date,
    room_id int not null references room(room_id),
    user_id int not null references users(user_id),
    status varchar(20) not null default 'pending' check (status in ('pending', 'confirmed', 'cancelled', 'completed')),
    created_at timestamp default current_timestamp
);

CREATE TABLE invoice (
    invoice_id serial primary key,
    order_id int not null references orders(order_id) unique,
    invoice_date date not null default current_date,
    due_date date not null,
    status varchar(20) not null default 'unpaid' check (status in ('unpaid', 'paid', 'overdue', 'cancelled')),
    created_at timestamp default current_timestamp
);

CREATE TABLE rating (
    rating_id serial primary key,
    user_id int not null references users(user_id),
    kost_id int not null references kost(kost_id),
    rate_value int not null check (rate_value >= 1 and rate_value <= 5),
    comment text not null,
    created_at timestamp default current_timestamp
);





