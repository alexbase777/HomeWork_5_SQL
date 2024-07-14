-- 1.	Выбрать количество мест в каждом из самолётов и отсортировать по количеству мест в порядке убывания.

-- SELECT * FROM -- Из таблицы SEATS (места) формируем таблицу (модель самолёта и кол-ва мест в каждом)
-- (SELECT AIRCRAFT_CODE, COUNT (AIRCRAFT_CODE) AS CNT FROM SEATS
-- 	GROUP BY AIRCRAFT_CODE) -- Группируем по модели самолёта
-- ORDER BY CNT DESC; -- Сортируем кол-во мест CNT в порядке убывания

-- 2.	Выбрать количество мест в каждом из самолетов по классам обслуживания и отсортировать по полям кода самолета и 
-- класса обслуживания в порядке возрастания.

-- SELECT * FROM -- Из таблицы SEATS (места) формируем таблицу (модель самолёта, класс сиденья и кол-во мест в каждом)
-- (SELECT AIRCRAFT_CODE, FARE_CONDITIONS, COUNT (FARE_CONDITIONS) AS CNT FROM SEATS
-- 	GROUP BY AIRCRAFT_CODE, FARE_CONDITIONS) -- Группируем по модели самолёта и классу сиденья
-- ORDER BY AIRCRAFT_CODE, CNT; -- Сортируем кол-во мест CNT в порядке возрастания по модели самолёта и классу сиденья

--3.	Выберите минимальную цену полета за каждую дату в таблице bookings. Для того, чтобы сгруппировать только по дате, 
-- без учета времени, приведите поле book_date к типу date (::date).

-- SELECT * FROM -- Сначала из таблицы BOOKINGS выбираем столбцы с преобразованной в дату BOOK_DATE и TOTAL_AMOUNT, 
-- (SELECT BOOK_DATE, MIN(TOTAL_AMOUNT) FROM (SELECT CAST(BOOK_DATE AS DATE), TOTAL_AMOUNT FROM BOOKINGS)
-- 	GROUP BY BOOK_DATE) -- затем из выбранных столбцов выьираем уникальную дату с минимальной ценой
-- ORDER BY BOOK_DATE; -- сортируем по дате

-- 4.	Выберите среднюю цену полета в каждом из классов обслуживания по каждому id перелета в таблице перелетов и отсортируйте по id 
-- перелета от большего к меньшему. Столбцу со средней стоимостью задайте псевдоним «avg_amount».

-- SELECT * FROM -- Из таблицы TICKET_FLIGHTS (билеты) формируем таблицу (id_перелёта, класс места и среднеарифметическая цена билета)
-- (SELECT FLIGHT_ID, FARE_CONDITIONS, AVG(AMOUNT) AS AVG_AMOUNT FROM TICKET_FLIGHTS -- столбец с среднеарифметической ценой называем псевдонимом AVG_AMOUNT
-- 	GROUP BY FLIGHT_ID, FARE_CONDITIONS) -- группируем таблицу по id_перелёта и классу места
-- ORDER BY FLIGHT_ID DESC; -- сортируем по уменьшению id_перелёта

-- 5.	Выберите сумму цен полета у каждого перелета в таблице ticket_flights и выведите только десять самых больших сумм. 
-- Столбец с суммами назовите avg_sum.

-- SELECT * FROM -- Из таблицы TICKET_FLIGHTS формируем таблицу (id_перелёта, сумма цен полётов у каждого перелёта)
-- (SELECT FLIGHT_ID, SUM(AMOUNT) AS AVG_SUM FROM TICKET_FLIGHTS
-- 	GROUP BY FLIGHT_ID)	-- Группируем по id_перелёта
-- ORDER BY AVG_SUM DESC -- Сортируем по уменьшению сумму цен полётов
-- LIMIT 10; -- Выводим только первые 10 записей

-- 6.	Выберите количество мест бизнес-класса в каждом из самолетов в таблице seats. Столбец с количеством мест назовите «count_business_seats».

