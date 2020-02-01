import 'package:flutter/material.dart';
import 'package:movies_app_flutter/database/database.dart';
import 'package:movies_app_flutter/database/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Provider.of<MoviesDB>(context),
      child: MaterialApp(
        title: 'Movies App',
        home: HomePage(),
      ),
    );
  }
}
