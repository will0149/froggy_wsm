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

  static String m0(country) => "${country} 全部";

  static String m1(year) => "© ${year} Parkea。保留所有權利。";

  static String m2(distance) => "距離 ${distance}";

  static String m3(count) =>
      "${Intl.plural(count, zero: '尚無人報名', other: '已有 ${count} 人報名')}";

  static String m4(enrolled, capacity) => "已報名 ${enrolled} / ${capacity}";

  static String m5(date) => "報名於 ${date}";

  static String m6(code) => "錯誤（代碼：${code}）";

  static String m7(percent) => "你的活動已完成 ${percent}%";

  static String m8(capacity, name) =>
      "${Intl.plural(capacity, other: '「${name}」的 ${capacity} 個名額已全部額滿。')}";

  static String m9(error) => "無法登出：${error}";

  static String m10(query) => "没有与“${query}”匹配的人";

  static String m11(count) => "剩餘 ${count} 個名額";

  static String m12(id) => "票券 #${id}";

  static String m13(count) => "${count} 張即將到來的票券";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("關於"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage("探索、建立並分享活動。"),
    "aboutEvent": MessageLookupByLibrary.simpleMessage("關於活動"),
    "aboutSubtitle": MessageLookupByLibrary.simpleMessage("版本與服務條款"),
    "accessCode": MessageLookupByLibrary.simpleMessage("存取碼"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "這是私人活動。請輸入主辦方提供的代碼。",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "分享給你的來賓，讓他們可以報名。",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage("請輸入代碼"),
    "account": MessageLookupByLibrary.simpleMessage("帳號"),
    "addBanner": MessageLookupByLibrary.simpleMessage("新增圖片"),
    "addressUnknown": MessageLookupByLibrary.simpleMessage("此位置没有已知地址"),
    "allLocations": MessageLookupByLibrary.simpleMessage("所有地點"),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("報名者"),
    "authenticate": MessageLookupByLibrary.simpleMessage("进行身份验证"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("照片已更新"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage("無法更新照片"),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage("活動已建立，但圖片無法上傳"),
    "buyTicket": MessageLookupByLibrary.simpleMessage("买车票"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage("取消報名"),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage("確定要取消報名嗎？"),
    "capacityHint": MessageLookupByLibrary.simpleMessage("留空 = 不限"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("冒險"),
    "catAll": MessageLookupByLibrary.simpleMessage("全部"),
    "catCamping": MessageLookupByLibrary.simpleMessage("露營"),
    "catMusic": MessageLookupByLibrary.simpleMessage("音樂"),
    "catVolunteering": MessageLookupByLibrary.simpleMessage("志工服務"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("工作坊"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("無類別"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("更換圖片"),
    "changeLocation": MessageLookupByLibrary.simpleMessage("更改"),
    "changePassword": MessageLookupByLibrary.simpleMessage("變更密碼"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("更換照片"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("代碼已複製"),
    "completenessBanner": MessageLookupByLibrary.simpleMessage(
      "加上圖片：有圖片的活動在動態中更醒目。",
    ),
    "completenessCategory": MessageLookupByLibrary.simpleMessage(
      "選擇分類，讓活動出現在篩選中。",
    ),
    "completenessDescription": MessageLookupByLibrary.simpleMessage(
      "在描述中說明活動內容。",
    ),
    "completenessPlace": MessageLookupByLibrary.simpleMessage(
      "填寫地點，讓大家知道要去哪裡。",
    ),
    "completenessShortDescription": MessageLookupByLibrary.simpleMessage(
      "加上簡短描述：這是動態中顯示的內容。",
    ),
    "confirmLocation": MessageLookupByLibrary.simpleMessage("确认位置"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("確認密碼"),
    "costFree": MessageLookupByLibrary.simpleMessage("免費"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("受邀參加"),
    "costPaid": MessageLookupByLibrary.simpleMessage("付費"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("私人"),
    "costType": MessageLookupByLibrary.simpleMessage("入場方式"),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage("無法開啟連結"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage("無法開啟地圖應用程式"),
    "createEvent": MessageLookupByLibrary.simpleMessage("建立活動"),
    "darkMode": MessageLookupByLibrary.simpleMessage("深色模式"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage("數據和隱私"),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage("日期必須是未來時間"),
    "deleteEvent": MessageLookupByLibrary.simpleMessage("刪除活動"),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "所有報名也會一併刪除，此操作無法復原。",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "distanceAway": m2,
    "downloadTicket": MessageLookupByLibrary.simpleMessage("下載票券"),
    "editEvent": MessageLookupByLibrary.simpleMessage("編輯活動"),
    "editProfile": MessageLookupByLibrary.simpleMessage("編輯個人資料"),
    "email": MessageLookupByLibrary.simpleMessage("電子郵件"),
    "enroll": MessageLookupByLibrary.simpleMessage("報名"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledPeople": MessageLookupByLibrary.simpleMessage("已报名的人"),
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage("完成！你已報名"),
    "errCancelTicket": MessageLookupByLibrary.simpleMessage("無法取消票券"),
    "errCheckFields": MessageLookupByLibrary.simpleMessage("請檢查標示的欄位"),
    "errConnection": MessageLookupByLibrary.simpleMessage("無法連線到伺服器"),
    "errCreateEvent": MessageLookupByLibrary.simpleMessage("無法建立活動"),
    "errDeleteEvent": MessageLookupByLibrary.simpleMessage("無法刪除活動"),
    "errEnroll": MessageLookupByLibrary.simpleMessage("無法完成報名"),
    "errInvalidResetLink": MessageLookupByLibrary.simpleMessage("連結無效或已使用過"),
    "errLoadAttendees": MessageLookupByLibrary.simpleMessage("无法加载报名者"),
    "errLoadEvent": MessageLookupByLibrary.simpleMessage("無法載入活動"),
    "errLoadEvents": MessageLookupByLibrary.simpleMessage("無法載入活動列表"),
    "errLoadOwnEvents": MessageLookupByLibrary.simpleMessage("無法載入你的活動"),
    "errLoadProfile": MessageLookupByLibrary.simpleMessage("無法載入個人資料"),
    "errLoadPromotions": MessageLookupByLibrary.simpleMessage("無法載入優惠"),
    "errLoadSimilar": MessageLookupByLibrary.simpleMessage("無法載入類似活動"),
    "errLoadTickets": MessageLookupByLibrary.simpleMessage("無法載入票券"),
    "errLogin": MessageLookupByLibrary.simpleMessage("登入失敗"),
    "errSaveEvent": MessageLookupByLibrary.simpleMessage("無法儲存活動"),
    "errSignUp": MessageLookupByLibrary.simpleMessage("註冊失敗"),
    "errSignUpIncomplete": MessageLookupByLibrary.simpleMessage("無法完成註冊"),
    "errWithCode": m6,
    "errWrongCredentials": MessageLookupByLibrary.simpleMessage("使用者名稱或密碼錯誤"),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("名額"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("類別"),
    "eventComplete": MessageLookupByLibrary.simpleMessage("你的活動資料已完整！"),
    "eventCompleteness": m7,
    "eventCreated": MessageLookupByLibrary.simpleMessage("活動已建立"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("貨幣"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("日期和時間"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("活動已刪除"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("描述"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("活動已結束"),
    "eventFull": MessageLookupByLibrary.simpleMessage("活動額滿！"),
    "eventFullMessage": m8,
    "eventLocation": MessageLookupByLibrary.simpleMessage("位置"),
    "eventName": MessageLookupByLibrary.simpleMessage("活動名稱"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("地點"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("價格"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage("簡短描述"),
    "eventUpdated": MessageLookupByLibrary.simpleMessage("活動已更新"),
    "eventsForAll": MessageLookupByLibrary.simpleMessage("適合所有人的活動"),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("為你推薦的活動"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("目前還沒有活動"),
    "feedEnd": MessageLookupByLibrary.simpleMessage("你已看完所有活動"),
    "feedLoadError": MessageLookupByLibrary.simpleMessage("無法載入活動"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("此欄位為必填"),
    "filterByLocation": MessageLookupByLibrary.simpleMessage("依地點篩選"),
    "findingAddress": MessageLookupByLibrary.simpleMessage("正在查找地址…"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("我忘記了我的密碼"),
    "getDirections": MessageLookupByLibrary.simpleMessage("路線"),
    "getHelp": MessageLookupByLibrary.simpleMessage("救命"),
    "getStarted": MessageLookupByLibrary.simpleMessage("開始"),
    "great": MessageLookupByLibrary.simpleMessage("太好了！"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage("午安！"),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("晚安！"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("早安！"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("我已經有連結"),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage("常見問題與支援"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("主辦者"),
    "information": MessageLookupByLibrary.simpleMessage("信息"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage("存取碼無效"),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "請使用 3 個字母的代碼，例如 USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("電子郵件地址無效"),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("數字無效"),
    "invalidWebsite": MessageLookupByLibrary.simpleMessage(
      "請輸入有效的網址，例如 https://parkea.app",
    ),
    "invitationOnly": MessageLookupByLibrary.simpleMessage("僅限邀請"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage("加入我們的宇宙"),
    "keepTicket": MessageLookupByLibrary.simpleMessage("保留"),
    "language": MessageLookupByLibrary.simpleMessage("語言"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage("應用程式語言"),
    "lightMode": MessageLookupByLibrary.simpleMessage("淺色模式"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage("正在載入活動…"),
    "locationNotSet": MessageLookupByLibrary.simpleMessage("未设置位置：活动不会显示在地图上"),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage("無法載入地點"),
    "login": MessageLookupByLibrary.simpleMessage("登錄"),
    "logout": MessageLookupByLibrary.simpleMessage("登出"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage("確定要登出嗎？"),
    "logoutFailed": m9,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage("登出你的帳號"),
    "manageProfile": MessageLookupByLibrary.simpleMessage("管理你的個人資料"),
    "mapEnableLocation": MessageLookupByLibrary.simpleMessage("開啟"),
    "mapLocationOff": MessageLookupByLibrary.simpleMessage("開啟定位以查看你附近的活動"),
    "mapMyLocation": MessageLookupByLibrary.simpleMessage("我的位置"),
    "mapNoEvents": MessageLookupByLibrary.simpleMessage("沒有帶位置的即將舉行活動"),
    "mapOpenSettings": MessageLookupByLibrary.simpleMessage("設定"),
    "moveMapHint": MessageLookupByLibrary.simpleMessage("移动地图以放置图钉"),
    "myEvents": MessageLookupByLibrary.simpleMessage("事件"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("有薪酬的"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("已保存"),
    "myLocationUnavailable": MessageLookupByLibrary.simpleMessage("无法获取你的位置"),
    "myTickets": MessageLookupByLibrary.simpleMessage("我的票券"),
    "name": MessageLookupByLibrary.simpleMessage("名稱"),
    "navCreate": MessageLookupByLibrary.simpleMessage("建立"),
    "navHome": MessageLookupByLibrary.simpleMessage("首頁"),
    "navMap": MessageLookupByLibrary.simpleMessage("地圖"),
    "navProfile": MessageLookupByLibrary.simpleMessage("個人檔案"),
    "navTickets": MessageLookupByLibrary.simpleMessage("票券"),
    "newPassword": MessageLookupByLibrary.simpleMessage("新密碼"),
    "noAttendeesMatch": m10,
    "noCapacityLimit": MessageLookupByLibrary.simpleMessage("不限名額"),
    "noEventsInLocation": MessageLookupByLibrary.simpleMessage("此地點沒有即將舉行的活動"),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage("你還沒有建立任何活動"),
    "noPastTickets": MessageLookupByLibrary.simpleMessage("沒有過去的票券"),
    "noPlacesFound": MessageLookupByLibrary.simpleMessage("找不到该地点"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage("沒有符合搜尋的活動"),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage("沒有即將到來的票券"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "notificationsSubtitle": MessageLookupByLibrary.simpleMessage("推播通知與提醒"),
    "ownEvent": MessageLookupByLibrary.simpleMessage("你的活動"),
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
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage("即將開放付款"),
    "pickOnMap": MessageLookupByLibrary.simpleMessage("在地图上选择"),
    "popularEvents": MessageLookupByLibrary.simpleMessage("流行的事件"),
    "preferences": MessageLookupByLibrary.simpleMessage("偏好設定"),
    "pressBackToExit": MessageLookupByLibrary.simpleMessage("再按一次返回鍵即可離開"),
    "pricePositive": MessageLookupByLibrary.simpleMessage("價格必須大於 0"),
    "privacySubtitle": MessageLookupByLibrary.simpleMessage("隱私權政策與資料使用"),
    "profileBio": MessageLookupByLibrary.simpleMessage("簡介"),
    "profileBioHint": MessageLookupByLibrary.simpleMessage("介紹一下你自己或你舉辦的活動"),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage("無法使用個人資料"),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage("無法更新個人資料"),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("個人資料已更新"),
    "profileWebsite": MessageLookupByLibrary.simpleMessage("網站"),
    "promotions": MessageLookupByLibrary.simpleMessage("優惠活動"),
    "province": MessageLookupByLibrary.simpleMessage("省"),
    "publishEvent": MessageLookupByLibrary.simpleMessage("發布活動"),
    "register": MessageLookupByLibrary.simpleMessage("報名"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("移除位置"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "如果此電子郵件已註冊，我們已寄送重設密碼的連結",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("重試"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("儲存變更"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("保存事件"),
    "searchAttendees": MessageLookupByLibrary.simpleMessage("按姓名或用户名搜索"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("搜尋活動"),
    "searchPlace": MessageLookupByLibrary.simpleMessage("搜索地址或地点"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("显示事件"),
    "settings": MessageLookupByLibrary.simpleMessage("設置"),
    "signUp": MessageLookupByLibrary.simpleMessage("報名"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("類似事件"),
    "slideCelebrateText": MessageLookupByLibrary.simpleMessage("一鍵報名，票券隨身帶著走。"),
    "slideCelebrateTitle": MessageLookupByLibrary.simpleMessage("一起慶祝"),
    "slideRelaxText": MessageLookupByLibrary.simpleMessage("建立你自己的活動，觸及更多人。"),
    "slideRelaxTitle": MessageLookupByLibrary.simpleMessage("與好友一同放鬆"),
    "slideShareText": MessageLookupByLibrary.simpleMessage("探索你附近的活動並與朋友分享。"),
    "slideShareTitle": MessageLookupByLibrary.simpleMessage("與朋友分享"),
    "soldOut": MessageLookupByLibrary.simpleMessage("已額滿"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage("發生錯誤"),
    "spotsLeft": m11,
    "supportLegal": MessageLookupByLibrary.simpleMessage("支援與法律"),
    "theme": MessageLookupByLibrary.simpleMessage("主題"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage("已取消報名"),
    "ticketNumber": m12,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage("無法載入票券"),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("已結束"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("即將到來"),
    "upcomingTicketsCount": m13,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage("使用者名稱或電子郵件"),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "請輸入使用者名稱或電子郵件",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("查看活動"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("查看我的票"),
    "volunteeringFreeNote": MessageLookupByLibrary.simpleMessage(
      "志工活動免費，任何人都可以報名。",
    ),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡歡迎回來!"),
    "yourProfile": MessageLookupByLibrary.simpleMessage("你的個人資料"),
  };
}
