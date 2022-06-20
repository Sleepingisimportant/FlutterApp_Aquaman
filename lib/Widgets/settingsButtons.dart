import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aquaman/utilities/constants.dart';
import 'package:aquaman/screens/settingsScreen.dart';

class SettingsButtons extends StatelessWidget {
  const SettingsButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 0.06 * MediaQuery.of(context).size.width,
        left: 0.06 * MediaQuery.of(context).size.width,
        top: 0.07 * MediaQuery.of(context).size.height,
      ),
      alignment: Alignment.topRight,
      //add margin
      child: IconButton(
        onPressed: () {
          // Navigate to setting screen
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          );
        },
        icon: Icon(
          Icons.settings,
          color: Color(kBlueColor),
          size: 0.09 * MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
