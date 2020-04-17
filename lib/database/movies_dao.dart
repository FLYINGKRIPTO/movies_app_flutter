import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:movies_app_flutter/database/dao.dart';
import 'package:movies_app_flutter/database/database.dart';
import 'package:uuid/uuid.dart';

import 'database.dart';
import 'definitions.dart';

part 'movies_dao.g.dart';

@UseDao(tables: [
  Movies,
  Genres,
  Artists,
])
class SqlMoviesDao extends DatabaseAccessor<MoviesDB>
    with _$SqlMoviesDaoMixin, MoviesDao {
  MoviesDB db;

  SqlMoviesDao(this.db) : super(db);

  @override
  Future add(
      {String id,
      String name,
      int year,
      String description,
      double rating}) async {
    final id = Uuid().v4();
    final creationTime = DateTime.now();
    final movieData = Movie(
      id: id,
      name: name,
      year: year,
      description: description,
      rating: rating,
      createdAt: creationTime,
    );
    return transaction(() async {
      final doesSimilarMovieExists  = await (select(movies)..where((m) => m.name.equals(name))..limit(1)).get().then((items) => items.length == 1);
      if(doesSimilarMovieExists) return;
      await into(movies).insert(movieData);
    });
  }

  @override
  Future remove(String id) {
    return transaction(() async {
      await (delete(movies)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  @override
  Stream<List<Movie>> allMovies() => (select(movies)
        ..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
        ]))
      .watch();
}
