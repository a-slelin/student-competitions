# Документация StudentCompetitionsApi

В данном файле находится необходимая информация, советы и руководство по использованию StudentCompetitionsApi.

## Предварительно

В качестве языка для backend-сервера используется последняя Long Term Support (LTS)-версия Java Development Kit (JDK) -
**25**.

В качестве Integrated Development Environment (IDE) используется **IntelliJ IDEA Community Edition 2025.2.3**.

Для быстрого и качественного написания кода используется фреймворк **Spring 6** (6.2.x) и **Spring Boot 3**
(3.5.6).

Для сборки кода на Java используется **Apache Maven 3.9.9**.

Также может быть использован **Docker** (client.version: 28.5.1, engine.version: 28.5.1);

## Данные

Для взаимодействия используются пять Data Transfer Object (DTO): LevelDto, ResultDto, StudentDto, CompetitionDto и
ParticipationDto.

### LevelDto

LeveDto:

* code (String): код;
* name (String): название;
* order (Integer): порядок сортировки.

Пример:

```json5
{
  code: "RUS",
  name: "Всероссийский",
  order: 3
}
```

### ResultDto

ResultDto:

* code (String): код;
* name (String): название;
* order (Integer): порядок сортировки.

Пример:

```json5
{
  code: "PRIZE",
  name: "Призер",
  order: 2
}
```

### StudentDto

StudentDto:

* id (String): идентификатор;
* name (String): имя;
* surname (String): фамилия;
* middleName (String): отчество (опционально);
* cardNumber (Long): номер студенческого билета;
* faculty (String): факультет;
* department (String): кафедра (опционально);
* studyGroup (String): учебная группа (опционально);
* email (String): электронная почта (опционально);
* phone (String): номер телефона (опционально).

Пример:

```json5
{
  id: "8dd01f45-f038-4d88-8606-5d04714b5ed5",
  name: "aleksander",
  surname: "slelin",
  middleName: "vladimirovich",
  cardNumber: 1036575,
  faculty: "Faculty of Mathematics",
  department: null,
  studyGroup: "PMI-11MO",
  email: "a.slelin.work@mail.ru",
  phone: null
}
```

#### Faculty

Возможные значения для факультета (можно передавать русский аналог):

* Faculty of Biology and Ecology (Факультет биологии и экологии),
* Faculty of Computer Science and Engineering (Факультет информатики и вычислительной техники),
* Faculty of History (Исторический факультет),
* Faculty of Mathematics (Математический факультет),
* Faculty of Psychology (Факультет психологии),
* Faculty of Social and Political Sciences (Факультет социально-политических наук),
* Faculty of Foreign Languages (Факультет иностранных языков),
* Faculty of Physics and Technology (Физико-технический факультет),
* Faculty of Philology and Communication (Факультет филологии и коммуникации),
* Faculty of Economics (Экономический факультет),
* Faculty of Law (Юридический факультет).

### CompetitionDto

CompetitionDto:

* id (String): идентификатор;
* name (String): название;
* organizer (String): организатор (опционально);
* type (String): тип.

Пример:

```json5
{
  id: "8dd01f45-f038-4d88-8606-5d04714b5ed5",
  name: "Bear&Mouse",
  organizer: "NPO Krissta",
  type: "olympiad"
}
```

#### Type

Возможные значения для типа (можно передавать русский аналог):

* Olympiad (Олимпиада),
* Contest (Состязание),
* Championship (Чемпионат),
* Competition (Соревнование).

### ParticipationDto

ParticipationDto:

* id (String): идентификатор;
* student (URI): ссылка на студента;
* competition (URI): ссылка на соревнование;
* level (URI): ссылка на уровень;
* result (URI): ссылка на результат;
* year (Integer): год;
* supervisor (String): научный руководитель (опционально);
* points (Integer): количество баллов (опционально);
* description (String): описание (опционально);
* isBlocked (Boolean): флаг блокировки редактирования.

Пример:

```json5
{
  id: "8dd01f45-f038-4d88-8606-5d04714b5ed5",
  student: "http://localhost:8080/api/students/3dd01f45-f038-4d88-8606-5d04714b5ed5",
  competiton: "http://localhost:8080/api/competitions/5dd01f45-f038-4d88-8606-5d04714b5ed5",
  level: "http://localhost:8080/api/levels/RUS",
  result: "http://localhost:8080/api/results/WIN",
  year: 2023,
  supervisor: null,
  points: 60,
  description: null,
  isBlocked: true
}
```

### Read & Save Dto

Для создания и обновления сущности используются специальные SaveDto, которые представляют собой обычный Dto без id, но
для создания level и result нужно передавать и id. Также стоит сказать, что isBlocked нельзя поменять извне.

Например, если мы хотим создать соревнование то могли бы отправить следующее:

```json5
{
  name: "mega championship",
  type: "olympiad"
}
```

а после, например, решили обновить так:

```json5
{
  supervisor: "yargu demidova",
  type: "championship"
}
```

### SortDto

Используется для передачи информации о сортировке.

SortDto:

* property (String): поле, по которому происходит сортировка;
* direction (String): направление сортировки (ASC или DESC в любом регистре).

