## Крок 1
#### Заповніть таблицю БД ще трьома рядками.

`INSERT INTO car VALUES (2, 'Mazda', 2006);`

`INSERT INTO car VALUES (3, 'Bogdan', 2008);`

`INSERT INTO car VALUES (4, 'Audi', 2016);`

`INSERT INTO car VALUES (5, 'Skoda', 2001);`



<img width="391" alt="Снимок экрана 2022-12-23 в 17 17 41" src="https://user-images.githubusercontent.com/46464830/209358686-d6537c73-7535-4789-b865-7d6888a86389.png">


## Крок 2
#### Створіть схему даних користувача та віртуальну таблицю у цій схемі з правилами вибіркового керування доступом для користувача так, щоб він міг побачити тільки один з рядків таблиці з урахуванням одного значення її останньої колонки.


`GRANT SELECT ON car TO oleksii;
CREATE TABLE ROLE2CAR (
ROLE_NAME VARCHAR(30),
YEAR INTEGER
);
GRANT SELECT ON ROLE2CAR TO oleksii;
INSERT INTO ROLE2CAR VALUES ('OLEKSII', 2001);
CREATE SCHEMA OLEKSII;
ALTER SCHEMA OLEKSII OWNER TO oleksii;`

<img width="332" alt="Снимок экрана 2022-12-23 в 17 22 12" src="https://user-images.githubusercontent.com/46464830/209359329-bb4a059e-d6bd-469f-8bad-fdddb710d490.png">


`CREATE OR REPLACE VIEW OLEKSII.car AS SELECT S.* FROM PUBLIC.car S, ROLE2CAR RLS
WHERE RLS.ROLE_NAME = UPPER(CURRENT_USER) AND RLS.YEAR = S.year; GRANT SELECT ON OLEKSII.car TO OLEKSII; REVOKE SELECT ON PUBLIC.car FROM OLEKSII;`

<img width="570" alt="Снимок экрана 2022-12-23 в 17 22 40" src="https://user-images.githubusercontent.com/46464830/209359402-093733d4-105d-493e-b062-d71bc3441f24.png">


## Крок 3
#### Перевірте роботу механізму вибіркового керування, виконавши операції SELECT, INSERT, UPDATE, DELETE.

`SELECT * FROM car;`

<img width="233" alt="Снимок экрана 2022-12-23 в 17 25 18" src="https://user-images.githubusercontent.com/46464830/209359779-e11ad9af-4384-4911-ae48-6735dada68c8.png">

`INSERT into car values (6, 'Renault', 2018);`

<img width="567" alt="Снимок экрана 2022-12-23 в 17 27 28" src="https://user-images.githubusercontent.com/46464830/209360088-8b654da0-457b-4383-8a54-25d6405d91ca.png">

`UPDATE car SET c_id = 0;`

<img width="570" alt="Снимок экрана 2022-12-23 в 17 27 45" src="https://user-images.githubusercontent.com/46464830/209360118-732a8fc3-b35b-413f-8003-1d86448ca889.png">

`DELETE FROM car WHERE c_id = 2;`

<img width="564" alt="Снимок экрана 2022-12-23 в 17 28 03" src="https://user-images.githubusercontent.com/46464830/209360162-6eac6168-2c2f-4e0e-871a-c59683cb6ad2.png">


