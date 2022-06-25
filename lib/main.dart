import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/home/home_screen.dart';
import 'package:money_management/screens/intro_screen/splash_screen.dart';
import 'package:money_management/screens/transaction/components/see_more_screen.dart';
import 'package:money_management/screens/transaction/components/add_transaction_screen.dart';
import 'package:money_management/utils/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:timezone/data/latest.dart ' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kSecondoryColor,
    systemNavigationBarColor: kSecondoryColor,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MoneyManagement());
}

class MoneyManagement extends StatelessWidget {
  const MoneyManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        AddTransactionScreen.routeName: (context) =>
            const AddTransactionScreen(),
        AllCategoryScreen.routeName: (context) => const AllCategoryScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