Пример:

```json5
{
  property: "cardNumber",
  direction: "ASC"
}
```

### PageDto

Используется для указания информации о странице.

PageDto:

* number (Integer): текущий номер;
* size (Integer): количество элементов на текущей странице;
* sorts (List(SortDto)): используемые сортировки;
* totalElements (Long): количество всех элементов;
* totalPages (Integer): количество всех страниц;
* first (Boolean): первая ли страница;
* last (Boolean): последняя ли страница;
* empty (Boolean): пустая ли страница.

Пример:

```json5
{
  number: 5,
  size: 10,
  sorts: [
    {
      property: "sortOrder",
      direction: "ASC"
    },
    {
      property: "id",
      direction: "DESC"
    }
  ],
  totalElements: 100,
  totalPages: 10,
  first: false,
  last: false,
  empty: false
}
```

### SheetDto(T)

Используется для получения контента и страницы для сущности T.

SheetDto(T):

* content (List(T)): сами запрашиваемые объекты;
* page (PageDto): информация о странице.

Пример (для не введенных еще данных):

```json5
{
  content: [],
  page: {
    number: 0,
    size: 10,
    sorts: [
      {
        property: "sortOrder",
        direction: "ASC"
      },
      {
        property: "id",
        direction: "DESC"
      }
    ],
    totalElements: 0,
    totalPages: 0,
    first: true,
    last: true,
    empty: true
  }
}
```

### FilterChain

Используется для задания цепочки фильтров, которые применяются к результату.

FilterChain:

* filters (List(Filter)): фильтры.

Пример:

```json5
{
  filters: [
    {
      field: "isBlocked",
      operation: "is true"
    },
    {
      field: "year",
      opearion: "between",
      value: 2000,
      value2: 2025
    },
    {
      field: "student.cardNumber",
      operation: "equals",
      value: 1035633
    }
  ]
}
```

#### Filter

Используется для задания фильтра.

Filter:

* field (String): поле;
* operation (Operation): операция;
* value (Object): первое значение (опционально);
* value2 (Object): второе значение (опционально).

Пример:

```json5
{
  field: "year",
  opearion: "between",
  value: 2000,
  value2: 2025
}
```

#### Operation

Возможные значения для операций следующие (можно использовать русский аналог):

* equals (равно);
* not equals (не равно);
* greater (больше);
* greater or equals (больше или равно);
* less (меньше);
* less or equals (меньше или равно);
* like (содержит);
* not like (не содержит);
* starts with (начинается с);
* not starts with (не начинается с);
* ends with (заканчивается);
* not ends with (не заканчивается);
* is null (не определено);
* is not null (определено);
* is empty (пусто);
* is not empty (не пусто);
* is true (истина);
* is false (ложь);
* in (в списке);
* not in (не в списке);
* between (между);
* not between (не между);
* before (до);
* after (после).

## REST

Для взаимодействия с REST API используется медиа-тип: **application/json**, а также стандартное именование путей:

1) Сначала формируется базовый url как протокол (http), затем имя сервера (localhost) и порт (8080),
   например, http://localhost:8080.
2) После чего добавляется стандартный api-префикс перед всеми названиями сущностей (api).
3) Далее добавляется название сущности во множественном числе, например, для студентов будет students.

Например, базовый путь для уровней может быть таким: http://myserver:8082/api/levels.

Вы также можете задать свои пути через переменные окружения (в скобках находятся дефолтные значения):

* API_PROTOCOL (http): служебная информация, важно указывать для корректной работы;
* API_SERVER (localhost): служебная информация, важно указывать для корректной работы;
* API_PORT (8080): служебная информация, важно указывать для корректной работы;
* SERVER_PORT (8080): меняет порт, на котором будет запущено приложение;
* API_API_PREFIX (api): задает стандартный api-префикс;
* API_LEVEL_PREFIX (levels): задает префикс для сущности уровня;
* API_RESULT_PREFIX (results): задает префикс для сущности результата;
* API_STUDENT_PREFIX (students): задает префикс для сущности студента;
* API_COMPETITION_PREFIX (competitions): задает префикс для сущности соревнования;
* API_PARTICIPATION_PREFIX (participations): задает префикс для сущности участия;
* API_SEARCH_PREFIX (search): задает префикс для поиска.

### Методы

#### Чтение

##### Все

Для того чтобы получить список записей, используется стандартный url для сущности с http-методом GET. Например, для
студентов это может выглядеть так: GET http://localhost:8080/api/students.

* Операция: возвращает список записей, а также информацию о странице (дополнительно для уровней и результатов фильтрует
  по name и/или order);
* Ожидаемые параметры: page(0) - номер страницы, size(10) - размер страницы, sort(null) - возможные сортировки
  (дополнительно для уровней и результатов можно задать name(null) - фильтрация по полю name и order(null) - фильтрация
  по полю sortOrder);
* Ожидаемое тело запроса: не ожидается;
* Результат: http-статус 200 OK и SheetDto(соответствующее ReadDto).

Примеры:

