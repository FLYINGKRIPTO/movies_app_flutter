import 'package:movies_app_flutter/database/database.dart';

abstract class MoviesDao {
  Future add(
      String id, String name, int year, String description, double rating);

  Future remove(String id);

  Stream<List<Movie>> allMovies();
}

abstract class GenresDao {
  Future add(String id, String name);

  Future remove(String id);

  Stream<List<Genre>> allGenres();
}

abstract class Actors {
  Future add(String id, String name, bool gender, int age);

  Future remove(String id);
}
