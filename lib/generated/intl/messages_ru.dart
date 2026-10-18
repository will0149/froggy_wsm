// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(country) => "Вся ${country}";

  static String m1(year) => "© ${year} Parkea. Все права защищены.";

  static String m2(distance) => "в ${distance}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Пока никто не записался', one: 'Записан ${count}', few: 'Записано ${count}', many: 'Записано ${count}', other: 'Записано ${count}')}";

  static String m4(enrolled, capacity) => "Записано ${enrolled} из ${capacity}";

  static String m5(date) => "Записан ${date}";

  static String m6(code) => "Ошибка (код: ${code})";

  static String m7(percent) => "Событие заполнено на ${percent} %";

  static String m8(capacity, name) =>
      "${Intl.plural(capacity, one: 'Единственное место на «${name}» занято.', few: 'Все ${capacity} места на «${name}» заняты.', many: 'Все ${capacity} мест на «${name}» заняты.', other: 'Все ${capacity} места на «${name}» заняты.')}";

  static String m9(max) =>
      "До ${max} изображений. Обложка показывается в ленте.";

  static String m10(current, total) => "Изображение ${current} из ${total}";

  static String m11(max) =>
      "У события может быть не больше ${max} изображений; добавлены первые.";

  static String m12(error) => "Не удалось выйти: ${error}";

  static String m13(query) => "Никто не найден по запросу «${query}»";

  static String m14(count) => "Осталось мест: ${count}";

  static String m15(id) => "Билет №${id}";

  static String m16(count) => "Предстоящих билетов: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("О приложении"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Находите, создавайте и делитесь событиями.",
    ),
    "aboutEvent": MessageLookupByLibrary.simpleMessage("О событии"),
    "aboutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Версия и условия использования",
    ),
    "accessCode": MessageLookupByLibrary.simpleMessage("Код доступа"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "Это закрытое событие. Введите код, который дал организатор.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Поделитесь им с гостями, чтобы они могли записаться.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage("Введите код"),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "addImages": MessageLookupByLibrary.simpleMessage("Добавить изображения"),
    "addressUnknown": MessageLookupByLibrary.simpleMessage(
      "Для этой точки адрес неизвестен",
    ),
    "allLocations": MessageLookupByLibrary.simpleMessage("Все места"),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("Участники"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Аутентифицировать"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Фото обновлено"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить фото",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Купи билет"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage("Отменить запись"),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Точно отменить запись?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage(
      "Пусто = без ограничений",
    ),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Приключения"),
    "catAll": MessageLookupByLibrary.simpleMessage("Все"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Кемпинг"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Музыка"),
    "catVolunteering": MessageLookupByLibrary.simpleMessage("Волонтёрство"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Мастер-классы"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Без категории"),
    "changeLocation": MessageLookupByLibrary.simpleMessage("Изменить"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Изменить пароль"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Сменить фото"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Код скопирован"),
    "completenessBanner": MessageLookupByLibrary.simpleMessage(
      "Добавьте изображение: события с ним заметнее в ленте.",
    ),
    "completenessCategory": MessageLookupByLibrary.simpleMessage(
      "Выберите категорию, чтобы событие было в фильтрах.",
    ),
    "completenessDescription": MessageLookupByLibrary.simpleMessage(
      "Расскажите в описании, о чём событие.",
    ),
    "completenessPlace": MessageLookupByLibrary.simpleMessage(
      "Укажите место, чтобы знали, куда идти.",
    ),
    "completenessShortDescription": MessageLookupByLibrary.simpleMessage(
      "Добавьте краткое описание: его видно в ленте.",
    ),
    "confirmLocation": MessageLookupByLibrary.simpleMessage(
      "Подтвердить место",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Бесплатно"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("По приглашению"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Платное"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Закрытое"),
    "costType": MessageLookupByLibrary.simpleMessage("Тип доступа"),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть ссылку",
    ),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть карты",
    ),
    "coverImage": MessageLookupByLibrary.simpleMessage("Обложка"),
    "createEvent": MessageLookupByLibrary.simpleMessage("Создать событие"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Тёмная тема"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Данные и конфиденциальность",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "Дата должна быть в будущем",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage("Удалить событие"),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "Все записи тоже будут удалены. Это действие нельзя отменить.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "distanceAway": m2,
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Скачать билет"),
    "editEvent": MessageLookupByLibrary.simpleMessage("Редактировать событие"),
    "editProfile": MessageLookupByLibrary.simpleMessage(
      "Редактировать профиль",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Эл. адрес"),
    "enroll": MessageLookupByLibrary.simpleMessage("Записаться"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledPeople": MessageLookupByLibrary.simpleMessage("Записавшиеся"),
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "Готово! Вы записаны",
    ),
    "errCancelTicket": MessageLookupByLibrary.simpleMessage(
      "Не удалось отменить билет",
    ),
    "errCheckFields": MessageLookupByLibrary.simpleMessage(
      "Проверьте отмеченные поля",
    ),
    "errConnection": MessageLookupByLibrary.simpleMessage(
      "Не удалось подключиться к серверу",
    ),
    "errCreateEvent": MessageLookupByLibrary.simpleMessage(
      "Не удалось создать событие",
    ),
    "errDeleteEvent": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить событие",
    ),
    "errEnroll": MessageLookupByLibrary.simpleMessage(
      "Не удалось завершить запись",
    ),
    "errInvalidResetLink": MessageLookupByLibrary.simpleMessage(
      "Ссылка недействительна или уже использована",
    ),
    "errLoadAttendees": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить участников",
    ),
    "errLoadEvent": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить событие",
    ),
    "errLoadEvents": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить события",
    ),
    "errLoadOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить ваши события",
    ),
    "errLoadProfile": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить профиль",
    ),
    "errLoadPromotions": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить акции",
    ),
    "errLoadSimilar": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить похожие события",
    ),
    "errLoadTickets": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить билеты",
    ),
    "errLogin": MessageLookupByLibrary.simpleMessage("Ошибка входа"),
    "errSaveEvent": MessageLookupByLibrary.simpleMessage(
      "Не удалось сохранить событие",
    ),
    "errSignUp": MessageLookupByLibrary.simpleMessage("Ошибка регистрации"),
    "errSignUpIncomplete": MessageLookupByLibrary.simpleMessage(
      "Не удалось завершить регистрацию",
    ),
    "errWithCode": m6,
    "errWrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Неверное имя пользователя или пароль",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Вместимость"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Категория"),
    "eventComplete": MessageLookupByLibrary.simpleMessage(
      "Событие заполнено полностью!",
    ),
    "eventCompleteness": m7,
    "eventCreated": MessageLookupByLibrary.simpleMessage("Событие создано"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Валюта"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Дата и время"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Событие удалено"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Описание"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Событие завершено"),
    "eventFull": MessageLookupByLibrary.simpleMessage("Все места заняты!"),
    "eventFullMessage": m8,
    "eventLocation": MessageLookupByLibrary.simpleMessage("Место"),
    "eventName": MessageLookupByLibrary.simpleMessage("Название события"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Место"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Цена"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Краткое описание",
    ),
    "eventUpdated": MessageLookupByLibrary.simpleMessage("Событие обновлено"),
    "eventsForAll": MessageLookupByLibrary.simpleMessage("События для всех"),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("События для тебя"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("Пока нет событий"),
    "feedEnd": MessageLookupByLibrary.simpleMessage("Ты посмотрел все события"),
    "feedLoadError": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить события",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Это поле обязательно",
    ),
    "filterByLocation": MessageLookupByLibrary.simpleMessage("Фильтр по месту"),
    "findingAddress": MessageLookupByLibrary.simpleMessage("Ищем адрес…"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Я забыл мой пароль",
    ),
    "galleryHint": m9,
    "getDirections": MessageLookupByLibrary.simpleMessage("Как добраться"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Помощь"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Начать"),
    "great": MessageLookupByLibrary.simpleMessage("Отлично!"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage("Добрый день!"),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("Добрый вечер!"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("Доброе утро!"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "У меня уже есть ссылка",
    ),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage("Вопросы и поддержка"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Организатор"),
    "imageOfTotal": m10,
    "imagesLimitReached": m11,
    "imagesPrepareFailed": MessageLookupByLibrary.simpleMessage(
      "Некоторые изображения не удалось подготовить, они не добавлены.",
    ),
    "imagesSyncFailed": MessageLookupByLibrary.simpleMessage(
      "Событие сохранено, но некоторые изображения не удалось обновить.",
    ),
    "information": MessageLookupByLibrary.simpleMessage("Информация"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage(
      "Неверный код доступа",
    ),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Используй 3-буквенный код, напр. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Неверный адрес эл. почты",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Неверное число"),
    "invalidWebsite": MessageLookupByLibrary.simpleMessage(
      "Введите правильный адрес, например https://parkea.app",
    ),
    "invitationOnly": MessageLookupByLibrary.simpleMessage(
      "Только по приглашению",
    ),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Присоединяйтесь к нашей вселенной",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Оставить"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage("Язык приложения"),
    "lightMode": MessageLookupByLibrary.simpleMessage("Светлая тема"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage("Загрузка события…"),
    "locationNotSet": MessageLookupByLibrary.simpleMessage(
      "Место не указано: событие не появится на карте",
    ),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить места",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Войти в систему"),
    "logout": MessageLookupByLibrary.simpleMessage("Выход"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите выйти?",
    ),
    "logoutFailed": m12,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage("Выйти из аккаунта"),
    "makeCoverImage": MessageLookupByLibrary.simpleMessage("Сделать обложкой"),
    "manageProfile": MessageLookupByLibrary.simpleMessage(
      "Управляйте данными профиля",
    ),
    "mapEnableLocation": MessageLookupByLibrary.simpleMessage("Включить"),
    "mapLocationOff": MessageLookupByLibrary.simpleMessage(
      "Включите геолокацию, чтобы видеть события рядом с вами",
    ),
    "mapMyLocation": MessageLookupByLibrary.simpleMessage("Моё местоположение"),
    "mapNoEvents": MessageLookupByLibrary.simpleMessage(
      "Нет предстоящих событий с местоположением",
    ),
    "mapOpenSettings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "moveMapHint": MessageLookupByLibrary.simpleMessage(
      "Двигайте карту, чтобы поставить метку",
    ),
    "myEvents": MessageLookupByLibrary.simpleMessage("Мероприятия"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Оплаченный"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Сохранено"),
    "myLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Не удалось определить ваше местоположение",
    ),
    "myTickets": MessageLookupByLibrary.simpleMessage("Мои билеты"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Создать"),
    "navHome": MessageLookupByLibrary.simpleMessage("Главная"),
    "navMap": MessageLookupByLibrary.simpleMessage("Карта"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Билеты"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "noAttendeesMatch": m13,
    "noCapacityLimit": MessageLookupByLibrary.simpleMessage(
      "Без ограничения мест",
    ),
    "noEventsInLocation": MessageLookupByLibrary.simpleMessage(
      "Нет предстоящих событий в этом месте",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Ты ещё не создал ни одного события",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage(
      "Нет прошедших билетов",
    ),
    "noPlacesFound": MessageLookupByLibrary.simpleMessage(
      "Мы не нашли это место",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Нет событий по твоему запросу",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "Нет предстоящих билетов",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
    "notificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Push-уведомления и оповещения",
    ),
    "ownEvent": MessageLookupByLibrary.simpleMessage("Ваше событие"),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage(
      "Parkea и поделиться!",
    ),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "Пароль не может состоять только из цифр",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage(
      "Пароль обновлён. Войдите в систему.",
    ),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
      "Этот пароль слишком распространён",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Пароль должен содержать не менее 8 символов",
    ),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "Пароль слишком похож на имя пользователя или эл. адрес",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Оплата скоро появится",
    ),
    "pickOnMap": MessageLookupByLibrary.simpleMessage("Выбрать на карте"),
    "popularEvents": MessageLookupByLibrary.simpleMessage("Популярные события"),
    "preferences": MessageLookupByLibrary.simpleMessage("Настройки"),
    "pressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Нажмите «Назад» ещё раз, чтобы выйти",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Цена должна быть больше 0",
    ),
    "privacySubtitle": MessageLookupByLibrary.simpleMessage(
      "Конфиденциальность и данные",
    ),
    "profileBio": MessageLookupByLibrary.simpleMessage("Описание"),
    "profileBioHint": MessageLookupByLibrary.simpleMessage(
      "Расскажите, кто вы или что организуете",
    ),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Профиль недоступен",
    ),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить профиль",
    ),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("Профиль обновлён"),
    "profileWebsite": MessageLookupByLibrary.simpleMessage("Сайт"),
    "promotions": MessageLookupByLibrary.simpleMessage("Акции"),
    "province": MessageLookupByLibrary.simpleMessage("Провинция"),
    "publishEvent": MessageLookupByLibrary.simpleMessage(
      "Опубликовать событие",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
    "removeImage": MessageLookupByLibrary.simpleMessage("Удалить изображение"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("Убрать место"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Если адрес зарегистрирован, мы отправили ссылку для сброса пароля",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("сохранить событие"),
    "searchAttendees": MessageLookupByLibrary.simpleMessage(
      "Поиск по имени или логину",
    ),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Поиск занятий"),
    "searchPlace": MessageLookupByLibrary.simpleMessage(
      "Поиск адреса или места",
    ),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Показать событие"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "signUp": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "Подобные мероприятия",
    ),
    "slideCelebrateText": MessageLookupByLibrary.simpleMessage(
      "Записывайтесь в одно касание, билеты всегда с вами.",
    ),
    "slideCelebrateTitle": MessageLookupByLibrary.simpleMessage(
      "Празднуйте вместе",
    ),
    "slideRelaxText": MessageLookupByLibrary.simpleMessage(
      "Создавайте свои события и привлекайте больше людей.",
    ),
    "slideRelaxTitle": MessageLookupByLibrary.simpleMessage(
      "Отдыхайте в хорошей компании",
    ),
    "slideShareText": MessageLookupByLibrary.simpleMessage(
      "Находите события рядом и делитесь ими с друзьями.",
    ),
    "slideShareTitle": MessageLookupByLibrary.simpleMessage(
      "Делитесь с друзьями",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Мест нет"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так",
    ),
    "spotsLeft": m14,
    "supportLegal": MessageLookupByLibrary.simpleMessage(
      "Поддержка и правовая информация",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage("Запись отменена"),
    "ticketNumber": m15,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить билеты",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Прошедшие"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Предстоящие"),
    "upcomingTicketsCount": m16,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя или эл. адрес",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Введите имя пользователя или эл. адрес",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Открыть событие"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Мой билет"),
    "volunteeringFreeNote": MessageLookupByLibrary.simpleMessage(
      "Волонтёрские события бесплатны, записаться может любой.",
    ),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage(
      "¡Добро пожаловать обратно!",
    ),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Ваш профиль"),
  };
}
