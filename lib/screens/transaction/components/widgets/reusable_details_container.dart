import 'package:flutter/material.dart';
import 'package:money_management/utils/constants.dart';

class ReusableDeatailsContainer extends StatelessWidget {
  final String textKey;
  final String textValue;
  const ReusableDeatailsContainer(
      {Key? key, required this.textKey, required this.textValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: MediaQuery.of(context).size.height / 9,
        padding: kTextFieldPadding,
        decoration: kTextFieldBoxDecoration,
        child: Row(
          children: [
            Text(textKey, style: kIntroTextStyle),
            kSizedBoxWidth,
            kSizedBoxWidth,
            Flexible(
              child: Text(
                textValue,
                textAlign: TextAlign.center,
                style: kCardTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
