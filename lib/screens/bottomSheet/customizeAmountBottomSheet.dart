import 'package:flutter/material.dart';
import 'package:aquaman/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';

class CustomizeAmount extends StatefulWidget {
  @override
  _CustomizeAmountState createState() => _CustomizeAmountState();
}

class _CustomizeAmountState extends State<CustomizeAmount> {
  bool showError = false;

  TextEditingController controllerCustomized = TextEditingController();
  String customizedAmount;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(
          top: 0.005 * MediaQuery.of(context).size.height,
          left: 0.055 * MediaQuery.of(context).size.width),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (() {
              if (Provider.of<GeneralData>(context, listen: false)
                      .getSelectedLanguage ==
                  'English') {
                return 'Customize Water Intake';
              } else if (Provider.of<GeneralData>(context, listen: false)
                      .getSelectedLanguage ==
                  'Deutsch') {
                return 'Menge Anpassen';
              } else if (Provider.of<GeneralData>(context, listen: false)
                      .getSelectedLanguage ==
                  '繁體中文') {
                return '自訂攝取量';
              } else if (Provider.of<GeneralData>(context, listen: false)
                      .getSelectedLanguage ==
                  '简体中文') {
                return '自定义摄取量';
              }
            }()),
            style: kBodyTitle(context),
          ),
          IconButton(
              icon: Icon(
                Icons.close,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      content: Container(
        alignment: Alignment.center,
        height: 0.2 * MediaQuery.of(context).size.height,
        width: 1 * MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 0.01 * MediaQuery.of(context).size.height,
          horizontal: 0.03 * MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          color: Color(kWaveDeepBlueColor).withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/ic_customizedml.png'),
              width: kWidthIncreaseAmountTile(context),
              height: kHeightIncreaseAmountTile(context),
            ),
            SizedBox(
              width: 0.05 * MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 0.07 * MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.15 * MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: controllerCustomized,
                          style: TextStyle(
                              color: Color(kDeepGreyColor),
                              fontSize:
                                  0.05 * MediaQuery.of(context).size.width,
                              fontWeight: FontWeight.w300),
                          cursorColor: showError ? Colors.red : Colors.black54,
                          cursorWidth:
                              0.001 * MediaQuery.of(context).size.width,
                          cursorHeight:
                              0.02 * MediaQuery.of(context).size.height,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(0.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: showError ? Colors.red : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ml',
                          style: TextStyle(
                            fontSize: 0.04 * MediaQuery.of(context).size.width,
                            fontWeight: FontWeight.w300,
                            color: showError ? Colors.red : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.01 * MediaQuery.of(context).size.height,
                    width: 0.25 * MediaQuery.of(context).size.width,
                  ),
                  Visibility(
                    visible: showError,
                    child: Container(
                      width: 0.25 * MediaQuery.of(context).size.width,
                      child: Text(
                        '0~1000ml only',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              (() {
                if (Provider.of<GeneralData>(context, listen: false)
                        .getSelectedLanguage ==
                    'English') {
                  return 'Confirm';
                } else if (Provider.of<GeneralData>(context, listen: false)
                        .getSelectedLanguage ==
                    'Deutsch') {
                  return 'Bestätigen';
                } else if (Provider.of<GeneralData>(context, listen: false)
                        .getSelectedLanguage ==
                    '繁體中文') {
                  return '確認';
                } else if (Provider.of<GeneralData>(context, listen: false)
                        .getSelectedLanguage ==
                    '简体中文') {
                  return '确认';
                }
              }()),
            ),
            onPressed: () async {
              // Future<SharedPreferences> _prefs =
              //     SharedPreferences.getInstance();
              // final SharedPreferences prefs = await _prefs;

              if (int.parse('${controllerCustomized.text}') < 0 ||
                  int.parse('${controllerCustomized.text}') > 1000) {
                setState(() {
                  controllerCustomized.clear();
                  showError = true;
                });
              } else {
                setState(() {
                  showError = false;
                  customizedAmount = controllerCustomized.text;
                  Provider.of<GeneralData>(context, listen: false)
                      .storeCustomizedAmount(customizedAmount);
                  Navigator.of(context).pop();
                });
              }
            })
      ],
    );
  }
}
