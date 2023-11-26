import 'package:diamond/modules/diamond_provider.dart';
import 'package:diamond/modules/user_data_provider.dart';
//import 'package:diamond/pages/push_notif.dart';
import 'package:flutter/material.dart';
//import 'package:diamond/auth/login_or_register.dart';
import 'package:diamond/auth/login_or_register.dart';
//import 'package:diamond/pages/HomePage.dart';
//import 'package:diamond/pages/event.dart';
//import 'package:diamond/pages/register_page.dart';
//import 'pages/login_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
//import 'package:diamond/pages/HomePage.dart';
//import 'package:diamond/pages/websocket_service.dart';
/*
void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();

  // Remove or update the test device IDs for production
  //RequestConfiguration requestConfiguration = RequestConfiguration();
  //MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => UserDataProvider()),
        ChangeNotifierProvider(create: (context) => DiamondDataProvider()),
      ], child: const MyApp()),
    ), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final WebSocketService webSocketService = WebSocketService();
    return const MaterialApp(
        locale: Locale('en'),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: LoginOrRegister(
          showLoginPage: true,
          // PushNotificationScreen(webSocketService: webSocketService
        ));
  }
}*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  var device = ["D6E8737466CE3D03F181D89A209DC9EF"];

  // Remove or update the test device IDs for production
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: device);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  // Print the test device ID to the console

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
      // Remove the builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(
        showLoginPage: true,
        // PushNotificationScreen(webSocketService: webSocketService),
      ),
    );
  }
}
