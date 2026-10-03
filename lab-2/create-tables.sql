DROP TABLE IF EXISTS lawyers_cases;
DROP TABLE IF EXISTS lawyers_specializations;
DROP TABLE IF EXISTS cases;

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS lawyers;
DROP TABLE IF EXISTS specializations;


CREATE TABLE customers (
    id INT PRIMARY KEY,
    first_name VARCHAR(256) NOT NULL,
    last_name VARCHAR(256) NOT NULL,
    gender VARCHAR(32) NOT NULL CHECK(gender in ('Male', 'Female')),
    address VARCHAR(256),
    passport_data VARCHAR(32) NOT NULL UNIQUE,
    phone_number VARCHAR(32) NOT NULL UNIQUE,
    email VARCHAR(256) UNIQUE
);

CREATE TABLE lawyers (
    id INT PRIMARY KEY,
    first_name VARCHAR(256) NOT NULL,
    last_name VARCHAR(256) NOT NULL,
    address VARCHAR(256),
    phone_number VARCHAR(32) NOT NULL UNIQUE,
    work_experience INT NOT NULL DEFAULT 0 CHECK(work_experience >= 0)
);

CREATE TABLE specializations (
    id INT PRIMARY KEY,
    name VARCHAR(256) NOT NULL UNIQUE
);

CREATE TABLE cases (
    id INT PRIMARY KEY,
    number VARCHAR(256) NOT NULL,
    start_date DATE NOT NULL,
    finish_date DATE,
    maximum_sentence VARCHAR(256),
    imposed_sentence VARCHAR(256),
    type_of_sentence VARCHAR(256),
    amount_of_penalty DECIMAL(15, 2),
    status VARCHAR(32) NOT NULL DEFAULT 'Begins' CHECK(status in ('Commencing', 'In progress', 'Concluded')), -- Commencing, In progress, Concluded
    result VARCHAR(256),
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE NO ACTION
);

CREATE TABLE lawyers_specializations (
    lawyer_id INT,
    specializations_id INT,
    PRIMARY KEY (lawyer_id, specializations_id),
    FOREIGN KEY (lawyer_id) REFERENCES lawyers(id) ON DELETE CASCADE,
    FOREIGN KEY (specializations_id) REFERENCES specializations(id) ON DELETE CASCADE
);

CREATE TABLE lawyers_cases (
    lawyer_id INT,
    case_id INT,
    PRIMARY KEY (lawyer_id, case_id),
    FOREIGN KEY (lawyer_id) REFERENCES lawyers(id) ON DELETE CASCADE,
    FOREIGN KEY (case_id) REFERENCES cases(id) ON DELETE NO ACTION
);
