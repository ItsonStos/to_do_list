import 'package:flutter/material.dart';
import 'package:to_do_list/screen/home_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarefas',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 1, 31, 84),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 1, 31, 84),
          foregroundColor: Colors.white,          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0))),
              elevation: 10,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    ));