-- SELECT * FROM -- Из таблицы SEATS формируем таблицу (модель самолёта, класс места, кол-во мест)
-- (SELECT AIRCRAFT_CODE, FARE_CONDITIONS, COUNT(FARE_CONDITIONS) AS COUNT_BUSINESS_SEATS FROM SEATS
-- 	GROUP BY AIRCRAFT_CODE, FARE_CONDITIONS) -- Группируем по id_перелёта и классу 
-- 	WHERE FARE_CONDITIONS = 'Business' -- Таблицу ограничиваем условием, что класс места = 'Business'
-- ORDER BY AIRCRAFT_CODE; -- Сортируем таблицу по модели самолёта

-- 7.	Выберите количество мест эконом-класса в самолетах с кодом: 321, 320, 763 в таблице seats и отсортируйте их по убыванию количества мест.

-- SELECT * FROM -- Из таблицы SEATS формируем таблицу (модель самолёта, класс места, кол-во мест)
-- (SELECT AIRCRAFT_CODE, FARE_CONDITIONS, COUNT (FARE_CONDITIONS) AS CNT FROM SEATS
-- 	GROUP BY AIRCRAFT_CODE, FARE_CONDITIONS) -- Группируем по id_перелёта и классу 
-- WHERE FARE_CONDITIONS = 'Economy' AND AIRCRAFT_CODE IN ('321', '320', '763') -- Таблицу ограничиваем условием, что класс места = 'Economy' и модель самолёта = 321, 320 или 763
-- ORDER BY AIRCRAFT_CODE DESC; -- Сортируем таблицу по модели самолёта

-- 8.	Выберите среднее значения поля total_amount в таблице bookings за даты: 2017-07-01, 2017-08-01, 2017-08-11, 2017-07-11 и 
-- отсортируйте по уменьшению среднего значения. Задайте столбцу со средними значениями имя avg_amount. 
-- Для проверки даты без времени используйте приведение типов.

-- SELECT * FROM -- Из таблицы BOOKING формируем таблицу (BOOK_DATE, среднее значение стоимости)
-- (SELECT BOOK_DATE, AVG(TOTAL_AMOUNT) AS AVG_AMOUNT FROM (SELECT CAST(BOOK_DATE AS DATE), TOTAL_AMOUNT FROM BOOKINGS)
-- 	GROUP BY BOOK_DATE) -- Группируем по дате
-- WHERE BOOK_DATE IN ('2017-07-01', '2017-08-11', '2017-07-11') -- Выборка по условию
-- ORDER BY AVG_AMOUNT DESC; -- Группировка по уменьшению среднего значения

-- 9.	Выберите среднее значение поля total_amount в таблице bookings за каждый месяц. Задайте столбцу со средними значениями 
-- имя avg_amount, а столбцу месяца – month.

-- SELECT * FROM -- Формируем таблицу (месяц "MONTH", среднее значение стоимости AVG_AMOUNT), которую формируем из таблицы (месяц "MONTH", TOTAL_AMOUNT), которую формируем из таблицы BOOKINGS
-- (SELECT "MONTH", AVG(TOTAL_AMOUNT) AS AVG_AMOUNT FROM (SELECT EXTRACT(MONTH FROM BOOK_DATE) AS "MONTH", TOTAL_AMOUNT FROM BOOKINGS)
-- 	GROUP BY "MONTH") -- Группируем по месяцу
-- ORDER BY "MONTH"; -- Сортируем по месяцу

-- 10.	Выберете минимальное значение поля range в таблице самолетов из всех моделей Боинг. Должно быть выведено одно значение – 4200.

-- SELECT * FROM 
-- (SELECT MIN(RANGE) FROM AIRCRAFTS_DATA WHERE AIRCRAFT_CODE IN ('773', '763', '733'));

-- 11.	 Задание на дополнительную оценку. Используя документацию по PostgreSQL выполнить запрос из задания 9, но вывести название месяца вместо номера.

-- Названия месяцев по-английски:
-- SELECT * FROM -- Формируем таблицу (месяц "MONTH", среднее значение стоимости AVG_AMOUNT), которую формируем из таблицы (НАЗВАНИЕ месяца "MONTH", TOTAL_AMOUNT), которую формируем из таблицы BOOKINGS
-- (SELECT "MONTH", AVG(TOTAL_AMOUNT) AS AVG_AMOUNT FROM (SELECT TO_CHAR(BOOK_DATE, 'MONTH') AS "MONTH", TOTAL_AMOUNT FROM BOOKINGS)	
-- 	GROUP BY "MONTH") -- Группируем по месяцу	
-- ORDER BY "MONTH"; -- Сортируем по месяцу

