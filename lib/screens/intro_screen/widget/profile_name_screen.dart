import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:money_management/screens/home/home_screen.dart';
import 'package:money_management/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileName extends StatefulWidget {
  const ProfileName({Key? key}) : super(key: key);

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

final _nameController = TextEditingController();

class _ProfileNameState extends State<ProfileName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          kSizedBox,
          kSizedBox,
          const Text(
            "PF Tracker",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "CrimsonText",
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          kSizedBox,
          const Image(
            image: AssetImage("assets/profile_page.png"),
          ),
          const Text(
            "What should we call you?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Cinzel",
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          kSizedBox,
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Enter your nick name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kSecondoryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  checkLogin(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 5,
                    vertical: 12,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        fontFamily: 'CrimsonText',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkLogin(BuildContext context) {
    final _userName = _nameController.text;

    if (_userName.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kSecondoryColor,
          content: AutoSizeText(
            'Please enter your name!!!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      goToHome(context);
    }
  }
}

void goToHome(BuildContext context) async {
  final userName = _nameController.text;
  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("keyValue", userName);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const HomeScreen()));
}

const kSizedBox = SizedBox(
  height: 30,
);
