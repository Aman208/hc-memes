import 'package:flutter/material.dart';
import 'package:hc_meme_generator/screens/editing-screen.dart';
import 'package:hc_meme_generator/screens/template-select.dart';
import 'package:hc_meme_generator/widgets/my_memes.dart';
//import 'package:hc_meme_generator/screens/template-select.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodApp',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextStyle(
              fontSize: 17,
              fontFamily: 'Raleway',
            )),
      ),
      home: TemplateSelect() ,
      initialRoute: '/',
      routes: {
        '/edit': (ctx) => EditingScreen(),
        '/my-meme': (ctx) => MyMemes(),
        // '/photo-view': (ctx) => Text(),
      },
    );
  }
}