-- Названия месяцев по-русски:
-- SELECT * FROM -- Формируем таблицу (месяц "MONTH", среднее значение стоимости AVG_AMOUNT), которую формируем из таблицы (НАЗВАНИЕ месяца "MONTH", TOTAL_AMOUNT), которую формируем из таблицы BOOKINGS
-- (SELECT "MONTH", AVG(TOTAL_AMOUNT) AS AVG_AMOUNT FROM (SELECT TO_CHAR(BOOK_DATE, 'TMMONTH') AS "MONTH", TOTAL_AMOUNT FROM BOOKINGS)	
-- 	GROUP BY "MONTH") -- Группируем по месяцу	
-- ORDER BY "MONTH"; -- Сортируем по месяцу

-- ----------------- ИЗМЕНЕНИЕ, УДАЛЕНИЕ---------------------

-- 1. Задайте значение range у самолета SU9 равным 3500.
-- UPDATE AIRCRAFTS_DATA
-- SET RANGE = '3500'
-- WHERE AIRCRAFT_CODE = 'SU9';

-- 2.	Уменьшите стоимость всех перелетов с классом Economy в два раза.
-- UPDATE TICKET_FLIGHTS
-- SET AMOUNT = AMOUNT / 2
-- WHERE FARE_CONDITIONS='Economy';
-- SELECT * FROM TICKET_FLIGHTS
-- WHERE FARE_CONDITIONS = 'Economy'
-- ORDER BY FLIGHT_ID;

-- 3.	Пассажиру с id "4245 607929" смените имя на «Анастасия». Имя указывается на английском языке.
-- UPDATE TICKETS
-- SET PASSENGER_NAME = 'ANASTASIA'
-- WHERE PASSENGER_ID = '4245 607929';
-- SELECT PASSENGER_ID, PASSENGER_NAME FROM TICKETS
-- WHERE PASSENGER_ID ='4245 607929';

-- 4.	Измените класс обслуживания всех мест 31 в самолете №773  на Business.
-- UPDATE SEATS
-- SET FARE_CONDITIONS = 'Business'
-- WHERE SEAT_NO LIKE '31%' AND AIRCRAFT_CODE = '773';
-- SELECT * FROM SEATS
-- WHERE AIRCRAFT_CODE ='773'
-- ORDER BY SEAT_NO;

-- 5.	В таблице рейсов измените статус полетов с id: 63, 64, 65, 66, 94, 95 на "Arrived".
-- UPDATE FLIGHTS
-- SET STATUS = 'Arrived'
-- WHERE FLIGHT_ID IN ('63','64','65','66','94','95');
-- SELECT FLIGHT_ID, STATUS FROM FLIGHTS
-- WHERE FLIGHT_ID IN ('63','64','65','66','94','95');

-- 6.	В таблице перелетов уменьшите все цены на 10%  и измените класс полета на economy у полета с id 3490
-- UPDATE TICKET_FLIGHTS
-- SET AMOUNT = AMOUNT * 0.9	
-- WHERE FLIGHT_ID = '3490';
-- UPDATE TICKET_FLIGHTS
-- SET FARE_CONDITIONS = 'Economy'
-- WHERE FLIGHT_ID = '3490';
-- SELECT * FROM TICKET_FLIGHTS
-- WHERE FLIGHT_ID = '3490'
-- ORDER BY TICKET_NO;

-- 7.	Из таблицы посадочных талонов удалите все записи у рейса с id 9319 у которых сидения расположены в ряду C.
-- DELETE FROM BOARDING_PASSES
-- WHERE SEAT_NO LIKE '%C';	
-- SELECT * FROM BOARDING_PASSES
-- WHERE FLIGHT_ID = '9319'
-- ORDER BY TICKET_NO;

