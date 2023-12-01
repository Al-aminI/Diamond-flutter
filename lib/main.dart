import 'package:diamond/modules/diamond_provider.dart';
import 'package:diamond/modules/user_data_provider.dart';

import 'package:flutter/material.dart';
import 'package:diamond/auth/login_or_register.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // Remove or update the test device IDs for production
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: ['DB21FB2E116282C610E58F98BF96340A']);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => DiamondDataProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final WebSocketService webSocketService = WebSocketService();
    return const MaterialApp(
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(
        showLoginPage: true,
        // PushNotificationScreen(webSocketService: webSocketService
      ),
    );
  }
}
/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(
      RequestConfiguration(
          testDeviceIds: ['7B3EEABB8EE11C2BE770B684D95219ECB']),
    );
  runApp(
    const CupertinoApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final WebSocketService webSocketService = WebSocketService();
    return const MaterialApp(
      locale: Locale('en'),
      // Remove the builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(
        showLoginPage: true,
        // PushNotificationScreen(webSocketService: webSocketService),
      ),
    );
  }
}
*/