## Крок 1
#### Створіть у БД структури даних, необхідні для роботи повноважного керування доступом.

<img width="422" alt="Снимок экрана 2022-12-23 в 17 30 51" src="https://user-images.githubusercontent.com/46464830/209360518-46ead3f0-33d1-4d77-8e09-26fad60d98ee.png">


`DROP TABLE IF EXISTS Access_Levels CASCADE;
CREATE TABLE Access_Levels (
access_level_id INTEGER PRIMARY KEY,
access_level VARCHAR UNIQUE
);
INSERT INTO Access_Levels VALUES (1, 'public');
INSERT INTO Access_Levels VALUES (2, 'private');
INSERT INTO Access_Levels VALUES (3, 'secret');
DROP TABLE IF EXISTS Role_Access_Level CASCADE;
CREATE TABLE Role_Access_Level (
role_name VARCHAR PRIMARY KEY,
access_level INTEGER REFERENCES
Access_Levels (access_level_id)
);
REVOKE ALL
ON Role_Access_Level
FROM GROUP oleksii;
GRANT SELECT
ON Role_Access_Level
TO GROUP oleksii;`

## Крок 2
#### Визначте для кожного рядка таблиці мітки конфіденційності (для кожного рядка свою мітку).

<img width="573" alt="Снимок экрана 2022-12-23 в 17 33 07" src="https://user-images.githubusercontent.com/46464830/209360816-a0a7c279-68e2-4214-a212-189bd96e242c.png">


`ALTER TABLE car ADD COLUMN spot_conf INTEGER DEFAULT 3 REFERENCES Access_Levels (access_level_id);
UPDATE PUBLIC.car SET spot_conf = 3;`

## Крок 3
#### Визначте для користувача його рівень доступу

`INSERT INTO Role_Access_Level VALUES ('oleksii', 2);`

<img width="464" alt="Снимок экрана 2022-12-23 в 17 34 23" src="https://user-images.githubusercontent.com/46464830/209361026-170db387-35c6-40d6-9cf8-bbbe02c1a775.png">

## Крок 4
#### Створіть нову схему даних.

`DROP SCHEMA IF EXISTS oleksii CASCADE;
CREATE SCHEMA oleksii;
ALTER SCHEMA oleksii OWNER TO oleksii;`

<img width="351" alt="Снимок экрана 2022-12-23 в 17 37 10" src="https://user-images.githubusercontent.com/46464830/209361384-d95f9072-d617-4f35-8597-cf8bf7709235.png">


## Крок 5
#### Створіть віртуальну таблицю, назва якої співпадає з назвою реальної таблиці та яка забезпечує SELECT-правила повноважного керування доступом для користувача.


DROP VIEW IF EXISTS oleksii.car;
CREATE VIEW oleksii.car AS
SELECT
c_id,
model,
year
FROM PUBLIC.car s, Role_Access_Level l
WHERE
l.role_name = CURRENT_USER and
l.access_level >= s.spot_conf;

<img width="327" alt="Снимок экрана 2022-12-23 в 17 37 32" src="https://user-images.githubusercontent.com/46464830/209361417-12db1dce-0247-439d-bc65-ce8d03ee113b.png">

## Крок 6
#### Створіть INSERT/UPDATE/DELETE-правила повноважного керування доступом для користувача.

`REVOKE ALL ON public.car FROM oleksii;
GRANT SELECT 
ON oleksii.car 
TO oleksii;`

<img width="367" alt="Снимок экрана 2022-12-23 в 17 43 34" src="https://user-images.githubusercontent.com/46464830/209362168-7878c5ea-c4b4-40a0-997a-2159df56733b.png">

`SELECT * FROM public.car;
SELECT * FROM oleksii.car;`

<img width="306" alt="Снимок экрана 2022-12-23 в 17 44 07" src="https://user-images.githubusercontent.com/46464830/209362229-409e1468-36f1-4f41-95a1-207747e1834d.png">


`UPDATE public.car 
SET spot_conf = 2 
WHERE c_id = 2;`

<img width="215" alt="Снимок экрана 2022-12-23 в 17 44 26" src="https://user-images.githubusercontent.com/46464830/209362265-0492f8de-2f3d-4002-8ff0-def3142b0eb6.png">

`select * from car;`

<img width="255" alt="Снимок экрана 2022-12-23 в 17 45 03" src="https://user-images.githubusercontent.com/46464830/209362338-7fef2953-7fd0-4079-ae20-3dc93d3f5a3e.png">

`GRANT DELETE 
ON oleksii.car 
TO oleksii;`

<img width="174" alt="Снимок экрана 2022-12-23 в 17 45 54" src="https://user-images.githubusercontent.com/46464830/209362450-1e6a4d84-fbca-43ec-ab24-8a7b74b16acc.png">

`DELETE from car;`

<img width="208" alt="Снимок экрана 2022-12-23 в 17 46 30" src="https://user-images.githubusercontent.com/46464830/209362518-715a5389-84bc-4063-ad26-ecfceb9d12c6.png">

`CREATE RULE car_delete 
AS ON DELETE TO oleksii.car
DO INSTEAD
DELETE FROM public.car 
WHERE c_id = OLD.c_id;`

<img width="238" alt="Снимок экрана 2022-12-23 в 17 46 56" src="https://user-images.githubusercontent.com/46464830/209362561-d9652e67-e0d5-41b8-bb16-588059acc448.png">

`CREATE RULE car_insert AS ON INSERT TO oleksii.car DO INSTEAD INSERT INTO public.car SELECT new.c_id, new.model, new.year, 
L.ACCESS_LEVEL from Role_Access_Level L WHERE L.role_name = CURRENT_USER;`

<img width="564" alt="Снимок экрана 2022-12-23 в 17 53 57" src="https://user-images.githubusercontent.com/46464830/209363459-f1fd55db-2370-422c-af9a-3b806a76c98c.png">


`CREATE RULE car_update AS ON UPDATE TO oleksii.car DO INSTEAD UPDATE public.car SET c_id = new.c_id, model = new.model, year = new.year, 
spot_conf = L.ACCESS_LEVEL from Role_Access_Level L WHERE L.role_name = CURRENT_USER and c_id = new.c_id;`

<img width="567" alt="Снимок экрана 2022-12-23 в 17 54 17" src="https://user-images.githubusercontent.com/46464830/209363502-e7f8058c-0dc3-44ce-848c-8cf58a638b12.png">

## Крок 7 
#### Перевірте роботу механізму повноважного керування, виконавши операції SELECT, INSERT, UPDATE, DELETE

`SELECT * FROM car; INSERT INTO car VALUES (7, 'Volvo', 2000); UPDATE car SET year = 2022 WHERE c_id = 7; DELETE FROM car WHERE c_id = 7;`

<img width="385" alt="Снимок экрана 2022-12-23 в 17 57 55" src="https://user-images.githubusercontent.com/46464830/209363941-e2760269-e044-4821-9cdb-14af14428406.png">


