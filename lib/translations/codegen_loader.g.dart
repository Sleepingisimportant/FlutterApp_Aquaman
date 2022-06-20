// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> zh = {
    "global": {"app_name": "Aquaman"},
    "settings": {
      "setting": "设定",
      "language": "语言",
      "selected_language": "简中",
      "notification": "通知",
      "start": "开始",
      "end": "结束",
      "interval": "间隔",
      "no_notif_being_generated": "若要成功设定通知，开始时间必须早于（或同时于）结束时间。",
      "hour": "小时",
      "daily_water_intake": "每日饮水量",
      "set_daily_water_intake": "设定每日饮水量",
      "calculate_water_intake_target": "计算每日饮水量",
      "age": "年纪",
      "years_old": "岁",
      "weight": "体重",
      "calculate": "计算"
    },
    "notif_content": {"notif_title": "你该喝水咯!", "notif_body": "点我进入应用程序。"},
    "customized_amount": {"customize_water_intake": "自定义摄取量", "confirm": "确认"},
    "records": {
      "my_records": "我的纪录",
      "latest_7_days": "最近七天",
      "latest_30_days": "最近三十天",
      "latest_60_days": "最近六十天",
      "latest_90_days": "最近九十天",
      "target_reached": "目标达成：",
      "days": "天",
      "today": "今天"
    }
  };
  static const Map<String, dynamic> de = {
    "global": {"app_name": "Aquaman"},
    "settings": {
      "setting": "Einstellung",
      "language": "Sprache",
      "selected_language": "Deutsch",
      "notification": "Benachrichtigung",
      "start": "Start",
      "end": "Ende",
      "interval": "Intervall",
      "no_notif_being_generated":
          "Keine Benachrichtigung wird generiert, wenn die Endzeit vor oder gleich der Startzeit eingestellt ist.",
      "hour": "Stunde(n)",
      "daily_water_intake": "Tägliche Wasseraufnahme",
      "set_daily_water_intake": "Tägliches Aufnahmeziel",
      "calculate_water_intake_target": "Tägliches Aufnahmeziel Berechnen",
      "age": "Alter",
      "years_old": "Jahr(e)",
      "weight": "Gewicht",
      "calculate": "Berechnen"
    },
    "notif_content": {
      "notif_title": "GEH WASSER TRINKEN!",
      "notif_body": "Klick mich um die App aufzurufen."
    },
    "customized_amount": {
      "customize_water_intake": "Menge Anpassen",
      "confirm": "Bestätigen"
    },
    "records": {
      "my_records": "我的纪录",
      "latest_7_days": "Vor 7 Tagen",
      "latest_30_days": "Vor 30 Tagen",
      "latest_60_days": "Vor 60 Tagen",
      "latest_90_days": "Vor 90 Tagen",
      "target_reached": "Ziel erreicht:",
      "days": "Tag(e)",
      "today": "Heute"
    }
  };
  static const Map<String, dynamic> pl = {
    "global": {"app_name": "Aquaman"},
    "settings": {
      "setting": "設定",
      "language": "語言",
      "selected_language": "繁中",
      "notification": "通知",
      "start": "開始",
      "end": "結束",
      "interval": "間隔",
      "no_notif_being_generated": "若要成功設定通知，開始時間必須早於（或同時於）結束時間。",
      "hour": "小時",
      "daily_water_intake": "每日飲水量",
      "set_daily_water_intake": "設定每日飲水量",
      "calculate_water_intake_target": "計算每日飲水量",
      "age": "年紀",
      "years_old": "歲",
      "weight": "體重",
      "calculate": "計算"
    },
    "notif_content": {"notif_title": "你該喝水囉!", "notif_body": "點我進入APP。"},
    "customized_amount": {"customize_water_intake": "自訂攝取量", "confirm": "確定"},
    "records": {
      "my_records": "我的紀錄",
      "latest_7_days": "最近七天",
      "latest_30_days": "最近三十天",
      "latest_60_days": "最近六十天",
      "latest_90_days": "最近九十天",
      "target_reached": "目標達成：",
      "days": "天",
      "today": "今天"
    }
  };
  static const Map<String, dynamic> en = {
    "global": {"app_name": "Aquaman"},
    "settings": {
      "setting": "Settings",
      "language": "Language",
      "selected_language": "English",
      "notification": "Notification",
      "start": "Start",
      "end": "End",
      "interval": "Interval",
      "no_notif_being_generated":
          "No notification will be generated if the End time is set prior to the Start time.",
      "hour": "Hour(s)",
      "daily_water_intake": "Daily Water Intake",
      "set_daily_water_intake": "Set Daily Water Intake",
      "calculate_water_intake_target": "Calculate  Water Intake Target",
      "age": "Age",
      "years_old": "yr",
      "weight": "Weight",
      "calculate": "Calculate"
    },
    "notif_content": {
      "notif_title": "GO DRINK WATER",
      "notif_body": "Tap me to enter the App."
    },
    "customized_amount": {
      "customize_water_intake": "Customize Water Intake",
      "confirm": "Confirm"
    },
    "records": {
      "my_records": "My Records",
      "latest_7_days": "Latest 7 days",
      "latest_30_days": "Latest 30 day",
      "latest_60_days": "Latest 60 day",
      "latest_90_days": "Latest 90 day",
      "target_reached": "Target reached:",
      "days": "Day(s)",
      "today": "Today"
    }
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "zh": zh,
    "de": de,
    "pl": pl,
    "en": en
  };
}
