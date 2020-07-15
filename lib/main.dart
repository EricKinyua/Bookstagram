import 'package:Bookstagram/provider/auth_provider.dart';
import 'package:Bookstagram/screens/Authentication/login.dart';
import 'package:Bookstagram/screens/homepage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookstagram',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => AuthProvider.instance(),
        child: Consumer(
          builder: (context, AuthProvider value, child) {
            if (value.status == Status.Authenticated)
              return Homepage();
            else
              return Login();
          },
        ),
      ),
    );
  }
}
