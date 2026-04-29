# Morpheus — Dream Journal with AI Interpretation

Flutter-приложение для ведения дневника снов с автоматической AI-интерпретацией на основе подхода Юнга. Бэкенд — Go + Fiber с PostgreSQL.

---

## Стек

| Слой | Технологии |
|---|---|
| Mobile | Flutter (Dart 3.10+), BLoC, auto_route, Freezed |
| Auth | JWT (HS256), `flutter_secure_storage` |
| Backend | Go 1.22, Fiber v2, GORM, PostgreSQL |
| AI | Google Gemini API (`gemini-1.5-flash`) |
| Analytics | Firebase Analytics |
| Локализация | easy_localization (RU / EN) |

---

## Архитектура

### Flutter — Clean Architecture по фичам

```
lib/
├── main.dart                    # Точка входа, Firebase, DI, BLoC
├── injection.dart               # get_it + injectable регистрация
├── routes/                      # auto_route роутер + AuthGuard
├── core/
│   ├── config/app_config.dart   # API URL (через --dart-define=API_URL=...)
│   ├── di/network_module.dart   # Dio + AuthInterceptor
│   ├── network/auth_interceptor.dart  # Читает JWT из TokenStorage
│   ├── services/
│   │   ├── token_storage.dart   # Хранение JWT (flutter_secure_storage)
│   │   └── analytics_service.dart
│   └── presentation/            # Общие виджеты, тема, ThemeCubit
└── features/
    ├── auth/                    # Регистрация, вход, восстановление пароля, профиль
    ├── dreams/                  # CRUD снов, детальный экран, список
    └── friends/                 # Добавление друзей, запросы, просмотр снов друга
```

### Go Backend

```
backend/
├── cmd/server/main.go          # Точка входа, регистрация маршрутов Fiber
├── internal/
│   ├── config/config.go        # Конфиг из .env / переменных окружения
│   ├── database/database.go    # Подключение PostgreSQL + AutoMigrate
│   ├── models/                 # GORM-модели: User, Dream, Friend, FriendRequest
│   ├── middleware/auth.go      # JWT-мидлварь (извлечение userID из claims)
│   ├── handlers/               # AuthHandler, DreamsHandler, FriendsHandler, UsersHandler
│   └── services/
│       ├── ai_service.go       # Gemini API — async интерпретация в goroutine
│       └── email_service.go    # SMTP (dev: логирует в консоль)
├── Dockerfile
├── docker-compose.yml
└── Makefile
```

### Флоу интерпретации сна

```
POST /dreams → Handler создаёт запись (isReady=false)
       │
       └──▶ goroutine → Gemini API (Юнг-анализ)
                  │
                  └──▶ UPDATE dreams SET interpretation=..., is_ready=true
                            │
                            └──▶ Flutter опрашивает список каждые 5 сек, пока isReady=false
```

### Флоу аутентификации

```
POST /auth/register → создаёт user (is_active=false) → email с 6-значным кодом
POST /auth/confirm  → активирует user
POST /auth/login    → проверяет bcrypt → возвращает JWT (30 дней)
Flutter хранит JWT в flutter_secure_storage
AuthInterceptor добавляет Bearer-заголовок к каждому запросу
```

---

## API Endpoints

Все маршруты кроме `/auth/*` (register, confirm, login, forgot-password, reset-password) защищены JWT.

| Метод | Путь | Описание |
|---|---|---|
| `POST` | `/auth/register` | Регистрация |
| `POST` | `/auth/confirm` | Подтверждение email |
| `POST` | `/auth/login` | Вход, получение JWT |
| `POST` | `/auth/forgot-password` | Отправить код сброса |
| `POST` | `/auth/reset-password` | Сменить пароль по коду |
| `GET` | `/auth/me` | Профиль текущего пользователя |
| `PUT` | `/auth/password` | Смена пароля |
| `DELETE` | `/auth/me` | Удаление аккаунта |
| `POST` | `/dreams` | Создать сон |
| `GET` | `/dreams` | Список снов (пагинация, поиск, фильтры) |
| `PUT` | `/dreams/:id` | Обновить сон |
| `DELETE` | `/dreams/:id` | Удалить сон |
| `GET` | `/users/search` | Поиск пользователей по email |
| `POST` | `/friends` | Отправить запрос в друзья |
| `GET` | `/friends` | Список друзей |
| `DELETE` | `/friends/:id` | Удалить друга |
| `GET` | `/friends/:id/dreams` | Сны друга |
| `GET` | `/friend-requests` | Входящие запросы |
| `POST` | `/friend-requests/:id/accept` | Принять запрос |
| `POST` | `/friend-requests/:id/decline` | Отклонить запрос |

