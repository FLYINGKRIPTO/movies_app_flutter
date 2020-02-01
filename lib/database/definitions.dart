import 'package:moor/moor.dart';
import 'package:movies_app_flutter/database/database.dart';

class Movies extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get year => integer()();
  TextColumn get description => text()();
  RealColumn get rating => real()();
  DateTimeColumn get createdAt => dateTime()();
}

class Genres extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
}

class Artists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get gender => boolean()();
  IntColumn get age => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

class MovieWithGenres {
  final Movie movie;
  final List<Genre> genres;

  const MovieWithGenres(this.movie, this.genres);
}
