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

  static String m1(date) => "Записан ${date}";

  static String m2(count) => "Осталось мест: ${count}";

  static String m3(id) => "Билет №${id}";

  static String m4(count) => "Предстоящих билетов: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutEvent": MessageLookupByLibrary.simpleMessage("О событии"),
    "accessCode": MessageLookupByLibrary.simpleMessage("Код доступа"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "Это закрытое событие. Введите код, который дал организатор.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Поделитесь им с гостями, чтобы они могли записаться.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage("Введите код"),
    "addBanner": MessageLookupByLibrary.simpleMessage("Добавить изображение"),
    "allLocations": MessageLookupByLibrary.simpleMessage("Все места"),
    "allOfCountry": m0,
    "authenticate": MessageLookupByLibrary.simpleMessage("Аутентифицировать"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Фото обновлено"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить фото",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Событие создано, но изображение не удалось загрузить",
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
    "catCamping": MessageLookupByLibrary.simpleMessage("Кемпинг"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Музыка"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Мастер-классы"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Без категории"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Сменить изображение"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Изменить пароль"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Сменить фото"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Код скопирован"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Бесплатно"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("По приглашению"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Платное"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Закрытое"),
    "costType": MessageLookupByLibrary.simpleMessage("Тип доступа"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Не удалось открыть карты",
    ),
    "createEvent": MessageLookupByLibrary.simpleMessage("Создать событие"),
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
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Скачать билет"),
    "editEvent": MessageLookupByLibrary.simpleMessage("Редактировать событие"),
    "email": MessageLookupByLibrary.simpleMessage("Эл. адрес"),
    "enroll": MessageLookupByLibrary.simpleMessage("Записаться"),
    "enrolledOn": m1,
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "Готово! Вы записаны",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Вместимость"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Категория"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("Событие создано"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Валюта"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Дата и время"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Событие удалено"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Описание"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Событие завершено"),
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
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Я забыл мой пароль",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Как добраться"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Помощь"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "У меня уже есть ссылка",
    ),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Организатор"),
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
    "invitationOnly": MessageLookupByLibrary.simpleMessage(
      "Только по приглашению",
    ),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Присоединяйтесь к нашей вселенной",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Оставить"),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить места",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Войти в систему"),
    "logout": MessageLookupByLibrary.simpleMessage("Выход"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Мероприятия"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("Записан"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Оплаченный"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Сохранено"),
    "myTickets": MessageLookupByLibrary.simpleMessage("Мои билеты"),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "navHome": MessageLookupByLibrary.simpleMessage("Главная"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Билеты"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage(
      "Ты не записан ни на одно событие",
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
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Нет событий по твоему запросу",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "Нет предстоящих билетов",
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
    "popularEvents": MessageLookupByLibrary.simpleMessage("Популярные события"),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Цена должна быть больше 0",
    ),
    "province": MessageLookupByLibrary.simpleMessage("Провинция"),
    "publishEvent": MessageLookupByLibrary.simpleMessage(
      "Опубликовать событие",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Если адрес зарегистрирован, мы отправили ссылку для сброса пароля",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Повторить"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Сохранить изменения"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("сохранить событие"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Поиск занятий"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Показать событие"),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "signUp": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "Подобные мероприятия",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Мест нет"),
    "spotsLeft": m2,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage("Запись отменена"),
    "ticketNumber": m3,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить билеты",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Прошедшие"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Предстоящие"),
    "upcomingTicketsCount": m4,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя или эл. адрес",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Введите имя пользователя или эл. адрес",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Открыть событие"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Мой билет"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage(
      "¡Добро пожаловать обратно!",
    ),
  };
}