* http://localhost:8080/api/students?page=5&size=10&sort=sortOrder,asc;
* http://localhost:8080/api/levels?page=5&name=Вс;
* http://localhost:8080/api/competitions?size=10.

##### Конкретный

Для того чтобы получить конкретный запись по идентификатору, используется стандартный url для сущности и добавленный
идентификатор с http-методом GET. Например, для уровней это может выглядеть так:
GET http://localhost:8080/api/levels/RUS.

* Операция: возвращает запись по идентификатору;
* Ожидаемы параметры: не ожидается;
* Ожидаемое тело запроса: не ожидается;
* Результат: http-статус 200 OK и соответствующее ReadDto.

Примеры:

* http://localhost:8080/api/students/8dd01f45-f038-4d88-8606-5d04714b5ed5;
* http://localhost:8080/api/results/WIN;
* http://localhost:8080/api/competitions/1dd01f45-f038-4d88-8606-5d04714b5ed5.

##### По фильтру

Для того чтобы получить список записей, применяя фильтр, используется стандартный url для сущности и добавляется
поисковый
префикс с http-методом POST. Например, для результатов это может выглядеть так:
POST http://localhost:8080/api/results/search.

* Операция: возвращает отфильтрованные записи и информацию о странице.
* Ожидаемые параметры: page(0) - номер страницы, size(10) - размер страницы, sort(null) - возможные сортировки;
* Ожидаемое тело запроса: FilterChain.
* Результат: http-статус 200 OK и SheetDto(соответствующее ReadDto).

Примеры:

* http://localhost:8080/api/students/search/?page=5&size=10&sort=sortOrder,asc;
* http://localhost:8080/api/levels/search/?page=5;
* http://localhost:8080/api/competitions/search/?size=10.

#### Создание

Для того чтобы создать новую запись, используется стандартный url для сущности с http-методом POST. Например, для
создания соревнований это может выглядеть так: POST http://localhost:8080/api/competitions.

* Операция: создаёт новую запись и возвращает ссылку на неё;
* Ожидаемые параметры: не ожидается;
* Ожидаемое тело запроса: соответсвующее SaveDto;
* Результат: http-статус 201 CREATED и URI (в заголовках с именем Location).

#### Обновление

##### Полное

Для того чтобы полностью обновить запись, используется стандартный url для сущности вместе с идентификатором с
http-методом PUT. Например, для результатов это может выглядеть так: PUT http://localhost:8080/api/results/WIN.

* Операция: полностью обновляет запись с переданным идентификатором и возвращает её;
* Ожидаемые параметры: не ожидается;
* Ожидаемое тело запроса: соответствующее SaveDto;
* Результат: http-статус 200 OK и соответствующее ReadDto.

##### Частичное

Для того чтобы частично обновить запись, используется стандартный url для сущности вместе с идентификатором с
http-методом PATCH. Например, для результатов это может выглядеть так: PATCH http://localhost:8080/api/results/WIN.

* Операция: частично обновляет запись с переданным идентификатором и возвращает её;
* Ожидаемые параметры: не ожидается;
* Ожидаемое тело запроса: соответствующее SaveDto;
* Результат: http-статус 200 OK и соответствующее ReadDto.

#### Удаление

Для того чтобы удалить запись, используется стандартный url для сущности вместе с идентификатором с http-методом DELETE.
Например, для студентов это может выглядеть так:
DELETE http://localhost:8080/api/students/8dd01f45-f038-4d88-8606-5d04714b5ed5.

* Операция: удаляет запись;
* Ожидаемые параметры: не ожидается;
* Ожидаемое тело запроса: не ожидается;
* Результат: http-статус 204 NO_CONTENT.

## Запуск

### Стандартный запуск

Для запуска необходимо выполнить следующие действия:

```shell

# Клонируем репозиторий
git clone https://github.com/a-slelin/student-competitions.git;

# Переходим в папку backend
cd student-competitions/backend;

# Собираем проект с помощью Maven
mvn clean package;

# Запускаем само приложение, передавая необходимые переменные окружения
java -jar target/StudentCompetitionsApi.jar \
    --DB_HOST=<ваш хост для базы данных> \
    --DB_PORT=<ваш порт для базы данных> \
    --DB_NAME=<название вашей базы данных> \
    --DB_USERNAME=<пользователь в базе данных> \
    --DB_PASSWORD=<пароль для данного пользователя>;

```

Остановить программу можно обычным "Ctrl+C".

### Быстрый запуск с помощью DockerCompose

Для быстрого запуска можно использовать DockerCompose файл, для этого необходимо, чтобы был установлен docker на вашу
машину. Следуйте инструкциям (необходимыми настройками можно управлять в .yaml манифесте):

```shell

# Клонируем репозиторий
git clone https://github.com/a-slelin/student-competitions.git;

# Переходим в папку backend
cd student-competitions/backend;

# Запускаем приложение и базу данных 
docker compose up;
```

Для остановки программы можно сделать следующее:

```shell

docker compose down;

```

## Релизы

На данный момент последняя версия StudentCompetitionsApi - 1.0.0.

## Статус

В разработке

## Разработчики

* Слелин А.В.

