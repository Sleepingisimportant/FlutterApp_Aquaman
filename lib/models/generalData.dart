import 'dart:core';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralData extends ChangeNotifier {
  List<String> _addedWaterAmount = [];
  List<String> _dailyIntakePercentage = [];
  int totalRecordsDays = 0;
  int currentAmount = 0;
  int dailyWaterIntakeTarget;
  int intakePercentage = 0;
  double waveHeightIndex = 1;
  Future<double> waveIndex;
  String customizedAmount;
  int reachedTargetIn7Days = 0;
  int reachedTargetIn30Days = 0;
  int reachedTargetIn60Days = 0;
  int reachedTargetIn90Days = 0;
  String selectedLanguage;

  Future<void> languageSetting(String language) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (language == 'English') {
      selectedLanguage = 'English';
    } else if (language == 'Deutsch') {
      selectedLanguage = 'Deutsch';
    } else if (language == '繁體中文') {
      selectedLanguage = '繁體中文';
    } else if (language == '简体中文') {
      selectedLanguage = '简体中文';
    }
    prefs.setString('selectedLanguage', language);

    notifyListeners();
  }

  Future<void> getStoreLanguageSetting() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    selectedLanguage = prefs.getString('selectedLanguage');
  }

  String get getSelectedLanguage {
    getStoreLanguageSetting();
    if (selectedLanguage == null) {
      selectedLanguage = 'English';
    }
    return selectedLanguage;
  }

  Future<void> calculatedTargetReachedDay() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getStringList('_dailyIntakePercentage') != null) {
      List<int> dailyIntakePercentageIntList = prefs
          .getStringList('_dailyIntakePercentage')
          .map((data) => int.parse(data))
          .toList();

      // List<int> dailyIntakePercentageIntListReversed =
      //     dailyIntakePercentageIntList.reversed;

      for (int i = 0; i < dailyIntakePercentageIntList.length; i++) {
        if (dailyIntakePercentageIntList[
                dailyIntakePercentageIntList.length - 1 - i] >=
            100) {
          if (i < 7) {
            reachedTargetIn7Days++;
          }
          if (i < 30) {
            reachedTargetIn30Days++;
          }
          if (i < 60) {
            reachedTargetIn60Days++;
          }
          if (i < 90) {
            reachedTargetIn90Days++;
          }
        }
        prefs.setInt('_reachedTargetIn7Days', reachedTargetIn7Days);
        prefs.setInt('_reachedTargetIn30Days', reachedTargetIn30Days);
        prefs.setInt('_reachedTargetIn60Days', reachedTargetIn60Days);
        prefs.setInt('_reachedTargetIn90Days', reachedTargetIn90Days);
      }

      notifyListeners();
    }
  }

  Future<void> getReachedTargetDays() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    reachedTargetIn7Days = prefs.getInt('_reachedTargetIn7Days');
    if (reachedTargetIn7Days == null) {
      reachedTargetIn7Days = 0;
    }
    reachedTargetIn30Days = prefs.getInt('_reachedTargetIn30Days');
    if (reachedTargetIn30Days == null) {
      reachedTargetIn30Days = 0;
    }
    reachedTargetIn60Days = prefs.getInt('_reachedTargetIn60Days');
    if (reachedTargetIn60Days == null) {
      reachedTargetIn60Days = 0;
    }
    reachedTargetIn90Days = prefs.getInt('_reachedTargetIn90Days');
    if (reachedTargetIn90Days == null) {
      reachedTargetIn90Days = 0;
    }
  }

  int get getReachedTargetIn7Days {
    getReachedTargetDays();
    return reachedTargetIn7Days;
  }

  //
  int get getReachedTargetIn30Days {
    getReachedTargetDays();
    return reachedTargetIn30Days;
  }

  int get getReachedTargetIn60Days {
    getReachedTargetDays();
    return reachedTargetIn60Days;
  }

  int get getReachedTargetIn90Days {
    getReachedTargetDays();
    return reachedTargetIn90Days;
  }

  Future<void> storeDailyWaterIntakeTarget(int dayDifference) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getStringList('_dailyIntakePercentage') != null) {
      _dailyIntakePercentage = prefs.getStringList('_dailyIntakePercentage');
      _dailyIntakePercentage.add(getIntakePercent.toString());
      prefs.setStringList('_dailyIntakePercentage', _dailyIntakePercentage);
    } else {
      _dailyIntakePercentage.add(getIntakePercent.toString());
      prefs.setStringList('_dailyIntakePercentage', _dailyIntakePercentage);
    }

    for (int i = 1; i < dayDifference; i++) {
      _dailyIntakePercentage = prefs.getStringList('_dailyIntakePercentage');
      _dailyIntakePercentage.add('0');
      prefs.setStringList('_dailyIntakePercentage', _dailyIntakePercentage);
    }

    // prefs.setInt('totalRecordsDays',
    //     prefs.getStringList('_dailyIntakePercentage').length);

    notifyListeners();
  }

  Future<void> getStoredDailyPercentage() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getStringList('_dailyIntakePercentage') == null) {
      _dailyIntakePercentage = [];
    } else {
      _dailyIntakePercentage = prefs.getStringList('_dailyIntakePercentage');
    }
    notifyListeners();
  }

  List<String> get getDailyIntakePercentage {
    getStoredDailyPercentage();
    return _dailyIntakePercentage;
  }

  // Future<void> getStoredTotalRecordsDays() async {
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences prefs = await _prefs;
  //
  //   if (prefs.getInt('totalRecordsDays') == null) {
  //     totalRecordsDays = 0;
  //   } else {
  //     totalRecordsDays = prefs.getInt('totalRecordsDays');
  //   }
  //   notifyListeners();
  // }
  //
  // int get getTotalRecordsDays {
  //   getStoredTotalRecordsDays();
  //   return totalRecordsDays;
  // }

  Future<void> removeDataDaily() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setStringList('_addedWaterAmount', []);
    prefs.setInt('currentAmount', 0);
    prefs.setString('latestUpdatedTime', '');

    notifyListeners();
  }

  Future<void> updateAmount(int addedAmount) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getStringList('_addedWaterAmount') == null) {
      _addedWaterAmount = [];
    } else {
      //get list<string>
      _addedWaterAmount = prefs.getStringList('_addedWaterAmount');
      // notifyListeners();
    }

    _addedWaterAmount.add(addedAmount.toString());
    prefs.setStringList('_addedWaterAmount', _addedWaterAmount);

    currentAmount = currentAmount + addedAmount;

    storeCurrentAmount();

    calculateIntakePercent();
    getWaveHeightIndex();

    notifyListeners();
  }

  Future<void> storeUpdateTime() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    //
    // tz.initializeTimeZones();
    // var berlin = tz.getLocation('Europe/Amsterdam');
    // tz.setLocalLocation(berlin);
    final DateTime now = DateTime.now();

    prefs.setString('latestUpdatedTime', now.toString());
  }

  Future<void> revertAmount() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (prefs.getStringList('_addedWaterAmount') == null) {
      _addedWaterAmount = [];
    } else {
      //get list<string>
      _addedWaterAmount = prefs.getStringList('_addedWaterAmount');
      notifyListeners();
    }

    currentAmount = currentAmount -
        int.parse(_addedWaterAmount[_addedWaterAmount.length - 1]);
    _addedWaterAmount.removeLast();

    prefs.setStringList('_addedWaterAmount', _addedWaterAmount);

    storeCurrentAmount();
    getWaveHeightIndex();
    calculateIntakePercent();

    notifyListeners();
  }

  Future<void> storeCurrentAmount() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('currentAmount', currentAmount);
  }

  Future<void> getStoreCurrentAmount() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getInt('currentAmount') == null) {
      currentAmount = 0;
    } else {
      currentAmount = prefs.getInt('currentAmount');
    }
    notifyListeners();
  }

  int get getCurrentAmount {
    getStoreCurrentAmount();
    return currentAmount;
  }

  void storeWaterIntakeData(int newTarget) {
    dailyWaterIntakeTarget = newTarget;
    calculateIntakePercent();
    getWaveHeightIndex();

    notifyListeners();
  }

  Future<void> calculateIntakePercent() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getInt('waterIntakeTarget') == null) {
      dailyWaterIntakeTarget = 2000;
    } else {
      dailyWaterIntakeTarget = prefs.getInt('waterIntakeTarget');
    }

    if (prefs.getInt('currentAmount') == null) {
      currentAmount = 0;
    } else {
      currentAmount = prefs.getInt('currentAmount');
    }

    intakePercentage =
        // ((getCurrentAmount / getDailyWaterIntakeTarget) * 100.0).round();
        ((currentAmount / dailyWaterIntakeTarget) * 100.0).floor();

    notifyListeners();
  }

  int get getIntakePercent {
    calculateIntakePercent();
    return intakePercentage;
  }

  double get waveHeightIndexData {
    getWaveHeightIndex();
    return waveHeightIndex;
  }

  Future<double> getWaveHeightIndex() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (prefs.getInt('waterIntakeTarget') == null) {
      dailyWaterIntakeTarget = 2000;
    } else {
      dailyWaterIntakeTarget = prefs.getInt('waterIntakeTarget');
    }

    if (prefs.getInt('currentAmount') == null) {
      currentAmount = 0;
    } else {
      currentAmount = prefs.getInt('currentAmount');
    }
    waveHeightIndex = 1 -
        (double.parse(
            (currentAmount / dailyWaterIntakeTarget).toStringAsFixed(2)));

    // prefs.setDouble('waveHeightIndex', waveHeightIndex);
    notifyListeners();

    return waveHeightIndex;
  }

  int get getDailyWaterIntakeTarget {
    getStoredWaterIntake();
    return dailyWaterIntakeTarget;
  }

  Future<void> getStoredWaterIntake() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (prefs.getInt('waterIntakeTarget') == null) {
      dailyWaterIntakeTarget = 2000;
    } else {
      dailyWaterIntakeTarget = prefs.getInt('waterIntakeTarget');
    }

    notifyListeners();
  }

  Future<void> storeCustomizedAmount(String customizedAmount) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('customizedAmount', customizedAmount);
    notifyListeners();
  }

  Future<void> getCustomizedAmount() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    customizedAmount = prefs.getString('customizedAmount');

    if (prefs.getString('customizedAmount') != null) {
      customizedAmount = prefs.getString('customizedAmount');
    } else {
      customizedAmount = '130';
    }
  }

  String get getStoredCustomizedAmount {
    getCustomizedAmount();
    return customizedAmount;
  }
}
