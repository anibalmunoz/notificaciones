import 'package:flutter/material.dart';
import 'package:notificaciones/pages/pages.dart';
import 'package:notificaciones/services/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationService.mesageStream.listen((message) {
      print("MYAPP: $message");
      final snackBar = SnackBar(content: Text(message));
      scaffoldKey.currentState?.showSnackBar(snackBar);
      navigatorKey.currentState?.pushNamed(MessagePage.routeName, arguments: message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      scaffoldMessengerKey: scaffoldKey, //snackbars
      navigatorKey: navigatorKey, //navegar
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        MessagePage.routeName: (context) => const MessagePage()
      },
    );
  }
}
