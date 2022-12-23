#### Перевірити роботу створених безпечних функцій.

Створити знімки екранів з результатами виконання викликів функції та розмітити їх у файлі secure_results.md у GitHub-репозиторії.

<img width="635" alt="Снимок экрана 2022-12-23 в 18 44 47" src="https://user-images.githubusercontent.com/46464830/209370973-3851ba71-4ae7-471c-a367-3dba7eac9771.png">

`SELECT * FROM get_data('1'' OR 1=1 -- ');`

<img width="400" alt="Снимок экрана 2022-12-23 в 18 55 57" src="https://user-images.githubusercontent.com/46464830/209372813-1115ed43-57da-44ef-98bf-56cbbdd12eef.png">


`SELECT * FROM get_data('1'' UNION SELECT CAST(NULL AS INTEGER), CAST(role_name AS VARCHAR), CAST(access_level AS INTEGER) FROM role_access_level -- ');
`

<img width="564" alt="Снимок экрана 2022-12-23 в 18 55 17" src="https://user-images.githubusercontent.com/46464830/209372740-276650d0-c6fa-4572-b125-77a33610e780.png">

`SELECT * FROM get_data('1'' UNION (SELECT a1, CAST(a1 AS VARCHAR), CAST(a1 AS INTEGER) FROM (SELECT generate_series a1 FROM generate_series (1,1000)) t1 CROSS JOIN (SELECT * FROM generate_series (1,1000) t2) t3) -- ');`

<img width="565" alt="Снимок экрана 2022-12-23 в 18 57 13" src="https://user-images.githubusercontent.com/46464830/209372965-9487ff03-fc48-4fa6-a8f9-3db1cea4cc25.png">
