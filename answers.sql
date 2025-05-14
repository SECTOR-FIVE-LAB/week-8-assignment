
-- USERS
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) UNIQUE NOT NULL,
    password VARCHAR(64),
    firstname VARCHAR(64),
    lastname VARCHAR(64),
    phone VARCHAR(32),
    email VARCHAR(255),
    role VARCHAR(50),
    creation_date DATETIME,
    created_by INT,
    updated_date DATETIME,
    updated_by INT
);

-- ISP / COMPANY
CREATE TABLE isp (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    domain VARCHAR(255),
    subdomain VARCHAR(255),
    country VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(255),
    created_by INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- BILLING PLAN
CREATE TABLE billing_plan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128),
    plan_group VARCHAR(128),
    cost INT,
    setup_cost INT,
    tax VARCHAR(128),
    currency VARCHAR(128),
    recurring VARCHAR(32),
    recurring_period VARCHAR(128),
    billing_schedule VARCHAR(128),
    is_active BOOLEAN,
    isp_id INT,
    dashboard VARCHAR(255)
);

CREATE TABLE plan_bandwidth (
    plan_id INT PRIMARY KEY,
    up VARCHAR(128),
    down VARCHAR(128),
    FOREIGN KEY (plan_id) REFERENCES billing_plan(id)
);

CREATE TABLE plan_traffic (
    plan_id INT PRIMARY KEY,
    total VARCHAR(128),
    up VARCHAR(128),
    down VARCHAR(128),
    refill_cost VARCHAR(128),
    FOREIGN KEY (plan_id) REFERENCES billing_plan(id)
);

CREATE TABLE plan_time (
    plan_id INT PRIMARY KEY,
    time_bank VARCHAR(128),
    time_type VARCHAR(128),
    refill_cost VARCHAR(128),
    FOREIGN KEY (plan_id) REFERENCES billing_plan(id)
);

-- PAYMENTS
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_type VARCHAR(40),
    trans_id VARCHAR(40),
    trans_time DATETIME,
    amount DECIMAL(10,2),
    bill_ref_number VARCHAR(40),
    invoice_number VARCHAR(40),
    account_balance VARCHAR(40),
    third_party_trans_id VARCHAR(40),
    msisdn VARCHAR(100),
    payer_name VARCHAR(40),
    payer_id INT,
    isp_id INT,
    system_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- MESSAGES AND DELIVERIES
CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    content TEXT,
    ref_id VARCHAR(255),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE deliveries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message_id INT,
    delivery_status VARCHAR(50),
    reason VARCHAR(50),
    delivery_time DATETIME,
    FOREIGN KEY (message_id) REFERENCES messages(id)
);

-- INVOICES
CREATE TABLE invoice_status (
    id INT PRIMARY KEY,
    value VARCHAR(32) NOT NULL,
    notes VARCHAR(128)
);

CREATE TABLE invoice_type (
    id INT PRIMARY KEY,
    value VARCHAR(32) NOT NULL,
    notes VARCHAR(128)
);

CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    batch_id INT,
    date DATETIME,
    status_id INT,
    type_id INT,
    notes TEXT,
    creation_date DATETIME,
    created_by INT,
    updated_date DATETIME,
    updated_by INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (status_id) REFERENCES invoice_status(id),
    FOREIGN KEY (type_id) REFERENCES invoice_type(id)
);

CREATE TABLE invoice_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT,
    plan_id INT,
    amount DECIMAL(10,2),
    tax_amount DECIMAL(10,2),
    total DECIMAL(10,2),
    notes TEXT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (plan_id) REFERENCES billing_plan(id)
);
