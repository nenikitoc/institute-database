INSERT INTO customers (id, first_name, last_name, gender, address, passport_data, phone_number, email) VALUES
(1, 'Иван', 'Иванов', 'Male', 'г. Москва, ул. Ленина, д. 10', '4508 123456', '+79991112233', 'ivanov@email.ru'),
(2, 'Анна', 'Смирнова', 'Female', 'г. Санкт-Петербург, ул. Садовая, д. 5', '4012 654321', '+79992223344', 'smirnova@email.ru'),
(3, 'Петр', 'Петров', 'Male', 'г. Новосибирск, ул. Кирова, д. 15', '5015 789012', '+79993334455', 'petrov@email.ru');

INSERT INTO lawyers (id, first_name, last_name, address, phone_number, work_experience) VALUES
(1, 'Александр', 'Плевако', 'г. Москва, ул. Тверская, д. 8', '+79001110011', 15),
(2, 'Елена', 'Кучерена', 'г. Москва, ул. Новый Арбат, д. 12', '+79002220022', 8),
(3, 'Михаил', 'Падва', 'г. Санкт-Петербург, Невский пр., д. 20', '+79003330033', 22);

INSERT INTO specializations (id, name) VALUES
(1, 'Уголовное право'),
(2, 'Гражданское право'),
(3, 'Семейное право');

INSERT INTO cases (id, number, start_date, finish_date, maximum_sentence, imposed_sentence, type_of_sentence, amount_of_penalty, status, result, customer_id) VALUES
(1, '548625', '2025-01-23', '2026-10-01', '5 лет лишения свободы', '2 года условно', 'Лишение свободы', 0.00, 'Complete', 'Успешное решение в пользу клиента', 1),
(2, '712625', '2026-09-23', NULL, 'Штраф до 500 000 руб.', NULL, NULL, NULL, 'In progress', NULL, 2),
(3, '976625', '2026-10-01', NULL, 'Раздел имущества 50/50', NULL, NULL, NULL, 'Begins', NULL, 3);

INSERT INTO lawyers_specializations (lawyer_id, specializations_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 2),
(3, 3);

INSERT INTO lawyers_cases (lawyer_id, case_id) VALUES
(1, 1),
(2, 2),
(3, 3);
