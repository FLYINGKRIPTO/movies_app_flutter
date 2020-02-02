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

/// whenever a genre is added to a movie it is not directly added to the movie
/// database , it is added in a separate table which contains movie id and
/// corresponding genre id
class MovieGenresEntry extends Table {
  TextColumn get movieId => text()();
  TextColumn get genreId => text()();
}

class MovieWithGenres {
  final Movie movie;
  final List<Genre> genres;

  const MovieWithGenres(this.movie, this.genres);
}
