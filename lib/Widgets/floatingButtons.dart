import 'package:aquaman/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:aquaman/screens/bottomSheet/increaseAmountBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:aquaman/models/generalData.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(
        right: 0.15 * MediaQuery.of(context).size.width,
        bottom: 0.07 * MediaQuery.of(context).size.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: kWidthFloatingButtonRevert(context),
            height: kHeightFloatingButtonRevert(context),
            child: FloatingActionButton(
              //add herotag: https://stackoverflow.com/questions/51125024/there-are-multiple-heroes-that-share-the-same-tag-within-a-subtree
              heroTag: "btnDecrease",
              onPressed: () {
                Provider.of<GeneralData>(context, listen: false).revertAmount();
                // Provider.of<WaterAmountData>(context, listen: false)
                //     .calculateIntakePercent();
              },
              backgroundColor: Colors.white,
              elevation: 2.0,
              child: Icon(
                Icons.undo,
                color: Color(kGreyColor),
                size: kSizeIconFloatingButtonRevert(context),
              ),
            ),
          ),
          SizedBox(
            height: 0.03 * MediaQuery.of(context).size.height,
          ),
          SizedBox(
            width: kWidthFloatingButtonAdd(context),
            height: kHeightFloatingButtonAdd(context),
            child: FloatingActionButton(
              //add herotag: https://stackoverflow.com/questions/51125024/there-are-multiple-heroes-that-share-the-same-tag-within-a-subtree
              heroTag: "btnIncrease",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => IncreaseAmountScreen(),
                );
              },
              backgroundColor: Color(kBlueColor),
              elevation: 2.0,
              child: Icon(
                Icons.add,
                color: Color(0xffffffff),
                size: kSizeIconFloatingButtonAdd(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
