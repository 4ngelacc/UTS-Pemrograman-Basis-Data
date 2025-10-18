
);

CREATE TABLE IF NOT EXISTS "user" (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender VARCHAR(10),
    user_parent_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS user_emergency_contacts (
    contact_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    emergency_number VARCHAR(20) NOT NULL,
    relationship VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS kost (
    kost_id SERIAL PRIMARY KEY,
    kost_name VARCHAR(100) NOT NULL,
    total_room INTEGER,
    number_of_floor INTEGER,
    type_of_kost VARCHAR(20),
    address VARCHAR(255),
    owner_id INTEGER
);

CREATE TABLE IF NOT EXISTS room (
    room_id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    price DECIMAL(10,2),
    number_room INTEGER,
    kost_id INTEGER
);

CREATE TABLE IF NOT EXISTS "order" (
    order_id SERIAL PRIMARY KEY,
    period INTEGER,
    payment_method VARCHAR(50),
    order_date DATE,
    room_id INTEGER,
    user_id INTEGER
);

CREATE TABLE IF NOT EXISTS invoice (
    invoice_id SERIAL PRIMARY KEY,
    order_id INTEGER,
    invoice_date DATE,
    status VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS rating (
    rating_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    kost_id INTEGER,
    rate_value INTEGER CHECK (rate_value >= 1 AND rate_value <= 5),
    comment TEXT
);



