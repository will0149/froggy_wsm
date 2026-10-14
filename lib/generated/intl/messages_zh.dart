// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(date) => "報名於 ${date}";

  static String m1(count) => "剩餘 ${count} 個名額";

  static String m2(id) => "票券 #${id}";

  static String m3(count) => "${count} 張即將到來的票券";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutEvent": MessageLookupByLibrary.simpleMessage("關於活動"),
    "addBanner": MessageLookupByLibrary.simpleMessage("新增圖片"),
    "authenticate": MessageLookupByLibrary.simpleMessage("进行身份验证"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("照片已更新"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage("無法更新照片"),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage("活動已建立，但圖片無法上傳"),
    "buyTicket": MessageLookupByLibrary.simpleMessage("买车票"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage("取消報名"),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage("確定要取消報名嗎？"),
    "capacityHint": MessageLookupByLibrary.simpleMessage("留空 = 不限"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("冒險"),
    "catCamping": MessageLookupByLibrary.simpleMessage("露營"),
    "catMusic": MessageLookupByLibrary.simpleMessage("音樂"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("工作坊"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("無類別"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("更換圖片"),
    "changePassword": MessageLookupByLibrary.simpleMessage("變更密碼"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("更換照片"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("確認密碼"),
    "costFree": MessageLookupByLibrary.simpleMessage("免費"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("受邀參加"),
    "costPaid": MessageLookupByLibrary.simpleMessage("付費"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("私人"),
    "costType": MessageLookupByLibrary.simpleMessage("入場方式"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage("無法開啟地圖應用程式"),
    "createEvent": MessageLookupByLibrary.simpleMessage("建立活動"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage("數據和隱私"),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage("日期必須是未來時間"),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "downloadTicket": MessageLookupByLibrary.simpleMessage("下載票券"),
    "email": MessageLookupByLibrary.simpleMessage("電子郵件"),
    "enrolledOn": m0,
    "eventCapacity": MessageLookupByLibrary.simpleMessage("名額"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("類別"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("活動已建立"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("貨幣"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("日期和時間"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("描述"),
    "eventLocation": MessageLookupByLibrary.simpleMessage("地點"),
    "eventName": MessageLookupByLibrary.simpleMessage("活動名稱"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("地點"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("價格"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage("簡短描述"),
    "eventsForAll": MessageLookupByLibrary.simpleMessage("適合所有人的活動"),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("為你推薦的活動"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("目前還沒有活動"),
    "feedEnd": MessageLookupByLibrary.simpleMessage("你已看完所有活動"),
    "feedLoadError": MessageLookupByLibrary.simpleMessage("無法載入活動"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("此欄位為必填"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("我忘記了我的密碼"),
    "getDirections": MessageLookupByLibrary.simpleMessage("路線"),
    "getHelp": MessageLookupByLibrary.simpleMessage("救命"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("我已經有連結"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("主辦者"),
    "information": MessageLookupByLibrary.simpleMessage("信息"),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "請使用 3 個字母的代碼，例如 USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("電子郵件地址無效"),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("數字無效"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage("加入我們的宇宙"),
    "keepTicket": MessageLookupByLibrary.simpleMessage("保留"),
    "login": MessageLookupByLibrary.simpleMessage("登錄"),
    "logout": MessageLookupByLibrary.simpleMessage("登出"),
    "myEvents": MessageLookupByLibrary.simpleMessage("事件"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("已報名"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("有薪酬的"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("已保存"),
    "myTickets": MessageLookupByLibrary.simpleMessage("我的票券"),
    "name": MessageLookupByLibrary.simpleMessage("名稱"),
    "navHome": MessageLookupByLibrary.simpleMessage("首頁"),
    "navProfile": MessageLookupByLibrary.simpleMessage("個人檔案"),
    "navTickets": MessageLookupByLibrary.simpleMessage("票券"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新密碼"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage("你沒有報名任何活動"),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage("你還沒有建立任何活動"),
    "noPastTickets": MessageLookupByLibrary.simpleMessage("沒有過去的票券"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage("沒有符合搜尋的活動"),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage("沒有即將到來的票券"),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage("Parkea & Comparte"),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("密碼"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "密碼不能只包含數字",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage("密碼已更新，請登入。"),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage("此密碼太常見"),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage("密碼至少需要 8 個字元"),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "密碼與使用者名稱或電子郵件太相似",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage("密碼不一致"),
    "popularEvents": MessageLookupByLibrary.simpleMessage("流行的事件"),
    "pricePositive": MessageLookupByLibrary.simpleMessage("價格必須大於 0"),
    "province": MessageLookupByLibrary.simpleMessage("省"),
    "publishEvent": MessageLookupByLibrary.simpleMessage("發布活動"),
    "register": MessageLookupByLibrary.simpleMessage("報名"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "如果此電子郵件已註冊，我們已寄送重設密碼的連結",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("重試"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("保存事件"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("搜尋活動"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("显示事件"),
    "settings": MessageLookupByLibrary.simpleMessage("設置"),
    "signUp": MessageLookupByLibrary.simpleMessage("報名"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("類似事件"),
    "soldOut": MessageLookupByLibrary.simpleMessage("已額滿"),
    "spotsLeft": m1,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage("已取消報名"),
    "ticketNumber": m2,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage("無法載入票券"),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("已結束"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("即將到來"),
    "upcomingTicketsCount": m3,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage("使用者名稱或電子郵件"),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "請輸入使用者名稱或電子郵件",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("查看活動"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡歡迎回來!"),
  };
}
