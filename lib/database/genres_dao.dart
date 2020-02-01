import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:movies_app_flutter/database/dao.dart';
import 'package:uuid/uuid.dart';

import 'database.dart';
import 'definitions.dart';

part 'genres_dao.g.dart';

@UseDao(tables: [Movies, Genres])
class SqlGenresDao extends DatabaseAccessor<MoviesDB>
    with _$SqlGenresDaoMixin, GenresDao {
  MoviesDB db;

  SqlGenresDao(this.db) : super(db);
  @override
  Future add(String id, String name) {
    final id = Uuid().v4();
    final creationTime = DateTime.now();
    final genreData = Genre(
      createdAt: creationTime,
      id: id,
      name: name,
    );
    return transaction(() async {
      await into(genres).insert(genreData);
    });
  }

  @override
  Future remove(String id) {
    return transaction(() async {
      await (delete(genres)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  @override
  Stream<List<Genre>> allGenres() {
    return (select(genres)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }
}
