import 'package:flutter/material.dart';
import 'package:money_management/components/elevatedbutton.dart';
import 'package:money_management/components/navigatior_push.dart';
import 'package:money_management/screens/intro_screen/Widget/build_page_widget.dart';
import 'package:money_management/screens/intro_screen/widget/profile_name_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  int page = 0;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height / 2;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    page = index;
                  });
                },
                controller: controller,
                children: [
                  buildPage(
                    height: _height,
                    image: "assets/intro_one.png",
                    title: "Personal finance Tracker",
                    subtiltle:
                        "The easiest way to manage Your personal finance",
                  ),
                  buildPage(
                    height: _height,
                    image: "assets/intro_two.png",
                    title: "Track your spending",
                    subtiltle: "Keep track of your expenses manually",
                  ),
                  buildPage(
                    height: _height,
                    image: "assets/intro_three.png",
                    title: "All your finance in one place",
                    subtiltle: "See all your finance dealing in one place",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (page == 0)
                      ? ReusableElevatedButton(
                          onClick: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 1),
                                curve: Curves.easeInOut);
                          },
                          buttonName: "Next")
                      : (page == 1)
                          ? ReusableElevatedButton(
                              onClick: () {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 1),
                                    curve: Curves.easeInOut);
                              },
                              buttonName: "Next")
                          : ReusableElevatedButton(
                              onClick: () {
                                nextPage(
                                    context: context,
                                    screen: const ProfileName());
                              },
                              buttonName: "Start"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
