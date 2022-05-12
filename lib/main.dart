import 'package:bloc_pattern_sin_librerias/screens/cart.dart';
import 'package:bloc_pattern_sin_librerias/screens/catalog.dart';
import 'package:bloc_pattern_sin_librerias/screens/user.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const CatalogScreen(),
        '/user': (context) => const UserScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
