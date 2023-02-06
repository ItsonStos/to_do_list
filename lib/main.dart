import 'package:flutter/material.dart';
import 'package:to_do_list/screen/home_screen.dart';

void main() =>
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Tarefas',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
    home: const HomeScreen()
  ));