---

## Локальный запуск

### Требования

- Flutter SDK 3.10+
- Docker + Docker Compose

### 1. Бэкенд

```bash
cp backend/.env.example backend/.env
# Заполните GEMINI_API_KEY и JWT_SECRET в backend/.env

docker compose up --build
```

Сервер запустится на `http://localhost:8080`. PostgreSQL поднимается автоматически, сервер стартует только после готовности БД.

Остановить:
```bash
docker compose down
```

Остановить и сбросить данные:
```bash
docker compose down -v
```

### 2. Flutter

```bash
# Установить зависимости
flutter pub get

# Регенерировать код (Freezed, auto_route, injectable)
dart run build_runner build --delete-conflicting-outputs

# Запустить, указав URL бэкенда
flutter run --dart-define=API_URL=http://localhost:8080
```

На Android-эмуляторе вместо `localhost` используйте `10.0.2.2`:
```bash
flutter run --dart-define=API_URL=http://10.0.2.2:8080
```

---

## Деплой бэкенда

На любом сервере с Docker:

```bash
docker compose up -d --build
```

Сборка Flutter для prod:
```bash
# APK
./increment_build.sh && flutter build apk --release --dart-define=API_URL=https://your-server.com

# App Bundle
./increment_build.sh && flutter build appbundle --release --dart-define=API_URL=https://your-server.com
```

---

## Переменные окружения бэкенда

Шаблон находится в [`backend/.env.example`](backend/.env.example). Скопируйте его в `backend/.env` и заполните:

```env
PORT=8080
DATABASE_URL=host=localhost user=postgres password=postgres dbname=morpheus port=5432 sslmode=disable
JWT_SECRET=change-me-in-production-use-long-random-string
GEMINI_API_KEY=

# Опционально — без SMTP коды выводятся в лог контейнера
SMTP_HOST=
SMTP_PORT=587
SMTP_USER=
SMTP_PASSWORD=
SMTP_FROM=noreply@morpheus.app
```

> При запуске через `docker compose` значение `DATABASE_URL` переопределяется автоматически на `host=postgres ...` — менять его вручную не нужно.

| Переменная | Обязательна | Описание |
|---|---|---|
| `PORT` | нет | Порт HTTP-сервера (по умолчанию `8080`) |
| `DATABASE_URL` | да | PostgreSQL DSN |
| `JWT_SECRET` | **да** | Секрет подписи JWT — задайте длинную случайную строку |
| `GEMINI_API_KEY` | нет | Ключ Google AI для интерпретации снов |
| `SMTP_HOST` | нет | SMTP-сервер; если пусто — коды пишутся в лог |
| `SMTP_PORT` | нет | Порт SMTP (по умолчанию `587`) |
| `SMTP_USER` | нет | Логин SMTP |
| `SMTP_PASSWORD` | нет | Пароль SMTP |
| `SMTP_FROM` | нет | Адрес отправителя писем |

---

## Кодогенерация Flutter

После изменения аннотированных файлов:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Затрагивает: `Freezed` (модели/стейты), `json_serializable` (DTO), `auto_route` (роутер), `injectable` (DI).

---

## Стейт-менеджмент

| BLoC | Ответственность |
|---|---|
| `AuthBloc` | Проверка JWT, выход |
| `SignInBloc` / `SignUpBloc` | Формы входа и регистрации |
| `ForgotPasswordBloc` / `ResetPasswordBloc` | Восстановление пароля |
| `ProfileBloc` | Профиль, смена пароля, удаление аккаунта |
| `DreamsBloc` | Список снов, создание, удаление, polling |
| `FriendsBloc` | Список друзей, поиск |
| `FriendRequestsBloc` | Управление запросами |
| `ThemeCubit` | Тема (light/dark), персистируется через HydratedBloc |