-- 8.	Из таблицы посадочных талонов удалите все записи у рейса с id 9319.
-- DELETE FROM BOARDING_PASSES
-- WHERE FLIGHT_ID = '9319';
-- SELECT * FROM BOARDING_PASSES
-- WHERE FLIGHT_ID = '9319'

-- 9.	Из таблицы перелетов удалите все записи у рейса с id 9319 и ценой ниже 100 000
-- DELETE FROM TICKET_FLIGHTS
-- WHERE FLIGHT_ID = '9319' AND AMOUNT < 100000;
-- SELECT * FROM TICKET_FLIGHTS
-- WHERE FLIGHT_ID = '9319' AND AMOUNT < 100000;

-- 10.	Измените таблицу boarding_passes, выставив у внешнего составного ключа ticket_no, flight_id каскадное удаление и обновление.
-- ALTER TABLE BOARDING_PASSES -- Меняем таблицу BOARDING_PASSES
-- DROP CONSTRAINT BOARDING_PASSES_TICKET_NO_FKEY; -- Удаляем старую связь
-- ALTER TABLE BOARDING_PASSES -- Меняем таблицу BOARDING_PASSES
-- ADD CONSTRAINT BOARDING_PASSES_TICKET_NO_FKEY FOREIGN KEY (TICKET_NO) -- Добавляем новую связь для внешнего ключа TICKET_NO
-- REFERENCES TICKETS (TICKET_NO) ON DELETE CASCADE ON UPDATE CASCADE; -- Добавляем каскадное обновление и удаление
-- ALTER TABLE BOARDING_PASSES -- Меняем таблицу BOARDING_PASSES
-- ADD CONSTRAINT BOARDING_PASSES_FLIGHT_ID_FKEY FOREIGN KEY (FLIGHT_ID) -- Добавляем новую связь для внешнего ключа FLIGHT_ID
-- REFERENCES FLIGHTS (FLIGHT_ID) ON DELETE CASCADE ON UPDATE CASCADE; -- Добавляем каскадное обновление и удаление

-- 11.	Удалите все записи в таблице перелетов, у которых класс обслуживания – комфорт и цена от 10000 до 20000.
-- DELETE FROM TICKET_FLIGHTS
-- WHERE FARE_CONDITIONS = 'Comfort' AND AMOUNT BETWEEN 10000 AND 20000;
-- SELECT * FROM TICKET_FLIGHTS
-- WHERE FARE_CONDITIONS = 'Comfort' AND AMOUNT BETWEEN 10000 AND 20000;

-- 12.	В таблице перелетов удалите все записи дороже 100 000 и дешевле 10 000 не используя знаки неравенства.
-- DELETE FROM TICKET_FLIGHTS
-- WHERE AMOUNT NOT BETWEEN 10000 AND 100000;	
-- SELECT * FROM TICKET_FLIGHTS
-- WHERE AMOUNT NOT BETWEEN 10000 AND 100000;

-- 13.	У самолета №773 измените название на «Going Merry», у самолета №733 на «Thousand Sanny», а также установите их дальность полета в 20000.
-- UPDATE AIRCRAFTS_DATA
-- SET MODEL = '{"en":"Going Merry"}', RANGE = '20000'
-- WHERE AIRCRAFT_CODE = '773';
-- UPDATE AIRCRAFTS_DATA
-- SET MODEL = '{"en":"Thousand Sanny"}', RANGE = '20000'
-- WHERE AIRCRAFT_CODE = '733';
-- SELECT * FROM AIRCRAFTS_DATA

-- 14.	Измените таблицу перелетов, переименовав поле amount в price.
-- ALTER TABLE TICKET_FLIGHTS
-- RENAME AMOUNT TO PRICE;
-- SELECT * FROM TICKET_FLIGHTS;

-- 15.	Измените таблицу aircrafts_data, добавив поле для даты постройки самолета и удалив поле для расстояния.
-- ALTER TABLE AIRCRAFTS_DATA
-- ADD DATE_CREATE DATE -- Добавляем поле постройки самолёта
-- ALTER TABLE AIRCRAFTS_DATA
-- DROP COLUMN RANGE CASCADE; -- Каскадно удаляем поле для расстояния 
-- SELECT * FROM AIRCRAFTS_DATA;

