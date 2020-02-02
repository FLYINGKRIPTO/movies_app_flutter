import 'package:flutter/material.dart';
import 'package:movies_app_flutter/database/dao.dart';
import 'package:movies_app_flutter/database/database.dart';
import 'package:movies_app_flutter/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MoviesDao>(
          create: (_) => MoviesDB().sqlMoviesDao,
        )
      ],
      child: MaterialApp(
        title: 'Movies App',
        home: HomePage(),
      ),
    );
  }
}
