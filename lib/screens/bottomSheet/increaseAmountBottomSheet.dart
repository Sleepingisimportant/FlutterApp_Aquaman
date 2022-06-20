import 'package:aquaman/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';
import 'package:aquaman/screens/bottomSheet/customizeAmountBottomSheet.dart';

import 'dart:ui';

class IncreaseAmountScreen extends StatefulWidget {
  @override
  _IncreaseAmountScreenState createState() => _IncreaseAmountScreenState();
}

class _IncreaseAmountScreenState extends State<IncreaseAmountScreen> {
  TextEditingController controllerCustomized = TextEditingController();
  String customizedAmount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCustomizedAmount();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFF737373),
        child: Container(
          padding: EdgeInsets.only(
            top: 0.04 * MediaQuery.of(context).size.height,
            left: 0.08 * MediaQuery.of(context).size.width,
            right: 0.08 * MediaQuery.of(context).size.width,
            bottom: 0.06 * MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncreaseAmountTile(
                    ml: '50',
                    mlImage: '50',
                    imageWidth: 0.10 * MediaQuery.of(context).size.width,
                  ),
                  IncreaseAmountTile(
                    ml: '100',
                    mlImage: '100',
                    imageWidth: 0.15 * MediaQuery.of(context).size.width,
                  ),
                  IncreaseAmountTile(
                    ml: '200',
                    mlImage: '200',
                    imageWidth: 0.11 * MediaQuery.of(context).size.width,
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncreaseAmountTile(
                    ml: '300',
                    mlImage: '300',
                    imageWidth: 0.07 * MediaQuery.of(context).size.width,
                  ),
                  IncreaseAmountTile(
                    ml: '500',
                    mlImage: '500',
                    imageWidth: 0.08 * MediaQuery.of(context).size.width,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<GeneralData>(context, listen: false)
                          .updateAmount(
                        int.parse(
                            Provider.of<GeneralData>(context, listen: false)
                                .getStoredCustomizedAmount),
                      );

                      Provider.of<GeneralData>(context, listen: false)
                          .storeUpdateTime();

                      Navigator.pop(context);
                    },
                    child: Container(
                      width: kWidthIncreaseAmountTile(context),
                      height: kHeightIncreaseAmountTile(context),
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            kPaddingHorizontalIncreaseAmountTile(context),
                        vertical: kPaddingVerticalIncreaseAmountTile(context),
                      ),
                      decoration: BoxDecoration(
                        color: Color(kWaveDeepBlueColor).withOpacity(0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                AssetImage('assets/images/ic_customizedml.png'),
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            width: 0.14 * MediaQuery.of(context).size.width,
                            height: kHeightIncreaseAmountTileImage(context),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => new CustomizeAmount());
                            },
                            child: Container(
                              width: kWidthIncreaseAmountTile(context),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(0.0),
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${Provider.of<GeneralData>(context).getStoredCustomizedAmount}ml',
                                      style: TextStyle(
                                        fontSize: kIncreaseAmountTileTextSize(
                                            context),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      constraints: BoxConstraints(
                                          maxHeight: 20.0, maxWidth: 20.0),
                                      iconSize: 15.0,
                                      padding: EdgeInsets.all(0.0),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                new CustomizeAmount());
                                      },
                                      icon: Icon(
                                        Icons.edit_rounded,
                                        // size: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IncreaseAmountTile extends StatelessWidget {
  final String ml;
  final String mlImage;
  final double imageWidth;

  IncreaseAmountTile(
      {@required this.ml, @required this.mlImage, @required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<GeneralData>(context, listen: false)
            .updateAmount(int.parse(ml));
        Provider.of<GeneralData>(context, listen: false).storeUpdateTime();

        Navigator.pop(context);
      },
      child: Container(
        width: kWidthIncreaseAmountTile(context),
        height: kHeightIncreaseAmountTile(context),
        padding: EdgeInsets.symmetric(
          horizontal: kPaddingHorizontalIncreaseAmountTile(context),
          vertical: kPaddingVerticalIncreaseAmountTile(context),
        ),
        decoration: BoxDecoration(
          color: Color(kWaveDeepBlueColor).withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/ic_$mlImage' + 'ml.png'),
              fit: BoxFit.fitWidth,
              width: imageWidth,
              height: kHeightIncreaseAmountTileImage(context),
            ),
            Text(
              '$ml' + 'ml',
              style: TextStyle(
                fontSize: kIncreaseAmountTileTextSize(context),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
