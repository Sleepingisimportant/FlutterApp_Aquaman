import 'package:flutter/material.dart';
import 'package:aquaman/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';

class Last7Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> listDailyIntakePercentage =
        Provider.of<GeneralData>(context, listen: false)
            .getDailyIntakePercentage;

    if (listDailyIntakePercentage.length > 7) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(7, (index) {
            return bar7Days(
                context,
                int.parse(
                    listDailyIntakePercentage.reversed.elementAt(6 - index)));
          }));
    } else if (listDailyIntakePercentage.length <= 7 &&
        listDailyIntakePercentage.length > 0) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(listDailyIntakePercentage.length, (index) {
            return bar7Days(
                context,
                int.parse(listDailyIntakePercentage.reversed
                    .elementAt(listDailyIntakePercentage.length - 1 - index)));
          }));
    } else if (listDailyIntakePercentage.length == 0) {
      return Row();
    } else {
      return null;
    }
  }
}

class Last30Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> listDailyIntakePercentage =
        Provider.of<GeneralData>(context, listen: false)
            .getDailyIntakePercentage;

    if (listDailyIntakePercentage.length > 30) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(30, (index) {
            return bar30Days(
                context,
                int.parse(
                    listDailyIntakePercentage.reversed.elementAt(29 - index)));
          }));
    } else if (listDailyIntakePercentage.length <= 30 &&
        listDailyIntakePercentage.length > 0) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(listDailyIntakePercentage.length, (index) {
            return bar30Days(
                context,
                int.parse(listDailyIntakePercentage.reversed
                    .elementAt(listDailyIntakePercentage.length - 1 - index)));
          }));
    } else if (listDailyIntakePercentage.length == 0) {
      return Row();
    } else {
      return null;
    }
  }
}

class Last60Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> listDailyIntakePercentage =
        Provider.of<GeneralData>(context, listen: false)
            .getDailyIntakePercentage;

    if (listDailyIntakePercentage.length > 60) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(60, (index) {
            return bar60Days(
                context,
                int.parse(
                    listDailyIntakePercentage.reversed.elementAt(59 - index)));
          }));
    } else if (listDailyIntakePercentage.length <= 60 &&
        listDailyIntakePercentage.length > 0) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(listDailyIntakePercentage.length, (index) {
            return bar60Days(
                context,
                int.parse(listDailyIntakePercentage.reversed
                    .elementAt(listDailyIntakePercentage.length - 1 - index)));
          }));
    } else if (listDailyIntakePercentage.length == 0) {
      return Row();
    } else {
      return null;
    }
  }
}

class Last90Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> listDailyIntakePercentage =
        Provider.of<GeneralData>(context, listen: false)
            .getDailyIntakePercentage;

    if (listDailyIntakePercentage.length > 90) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(90, (index) {
            return bar90Days(
                context,
                int.parse(
                    listDailyIntakePercentage.reversed.elementAt(89 - index)));
          }));
    } else if (listDailyIntakePercentage.length <= 90 &&
        listDailyIntakePercentage.length > 0) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(listDailyIntakePercentage.length, (index) {
            return bar90Days(
                context,
                int.parse(listDailyIntakePercentage.reversed
                    .elementAt(listDailyIntakePercentage.length - 1 - index)));
          }));
    } else if (listDailyIntakePercentage.length == 0) {
      return Row();
    } else {
      return null;
    }
  }
}
