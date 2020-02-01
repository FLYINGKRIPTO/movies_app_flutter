import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:movies_app_flutter/database/movies_dao.dart';

import 'definitions.dart';

part 'database.g.dart';

@UseMoor(tables: [
  Movies,
  Artists,
  Genres,
], daos: [
  SqlMoviesDao,
])
class MoviesDB extends _$MoviesDB {
  MoviesDB() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;
}
