## Содержание
* [practice-1 er-модель и основные понятия (05.09.2026)](#practice-1-er-модель-и-основные-понятия)
* [practice-2 реляционная модель (12.09.2026)](#practice-2-реляционная-модель)
* [practice-3 SQL DDL (19.09.2026)](#practice-3-SQL-DDL)
* [practice-4 SELECT (03.10.2026)](#practice-4-SELECT)
* [practice-5 SELECT (07.11.2026)](#practice-5-SELECT)
* [practice-6  (21.11.2026)](#practice-6-Процедуры,-функции,-тригеры)

# practice-1 er-модель и основные понятия
05.09.2026  
er-модель - реляционная модель над предметной областью.  
pk-ключ - определенный, уникальный и неизбыточный атрибут.  
Альтернатиный ключ - ключ, который может стать pk-ключем.  
Связь  - ассоциирование двух или более сущностей. Каждая связь характеризуется именем, степенью типом и обязательностью. Обязательность - сплошная линия, необязательность - пунктирная линия.  
Связь является обязательной, если в данной связи должен участвовать каждый экземпляр сущности, факультативной — если не каждый экземпляр сущности должен участвовать в данной связи. При этом связь может быть обязательной с одной стороны и факультативной с другой стороны.  
Типы связей:
* Связь 1:1. Каждый экземпляр сущности А связан с неболее чем одним экземпляром сущности В и наоборот.  
* Связь 1:M. Каждый экземпляр сущности А  связан со многими экземплярами сущности В, но каждый экземпляр сущности В связан с неболее чем одним экземпляром сущности А.  
* Связь M:N. Несколько экземпляров сущности А связаны с несколькими экземплярами сущности В и наоборот.  

<img src="practice-1/er-model.jpg">  

# practice-2 реляционная модель
12.09.2026  
Пример создания er-модели и e-модели на её основе.  
<img src="practice-2/er-model-practice-2.jpg">  
<img src="practice-2/relational-model-practice-2.jpg">  

# practice-3 SQL DDL
19.09.2026  
DDL (Data Definition Language):  
Создание сущностей, их pk и fk. Работа с типами, уникальностью и ограничениями.

```sql
-- Создание таблицы
CREATE TABLE table_name (
  column_1 datatype constraint,
  ...
);  

-- Удаление таблицы со всеми данными
DROP TABLE table_name;

-- Пример синтаксиса
CREATE TABLE example
(
    -- Одинарный pk
	id INT NOT NULL PRIMARY KEY,
    -- Составной pk
    PRIMARY KEY (first_name, last_name)

	first_name NVARCHAR(255) NOT NULL,
	last_name NVARCHAR(255) NOT NULL,

    -- Дефолтные значения DEFAULT
    region NVARCHAR(255) NOT NULL DEFAULT('Yaroslavl region')
    -- Ограничения CHECK
    city NVARCHAR(255) NOT NULL CHECK(CITY in ('New York', 'Boston'))
);

CREATE TABLE groups
(
	id INT NOT NULL PRIMARY KEY,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
);

CREATE TABLE students
(
    -- Автоинкрементация IDENTITY(начало, шаг)
	id INT IDENTITY(1, 1) PRIMARY KEY,
	first_name NVARCHAR(255) NOT NULL,
	last_name NVARCHAR(255) NOT NULL,

    -- Создание fk
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES groups(id)

    -- Задаём каскад, при удалении/обновлении
    ON DELETE <ПРАВИЛО>
    ON UPDATE <ПРАВИЛО>

/*
Правила:
1) CASCADE		: автоматическое удаление/обновление связанных строк
2) SET NULL		: устанавливает значение внешнего ключа в NULL
3) SET DEFAULT	: устанавливает значение внешнего ключа в значение по умолчанию, заданное при создании таблицы
4) RESTRICT / NO ACTION: блокируют удаление или изменение, выдаёт ошибку
*/
);

-- Оформление ограничений через CONSTRAINT
/*
Как задавать названия для CONSTRAINT
pk_ : ограничения для PK
fk_ : ограничения для FK
uq_ : ограничения для UNIQUE
ck_ : ограничения для CKECK
df_ : ограничения для DEFAULT
*/

CREATE TABLE groups
(
	id INT IDENTITY(1, 1) CONSTRAINT pk_groups PRIMARY KEY,
	name NVARCHAR(255) NOT NULL
);

CREATE TABLE students
(
	id INT IDENTITY(1, 1) CONSTRAINT pk_groups PRIMARY KEY,
	first_name NVARCHAR(255) NOT NULL,
	second_name NVARCHAR(255) NOT NULL,
	email NVARCHAR(255) NULL CONSTRAINT uq_students_email UNIQUE,
	city VARCHAR(255) NOT NULL
		CONSTRAINT df_students_city DEFAULT('Yaroslavl')
		CONSTRAINT ck_students_city CHECK(city in ('Yaroslavl', 'Moscow')),
	group_id INT NULL
		CONSTRAINT fk_students_group_id
			FOREIGN KEY (group_id) REFERENCES groups(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE
);

-- Изменение структуры таблицы
-- Добавление столбца
ALTER TABLE students ADD phone_number NVARCHAR(20);
-- Удаление таблицы
ALTER TABLE students DROP COLUMN email;
-- Изменение типа столбца
ALTER TABLE students ALTER COLUMN second_name NVARCHAR(300);
```

# practice-4 SELECT
03.10.2026

```sql
SELECT [DISTINCT] column_1 <короткое название>, column_2 c_2
FROM table_1 <короткое название>, table_2 t_2
-- FROM из нескольких таблиц даёт декартово произведение
<тип JOIN> [JOIN] table_3 t_3 ON <УСЛОВИЕ СВЯЗИ>
[WHERE] <УСЛОВИЕ>
[ORDER BY] <УСЛОВИЕ>
```

Ключевые слова
* SELECT : выбирает колонки из таблиц
* DISTINCT : оставляет только уникальыне строки
* FROM : из каких таблиц идет выборка
* WHERE : условие для результируещей таблицы
* ORDER BY : сортировка по условию
* INNER JOIN : соединение двух таблиц, строки из левой и правой, которые соответсвуют условию
* LEFT [OUTER] JOIN : соединение двух таблиц, все строки из левой и по условию из правой
* RIGHT [OUTER] JOIN : соединение двух таблиц, по условию из левой и все строки из правой
* FULL [OUTER]  JOIN : соединение двух таблиц, все строки из левой и правой
* CROSS JOIN : декартово произведение
  
Основные операторы и фильтрация (DQL)
* DISTINCT : убирает дубликаты из результата. Если указано несколько атрибутов, уникальной должна быть вся комбинация (строка).
* COUNT(атрибут) : количество значений в колонке (игнорирует NULL). COUNT(*) - общее количество кортежей.
* BETWEEN {A} AND {B} : фильтрация интервала (включая границы A и B).
* IN / NOT IN (список) : проверка на вхождение значения в перечень или подзапрос.
* MIN(), MAX(), AVG(), SUM() : агрегатные функции (минимум, максимум, среднее, сумма).
* LIKE '{шаблон}' : поиск по маске. % - любая последовательность символов (включая пустую), _ - ровно один любой символ.
* LIMIT {N} : ограничивает вывод первыми N кортежами.
* IS NULL / IS NOT NULL : единственно верный способ проверить поле на «пустоту» (NULL нельзя сравнивать через = или <>).


# practice-5 SELECT
07.11.2026

* ISNULL(<выражение>, <замена>)	: если выражение null возвращает <замена>, иначе возвращает <выражение>. Тип <замены> = тип <выражение>  
* COALESCE(a_1, a_2, ..., a_n)	: возвращает первое not null значение из списка атрибутов.  
* CASE WHEN :  
	CASE WHEN условие_1 THEN значение_1  
	WHEN условие_2 THEN значение_2  
	...  
	ELSE значение  
Тип результата первый в цепочке приведения.  
* IIF(условие, значение_если_true, значение_если_не_true) : аналог WHEN для простых выражений  
* Лучше использовать COALESCE и CASE WHEN, т.к. они есть во всех БД  
* Подзапросы/CTE : 
	* 1*1 : WHERE атрибут = (скалярный_подзапрос)
	* 1*N : использлвание с EXISTS, IN, ALL
	* N*N : использование с JOIN
* Коррелированный подзапрос : ссылается на внешний запрос или атрибут

# practice-6 Процедуры, функции, тригеры
21.11.2026

* Batch (пакет) : набор команд, которые исполняются вместе, имеют свою область видимости для переменных
* Go : разделитель пакетов
  
```sql
DECLARE @local_value INT; 	-- обычная переменная
DECLARE @@global_value INT; -- глобальная переменная
SET @value = 42; : задание значения

SELECT @value = id
FROM Users
WHERE id > 10

DECLARE @a INT = 1, @b INT = 1
SELECT @a  = OrderId FROM Orders WHERE 1 = 0
SET @b = (SELECT OrderId FROM Orders WHERE 1 = 0)
SELECT @1 AS a, @b AS b
-- 1, null
-- SELECT присваиваение пропускается, значение остается
-- SET подзапрос возвращает null и b принимает его

-- VIEW : сохранение SELECT + оптимизация под капотом
CREATE ON ALTER VIEW dbo.OrderTools
AS
SElECT ...
GO;

-- Процедура : набор команд, которые хранятся на сервере, может быть сложнее VIEW
CREATE PROCEDURE dbo.GetOrderTotal
    @CustomerId INT,                  	-- обязательный входной параметр
    @Status NVARCHAR(20) = N'Paid',		-- необязательный параметр (есть значение по умолчанию)
    @TotalAmount DECIMAL(18, 2) OUTPUT	-- выходной параметр для возврата значения
AS
BEGIN
    SELECT @TotalAmount = ISNULL(SUM(Amount), 0)
    FROM dbo.Orders
    WHERE CustomerId = @CustomerId AND Status = @Status;

    -- Возвращаем статус выполнения (0 обычно означает успех)
    RETURN 0;
END;
GO

DECLARE @ResultAmount DECIMAL(18, 2);
DECLARE @ReturnCode INT;

EXEC @ReturnCode = dbo.GetOrderTotal 
    @CustomerId = 15, 
    @TotalAmount = @ResultAmount OUTPUT;

SELECT @ResultAmount AS Total, @ReturnCode AS StatusCode;

-- Пользовательские функции : обязана возвращать return. Можно вызвать внутри подзапросов. Есть три типа функций
-- Скалярная функция (Scalar UDF) : Возвращает одно значение любого простого типа
CREATE FUNCTION dbo.GetDiscountPrice (
    @Price DECIMAL(10, 2),
    @DiscountPercent INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Price * (100 - @DiscountPercent) / 100.0;
END;
GO

-- Вызов (схема dbo. обязательна)
SELECT ProductName, dbo.GetDiscountPrice(Price, 15) AS FinalPrice
FROM dbo.Products;

-- Встраиваемая табличная функция (Inline TVF) : Возвращает таблицу, состоящую из одного SELECT-запроса. В ней нет блока BEGIN...END. Работает быстро, так как оптимизатор встраивает ее в основной запрос как обычное представление (VIEW) с параметрами
CREATE FUNCTION dbo.GetOrdersByCustomer (@CustomerId INT)
RETURNS TABLE
AS
RETURN (
    SELECT OrderId, OrderDate, TotalAmount
    FROM dbo.Orders
    WHERE CustomerId = @CustomerId
);
GO

-- Вызов (как обычной таблицы в FROM или через CROSS APPLY)
SELECT * FROM dbo.GetOrdersByCustomer(42);

-- Многооператорная табличная функция (Multi-Statement TVF) : Возвращает таблицу, но внутри содержит блок BEGIN...END, где можно объявлять переменные, циклы, условия IF и пошагово наполнять возвращаемую табличную переменную
CREATE FUNCTION dbo.GetTopCustomers (@MinTotal DECIMAL(18, 2))
RETURNS @Result TABLE (
    CustomerId INT,
    CustomerName NVARCHAR(100),
    TotalSpent DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO @Result (CustomerId, CustomerName, TotalSpent)
    SELECT c.Id, c.Name, SUM(o.TotalAmount)
    FROM dbo.Customers c
    JOIN dbo.Orders o ON c.Id = o.CustomerId
    GROUP BY c.Id, c.Name
    HAVING SUM(o.TotalAmount) >= @MinTotal;

    RETURN;
END;
GO

-- Вызов
SELECT * FROM dbo.GetTopCustomers(10000);

-- DML-триггеры : срабатывают при изменении данных, антипатерн (много проблем)
CREATE [ OR ALTER ] TRIGGER [схема.]имя_триггера
ON { [схема.]имя_таблицы | [схема.]имя_представления }
{ FOR | AFTER | INSTEAD OF }
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }
AS
BEGIN
    SET NOCOUNT ON;

    -- Тело триггера (инструкции T-SQL с использованием таблиц inserted и deleted)
END;
GO

```
SQL DML(Data Manipulation Language) DCL(Data Controll Language) TCL(Transactions Controll Language)
