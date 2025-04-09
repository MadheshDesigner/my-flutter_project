import '../../../data/di_helper.dart';
import '../../../view/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers:DiHelper.providerList,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:BottomBarScreen() ,
      ),
    );
  }
}

