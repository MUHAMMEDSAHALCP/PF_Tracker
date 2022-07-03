import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/components/reset_popup.dart';
import 'package:money_management/components/snackbar.dart';
import 'package:money_management/screens/home/home_screen.dart';
import 'package:money_management/screens/settings/components/settings_reusable_container.dart';
import 'package:money_management/screens/settings/notification/notification.dart';
import 'package:money_management/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    NotificationApi().init(initscheduled: true);
  }

  void listenNotification() {
    NotificationApi.onNotification.listen(onClickNotification);
  }

  onClickNotification(String? playload) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Settings",
            subtitle: "Configure your settings",
            icon: FaIcon(
              FontAwesomeIcons.a,
              color: kPrimaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        ReusableSettingContainer(
                            title: "Reminder",
                            onClick: () {
                              timePicking(context: context);
                            },
                            icon: Icons.access_alarms_sharp),
                        ReusableSettingContainer(
                          title: "Feedback",
                          onClick: () {
                            _launcher();
                          },
                          icon: Icons.feedback_sharp,
                        ),
                        ReusableSettingContainer(
                            title: "About us",
                            onClick: () {
                              openWeb();
                            },
                            icon: Icons.info_outline_rounded),
                        ReusableSettingContainer(
                            title: "Reset everything",
                            onClick: () async {
                              await showResetPopUp(context);
                            },
                            icon: Icons.cleaning_services),
                        ReusableSettingContainer(
                          title: "Share app",
                          onClick: () async {
                            shareApp();
                          },
                          icon: Icons.share_sharp,
                        ),
                        ReusableSettingContainer(
                            title: "Version 1.0.0",
                            onClick: () {},
                            icon: Icons.check_circle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  openWeb() async {
    // ignore: deprecated_member_use
    if (await launch("https://muhammedsahalcp.github.io/Personal-website/")) {
      throw 'could not launch';
    }
  }

  Future<void> _launcher() async {
    // ignore: deprecated_member_use
    if (await launch("mailto:muhammedsahalshah@gmail.com")) {
      throw ("try again");
    }
  }

  shareApp() {
    final box = context.findRenderObject() as RenderBox?;

    Share.share(
      'PF Tracker(Personal finance tracker) Easiest way to Track Your Finance!!! install Now -> \n https://play.google.com/store/apps/details?id=com.pf_tracker',
      subject: "Share App",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  timePicking({required context}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
      setState(() {
        NotificationApi.showScheduledNotification(
            title: "Hey friend 🙋🏻‍♂️",
            body: "Don't forget to add your transactions 💰 ",
            scheduledTime: Time(pickedTime.hour, pickedTime.minute, 0));
      });
    }
    if (pickedTime != null) {
      showScnakBar(context, "Reminder set successfully!!!");
    }
  }
}
