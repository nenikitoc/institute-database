DROP TABLE IF EXISTS lawyers_cases;
DROP TABLE IF EXISTS lawyers_specializations;
DROP TABLE IF EXISTS cases;

DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS lawyers;
DROP TABLE IF EXISTS specializations;


CREATE TABLE customers (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    first_name NVARCHAR(256) NOT NULL,
    last_name NVARCHAR(256) NOT NULL,
    gender NVARCHAR(32) NOT NULL CHECK(gender in ('Мужчина', 'Женщина')),
    address VARCHAR(256),
    passport_data NVARCHAR(32) NOT NULL UNIQUE,
    phone_number NVARCHAR(32) NOT NULL UNIQUE,
    email NVARCHAR(256) UNIQUE
);

CREATE TABLE lawyers (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    first_name NVARCHAR(256) NOT NULL,
    last_name NVARCHAR(256) NOT NULL,
    address NVARCHAR(256),
    phone_number NVARCHAR(32) NOT NULL UNIQUE,
    work_experience INT NOT NULL DEFAULT 0 CHECK(work_experience >= 0)
);

CREATE TABLE specializations (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    name NVARCHAR(256) NOT NULL UNIQUE
);

CREATE TABLE cases (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    number NVARCHAR(256) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    finish_date DATE,
    maximum_sentence NVARCHAR(256),
    imposed_sentence NVARCHAR(256),
    type_of_sentence NVARCHAR(256),
    amount_of_penalty DECIMAL(10, 2),
    status NVARCHAR(32) NOT NULL DEFAULT 'Начинается' CHECK(status in ('Начинается', 'Идёт', 'Завершено')),
    result NVARCHAR(256),
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
