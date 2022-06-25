import 'package:flutter/material.dart';

// colors
const kPrimaryColor = Color(0xff7F9D9D);
const kSecondoryColor = Color(0xff516365);
const kWhite = Color(0xffffffff);
const kblack = Colors.black;
const kCardColor = Color(0xffBDD7D6);
const kListColor = Color(0xffEFF2DD);
const kGreenColor = Color(0xff008640);
const kRedColor = Colors.red;

//styles
const kSizedBoxHeight = SizedBox(
  height: 10,
);
const kSizedBoxHeight6 = SizedBox(
  height: 6,
);
const kTextFieldTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    fontFamily: "CrimsonText");
const kTextFieldPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
final kTextFieldBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: kListColor,
);
const kSizedBoxWidth = SizedBox(
  width: 12,
);
const kIntroTextStyle = TextStyle(
  fontFamily: 'CrimsonText',
  fontSize: 20,
);
const kCardTextStyle =
    TextStyle(fontFamily: 'Cinzel', fontSize: 16, fontWeight: FontWeight.bold);
const kBold = TextStyle(fontWeight: FontWeight.w800);

const kCardAmountStyleGreen = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: kGreenColor,
  fontFamily: 'FiraSansCondensed',
);
const kCardAmountStyleRed = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15,
  color: kRedColor,
  fontFamily: 'FiraSansCondensed',
);
