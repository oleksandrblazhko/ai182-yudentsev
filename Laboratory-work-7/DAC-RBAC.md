## Крок 1

**Встановіть СКБД PostgreSQL**

Оскільки PostgreSQL вже була встановлена, перевіримо її наявність та версію командою `psql --version`. Бачимо, що встановлена версія PostgreSQL 14.6.

<img width="442" alt="Снимок экрана 2022-11-28 в 15 01 02" src="https://user-images.githubusercontent.com/46464830/204284118-db6fcc23-7ee1-4c3f-af12-839f8540de14.png">

## Крок 2

**Створіть термінальну консоль psql через утиліту командного рядка вашої ОС та встановіть з’єднання з БД postgres від імені користувача-адміністратора postgres**

Командою `psql -U postgres -d postgres` створено термінальну консоль. Також введено пароль користувача postgres та встановлен зʼєднання з БД.

<img width="555" alt="Снимок экрана 2022-11-28 в 15 05 59" src="https://user-images.githubusercontent.com/46464830/204285078-e0dec941-b1d1-4b38-bf87-ef2a1f1f4fa6.png">


## Крок 3

**Зареєструйте нового користувача в СКБД PostgreSQL, назва якого співпадає з вашим ім'ям, наприклад ivan, і довільним паролем.**

Створено користувача oleksii з паролем 11111111 командою `CREATE USER oleksii WITH PASSWORD '11111111';`. Метакомандою \du переглянуто список усіх доступних користувачів.

<img width="602" alt="Снимок экрана 2022-11-28 в 15 10 25" src="https://user-images.githubusercontent.com/46464830/204285863-36685046-e02e-47bc-affe-23c26e2e61ff.png">

## Крок 4

**Створіть роль в СКБД PostgreSQL (назва співпадає з вашим прізвищем латинськими літерами) і надайте новому користувачеві можливість наслідувати цю роль.**

Створено роль yudientsev. 

`CREATE ROLE yudientsev;
GRANT yudientsev TO oleksii;`

<img width="280" alt="Снимок экрана 2022-11-28 в 15 17 42" src="https://user-images.githubusercontent.com/46464830/204287270-24ea0836-d079-4fac-bf53-878849ddeece.png">

## Крок 5

**Створіть реляційну таблицю з урахуванням варіанту з таблиці 2.1 від імені користувача-адміністратора.**

Створено таблицю car з атрибутами c_id, model, year. Метакомандою \dt переглянуто усі наявні таблиці в базі даних.

`Create table car
(c_id integer, model varchar, year integer);`

<img width="333" alt="Снимок экрана 2022-11-28 в 15 21 03" src="https://user-images.githubusercontent.com/46464830/204287929-f0a352b6-8ff6-4b34-9e44-1f8552d126ab.png">

## Крок 6

**Внесіть один рядок в таблицю, використовуючи команду insert into ..., відповідно до варіанту.**

Командою `Insert into car values (1, 'MAN', 2005);` введено дані у таблицю. Перевіримо, чи ввелись дані, командою `SELECT * FROM car;`

<img width="244" alt="Снимок экрана 2022-11-28 в 15 24 11" src="https://user-images.githubusercontent.com/46464830/204288604-d36aece4-4013-4952-a797-5c5f532e5324.png">

## Крок 7

**Додатково створіть ще одну термінальну консоль psql та та встановіть з’єднання з БД postgres від імені нового користувача**

Командою `psql -U oleksii -d postgres` виконано зʼєднання з БД PostgreSQL.

<img width="551" alt="Снимок экрана 2022-11-28 в 15 28 39" src="https://user-images.githubusercontent.com/46464830/204289495-7ec0e06c-f439-4594-80cb-16ab78187e3e.png">

## Крок 8

**Від імені вашого користувача виконайте запит на отримання даних з таблиці (select * from таблиця). Запротоколюйте результат виконання команди.**

Командою `SELECT * FROM car;` виконаємо запит на отримання даних з таблиці. Як бачимо, користувач `oleksii` не має доступу до таблиці.

<img width="291" alt="Снимок экрана 2022-11-28 в 15 30 26" src="https://user-images.githubusercontent.com/46464830/204289877-fe42b8aa-c570-49a0-a580-352a1b0b41ea.png">

## Крок 9

**Встановіть повноваження на читання таблиці новому користувачеві.**

Командою `GRANT SELECT ON car TO oleksii;` надамо повноваження.

<img width="308" alt="Снимок экрана 2022-11-28 в 15 33 06" src="https://user-images.githubusercontent.com/46464830/204290396-6731a7c0-b532-4f03-ac27-51a911812c4f.png">

## Крок 10

**Повторіть крок 8.**

Оскільки тепер користувач `oleksii` має доступ, то командою `SELECT * FROM car;` отримаємо дані з таблиці `car`.

<img width="214" alt="Снимок экрана 2022-11-28 в 15 34 44" src="https://user-images.githubusercontent.com/46464830/204290707-cd8fc8a6-7f80-40ae-b3ea-642edee1b4d9.png">


