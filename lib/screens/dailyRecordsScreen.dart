import 'package:flutter/material.dart';
import 'package:aquaman/utilities/constants.dart';

import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';
import 'package:aquaman/Widgets/dailyRecordsData.dart';

import 'package:flutter/services.dart';

class DailyRecords extends StatefulWidget {
  @override
  _DailyRecordsState createState() => _DailyRecordsState();
}

class _DailyRecordsState extends State<DailyRecords> {
  bool isSwitchedLatest7Days = false;
  bool isSwitchedLatest30Days = false;
  bool isSwitchedLatest60Days = false;
  bool isSwitchedLatest90Days = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Color(kDailyRecordsBackgroundColor),
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: false,
        title: Text(
          (() {
            if (Provider.of<GeneralData>(context, listen: false)
                    .getSelectedLanguage ==
                'English') {
              return 'My Records';
            } else if (Provider.of<GeneralData>(context, listen: false)
                    .getSelectedLanguage ==
                'Deutsch') {
              return 'Mein Daten';
            } else if (Provider.of<GeneralData>(context, listen: false)
                    .getSelectedLanguage ==
                '繁體中文') {
              return '我的紀錄';
            } else if (Provider.of<GeneralData>(context, listen: false)
                    .getSelectedLanguage ==
                '简体中文') {
              return '我的纪录';
            }
          }()),
          style: kScreenTitle(context),
        ),
        elevation: 0.0,
        backgroundColor: Color(kDailyRecordsBackgroundColor),
        iconTheme: IconThemeData(color: Color(kDeepGreyColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.02 * MediaQuery.of(context).size.height,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
                horizontal: 0.08 * MediaQuery.of(context).size.width,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.015 * MediaQuery.of(context).size.height,
                horizontal: 0.065 * MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(1.0, 1.0))
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSwitchedLatest7Days = !isSwitchedLatest7Days;
                      });
                    },
                    child: Container(
                      height: 0.05 * MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (() {
                              if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'English') {
                                return 'Latest 7 days';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'Deutsch') {
                                return 'Vor 7 Tagen';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '繁體中文') {
                                return '最近七天';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '简体中文') {
                                return '最近七天';
                              }
                            }()),
                            style: kBodyTitle(context),
                          ),
                          isSwitchedLatest7Days
                              ? Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSwitchedLatest7Days,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 0.045 * MediaQuery.of(context).size.height,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (() {
                              if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'English') {
                                return 'Target reached: ${Provider.of<GeneralData>(context).getReachedTargetIn7Days} day(s)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'Deutsch') {
                                return 'Ziel erreicht: ${Provider.of<GeneralData>(context).getReachedTargetIn7Days} Tag(e)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '繁體中文') {
                                return '目標達成：${Provider.of<GeneralData>(context).getReachedTargetIn7Days} 天';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '简体中文') {
                                return '目标达成：${Provider.of<GeneralData>(context).getReachedTargetIn7Days} 天';
                              }
                            }()),
                            style: kBodyText(context),
                          ),
                        ),
                        SizedBox(
                          height: 0.02 * MediaQuery.of(context).size.height,
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              width: 0.63 * MediaQuery.of(context).size.width,
                              child: Last7Days(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height:
                                      0.08 * MediaQuery.of(context).size.height,
                                  width:
                                      0.63 * MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      top: BorderSide(color: Colors.black26),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      0.09 * MediaQuery.of(context).size.height,
                                  child: Text(
                                    '100%',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 0.03 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Today';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Heute';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '今天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '今天';
                                }
                              }()),
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize:
                                    0.03 * MediaQuery.of(context).size.width,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
                horizontal: 0.08 * MediaQuery.of(context).size.width,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.015 * MediaQuery.of(context).size.height,
                horizontal: 0.065 * MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(1.0, 1.0))
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSwitchedLatest30Days = !isSwitchedLatest30Days;
                      });
                    },
                    child: Container(
                      height: 0.05 * MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Latest 30 days';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Vor 30 Tagen';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '最近三十天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '最近三十天';
                                }
                              }()),
                              style: kBodyTitle(context)),
                          isSwitchedLatest30Days
                              ? Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSwitchedLatest30Days,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 0.045 * MediaQuery.of(context).size.height,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (() {
                              if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'English') {
                                return 'Target reached: ${Provider.of<GeneralData>(context).getReachedTargetIn30Days} day(s)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'Deutsch') {
                                return 'Ziel erreicht: ${Provider.of<GeneralData>(context).getReachedTargetIn30Days} ';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '繁體中文') {
                                return '目標達成：${Provider.of<GeneralData>(context).getReachedTargetIn30Days} 天';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '简体中文') {
                                return '目标达成：${Provider.of<GeneralData>(context).getReachedTargetIn30Days} 天';
                              }
                            }()),
                            style: kBodyText(context),
                          ),
                        ),
                        SizedBox(
                          height: 0.02 * MediaQuery.of(context).size.height,
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              width: 0.63 * MediaQuery.of(context).size.width,
                              child: Last30Days(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height:
                                      0.08 * MediaQuery.of(context).size.height,
                                  width:
                                      0.63 * MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      top: BorderSide(color: Colors.black26),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      0.09 * MediaQuery.of(context).size.height,
                                  child: Text(
                                    '100%',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 0.03 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Today';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Heute';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '今天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '今天';
                                }
                              }()),
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize:
                                    0.03 * MediaQuery.of(context).size.width,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
                horizontal: 0.08 * MediaQuery.of(context).size.width,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.015 * MediaQuery.of(context).size.height,
                horizontal: 0.065 * MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(1.0, 1.0))
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSwitchedLatest60Days = !isSwitchedLatest60Days;
                      });
                    },
                    child: Container(
                      height: 0.05 * MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Latest 60 days';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Vor 60 Tagen';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '最近六十天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '最近六十天';
                                }
                              }()),
                              style: kBodyTitle(context)),
                          isSwitchedLatest60Days
                              ? Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSwitchedLatest60Days,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 0.045 * MediaQuery.of(context).size.height,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (() {
                              if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'English') {
                                return 'Target reached: ${Provider.of<GeneralData>(context).getReachedTargetIn60Days} day(s)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'Deutsch') {
                                return 'Ziel erreicht: ${Provider.of<GeneralData>(context).getReachedTargetIn60Days} Tag(e)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '繁體中文') {
                                return '目標達成：${Provider.of<GeneralData>(context).getReachedTargetIn60Days} 天';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '简体中文') {
                                return '目标达成：${Provider.of<GeneralData>(context).getReachedTargetIn60Days} 天';
                              }
                            }()),
                            style: kBodyText(context),
                          ),
                        ),
                        SizedBox(
                          height: 0.02 * MediaQuery.of(context).size.height,
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              width: 0.63 * MediaQuery.of(context).size.width,
                              child: Last60Days(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height:
                                      0.08 * MediaQuery.of(context).size.height,
                                  width:
                                      0.63 * MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      top: BorderSide(color: Colors.black26),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      0.09 * MediaQuery.of(context).size.height,
                                  child: Text(
                                    '100%',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 0.03 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Today';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Heute';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '今天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '今天';
                                }
                              }()),
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize:
                                    0.03 * MediaQuery.of(context).size.width,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 0.02 * MediaQuery.of(context).size.height,
                horizontal: 0.08 * MediaQuery.of(context).size.width,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0.015 * MediaQuery.of(context).size.height,
                horizontal: 0.065 * MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: Offset(1.0, 1.0))
                  ]),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSwitchedLatest90Days = !isSwitchedLatest90Days;
                      });
                    },
                    child: Container(
                      height: 0.05 * MediaQuery.of(context).size.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Latest 90 days';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Vor 90 Tagen';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '最近九十天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '最近九十天';
                                }
                              }()),
                              style: kBodyTitle(context)),
                          isSwitchedLatest90Days
                              ? Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20.0,
                                  color: Color(kGreyColor),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSwitchedLatest90Days,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 0.045 * MediaQuery.of(context).size.height,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (() {
                              if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'English') {
                                return 'Target reached: ${Provider.of<GeneralData>(context).getReachedTargetIn90Days} day(s)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  'Deutsch') {
                                return 'Ziel erreicht: ${Provider.of<GeneralData>(context).getReachedTargetIn90Days} Tag(e)';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '繁體中文') {
                                return '目標達成：${Provider.of<GeneralData>(context).getReachedTargetIn90Days} 天';
                              } else if (Provider.of<GeneralData>(context,
                                          listen: false)
                                      .getSelectedLanguage ==
                                  '简体中文') {
                                return '目标达成：${Provider.of<GeneralData>(context).getReachedTargetIn90Days} 天';
                              }
                            }()),
                            style: kBodyText(context),
                          ),
                        ),
                        SizedBox(
                          height: 0.02 * MediaQuery.of(context).size.height,
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              width: 0.63 * MediaQuery.of(context).size.width,
                              child: Last90Days(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height:
                                      0.08 * MediaQuery.of(context).size.height,
                                  width:
                                      0.63 * MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border(
                                      top: BorderSide(color: Colors.black26),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      0.09 * MediaQuery.of(context).size.height,
                                  child: Text(
                                    '100%',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 0.03 *
                                          MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              (() {
                                if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'English') {
                                  return 'Today';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    'Deutsch') {
                                  return 'Heute';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '繁體中文') {
                                  return '今天';
                                } else if (Provider.of<GeneralData>(context,
                                            listen: false)
                                        .getSelectedLanguage ==
                                    '简体中文') {
                                  return '今天';
                                }
                              }()),
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize:
                                    0.03 * MediaQuery.of(context).size.width,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
