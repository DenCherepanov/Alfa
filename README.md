# Используемое ПО

  - Delphi7
  - Allround Automations Direct Oracle Access (ver. 4.1)
  - DevExpress (ver. 14.1.3)
  - Oracle 11gXE (насколько я понял вы используете такую версию)
  - DataGrip [DataGrip](https://www.jetbrains.com/datagrip/) (для импорта данных из csv файлов - папка "Data")

# Запуск скриптов

Все скрипты находятся в папке "Scripts".

1. Подключаемся к серверу под пользователем "system" и запускаем скрипт "create_user.sql".
2. Подключаемся к серверу под новым пользователем "tst" (password: 123), и выполняем скрипт "create_table_trigger.sql". 
3. Выполняем скрипт "procedure.sql".

# Работа с программой

- При запуске проекта появляется окно авторизации. Соответственно вводим пользователь и пароль (tst,123).

![Окно авторизации](Images/1.png)

- При запуске главного окна выбираем слева населенный пункт, справа в гриде получаем список улиц.

![Населенные пункты](Images/2.png)

- При выборе конкретной улицы получаем список застрахованных лиц. 

![Застрахованные лица](Images/3.png)

- Над списком улиц есть поле ввода для фильтрации списка улиц по любому вхождению введеной фразы в названии улицы (LIKE '%<введенная фраза>%'). При нажатии правой клавишей мыши по выделенной строке улицы, появляется всплывающее меню "Объединить".

![Объединение](Images/4.png)
 
 - Подтверждаем процесс объединения выбранной улицы.

![Подтверждение](Images/5.png)

- После объединения улиц получаем заблокированные улицы.

![Заблокированные улицы](Images/6.png)

- Также можно воспользоваться опцией "скрыть заблокированные улицы".

![Список действующих улиц](Images/7.png)

- При нажатии правой клавишей мыши в области грида застрахованных лиц появляется всплывающее меню "Просмотр истории перекодировок".

![История перекодировок](Images/8.png)

- Просмотр истории перекодировок улиц.

![История](Images/9.png)

- При попытке объединить заблокированную улицу получаем сообщение об ошибке.

![Ошибка](Images/10.png)

- При попытке объединить пустой список или одну улицу так же получаем сообщение об ошибке.

![Ошибка](Images/11.png)

- При попытке соединения с сервером через главное окно программы при уже имеющимся соединении получаем сообщение об ошибке.
 
![Ошибка](Images/12.png)

# Подход к реализации пунктов 3.1-3.3 задачи

Для реализации данных пунктов был принят следующий вариант:

1. Использование временной таблицы для получения кодов улиц для объединения (блокирование улиц и обновление адресов застрахованных лиц).
2. Тригер на update таблицы PEOPLESTREET для записи истории перекодировок в таблицу DECODESTREET.

В процессе решения пунктов 3.1-3.3 задания рассматривались варианты использования курсоров или коллекций, но их реализации подразумевает пошаговый проход по элементам, что недопустимо в том случае, если у застрахованного лица адрес регистрации и фактический попадают в список улиц для объединения. В таком случае по одному застрахованному лицу будут две строки в таблице перекодировок, что противоречит условиям задачи.