## Крок 11

**Зніміть повноваження на читання таблиці для нового користувача.**

Командою `REVOKE SELECT ON car FROM oleksii;` для користувача `oleksii` знято повноваження на читання таблиці `car`.

<img width="332" alt="Снимок экрана 2022-11-28 в 15 38 55" src="https://user-images.githubusercontent.com/46464830/204291602-b067e976-736b-4eef-8a0a-8817b9abdf37.png">

## Крок 12

**Повторіть крок 8.**

Як бачимо, в нас немає доступу до читання таблиці.

`SELECT * FROM car;`

<img width="298" alt="Снимок экрана 2022-11-28 в 15 40 26" src="https://user-images.githubusercontent.com/46464830/204291884-c751790e-c1ab-4dd2-b8cc-8af1b1d8a537.png">

## Крок 13

**Створіть команду оновлення даних таблиці (UPDATE) і виконайте її від імені нового користувача. Проаналізуйте результат виконання команди.**

Спробуємо оновити дані в таблиці командою `UPDATE car SET model = 'Volvo' WHERE c_id = 1;`. Як бачимо, прав на оновлення у користувача `oleksii` немає.

<img width="409" alt="Снимок экрана 2022-11-28 в 15 44 05" src="https://user-images.githubusercontent.com/46464830/204292619-c2071db2-da93-428b-850e-98df77204ab3.png">

## Крок 14

**Встановіть повноваження на оновлення таблиці новому користувачеві.**

Командою `GRANT UPDATE ON car TO oleksii` для користувача `oleksii` надано повноваження на оновлення таблиці `car`.

<img width="324" alt="Снимок экрана 2022-11-28 в 15 47 48" src="https://user-images.githubusercontent.com/46464830/204293385-21878ba8-7471-455e-824a-f1487c899e04.png">

## Крок 15

**Повторіть крок 13.**

`UPDATE car SET model = 'Volvo';`

<img width="309" alt="Снимок экрана 2022-11-28 в 15 51 40" src="https://user-images.githubusercontent.com/46464830/204294237-71ada5e5-547c-4911-bbd2-eba290aca1f5.png">

## Крок 16

**Створіть команду видалення запису таблиці (DELETE) і виконайте її від імені нового користувача. Проаналізуйте результат виконання команди.**

Повноваження для видалення даних з таблиці відсутні.

`DELETE FROM car WHERE c_id = 1;`

<img width="302" alt="Снимок экрана 2022-11-28 в 15 54 10" src="https://user-images.githubusercontent.com/46464830/204294824-90f6ec64-8487-431e-b592-20771ed3a26e.png">

## Крок 17

**Встановіть повноваження на видалення таблиці новому користувачеві.**

`GRANT DELETE ON car TO oleksii;`

<img width="314" alt="Снимок экрана 2022-11-28 в 16 01 55" src="https://user-images.githubusercontent.com/46464830/204296464-9e45cdb7-3567-4e86-9b92-5f71ba3c6dd0.png">

## Крок 18

**Повторіть крок 16.**

`DELETE FROM car WHERE c_id = 1;`

<img width="306" alt="Снимок экрана 2022-11-28 в 16 04 37" src="https://user-images.githubusercontent.com/46464830/204297040-682330e3-7c5b-4568-95d7-bd169df028ab.png">

## Крок 19

**Зніміть всі повноваження з таблиці для нового користувача.**

`REVOKE ALL ON car FROM oleksii;`

<img width="303" alt="Снимок экрана 2022-11-28 в 15 58 38" src="https://user-images.githubusercontent.com/46464830/204295798-d5155788-4daa-4984-b273-ab9e55f737bd.png">

## Крок 20

**Створіть команду внесення запису в таблицю (INSERT) і виконайте її від імені нового користувача. Проаналізуйте результат виконання команди.**

Повноваження для додавання даних у таблицю відсутні.

`INSERT INTO car VALUES ('2', 'Mazda', '2006');`

<img width="419" alt="Снимок экрана 2022-11-28 в 15 55 59" src="https://user-images.githubusercontent.com/46464830/204295261-c9f10b5b-9a71-4733-8f62-2ccfd0f62320.png">

## Крок 21

**Встановіть повноваження на внесення даних до таблиці для ролі.**

`GRANT INSERT ON car TO oleksii;`

<img width="322" alt="Снимок экрана 2022-11-28 в 16 00 29" src="https://user-images.githubusercontent.com/46464830/204296184-dac78bd9-acf9-4cf5-b715-fb3682be5f16.png">

## Крок 22

**Повторіть крок 20.**

`INSERT INTO car VALUES ('2', 'Mazda', '2006');
SELECT * FROM car;`

<img width="411" alt="Снимок экрана 2022-11-28 в 16 06 13" src="https://user-images.githubusercontent.com/46464830/204297418-72db2807-03aa-49ce-a624-67215f5eab2c.png">

