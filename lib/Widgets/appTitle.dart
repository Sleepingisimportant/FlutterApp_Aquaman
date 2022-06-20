import 'package:aquaman/models/generalData.dart';
import 'package:aquaman/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AppTitleV1 extends StatefulWidget {
  @override
  _AppTitleV1State createState() => _AppTitleV1State();
}

class _AppTitleV1State extends State<AppTitleV1> {
  bool targetReached = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<GeneralData>(context).getIntakePercent >= 100
        ? targetReached = true
        : targetReached = false;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${Provider.of<GeneralData>(context).getIntakePercent}',
                style: kBigNumber(context),
                textAlign: TextAlign.start,
              ),
              Text('%', style: kBigNumberPercentage(context)),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/ic_waterDrop.png'),
                fit: BoxFit.contain,
                width: 25.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: Text(
                  '${Provider.of<GeneralData>(context).getCurrentAmount} ml / ${Provider.of<GeneralData>(context).getDailyWaterIntakeTarget} ml',
                  style: kBigNumberSubText(context),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: targetReached,
          child: Container(
            padding: EdgeInsets.all(0.0),
            alignment: Alignment.center,
            child: RotateAnimatedTextKit(
              text: ["TARGET REACHED"],
              textStyle: TextStyle(
                  fontSize: 0.15 * MediaQuery.of(context).size.width,
                  fontFamily: "Horizon",
                  fontWeight: FontWeight.w100,
                  color: Color(kBlueColor)),
              textAlign: TextAlign.center,
              isRepeatingAnimation: false,
              duration: Duration(milliseconds: 2500),
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
