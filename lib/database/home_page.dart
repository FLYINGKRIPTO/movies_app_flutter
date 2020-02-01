import 'package:flutter/material.dart';
import 'package:movies_app_flutter/database/dao.dart';
import 'package:provider/provider.dart';

import 'database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies App")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_buildMoviesList(context)],
      ),
    );
  }

  StreamBuilder<List<Movie>> _buildMoviesList(BuildContext context) {
    final movieDatabase = Provider.of<MoviesDao>(context);
    return StreamBuilder(
      stream: movieDatabase.allMovies(),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final itemMovie = movies[index];
              return _buildListItem(itemMovie, movieDatabase);
            });
      },
    );
  }

  Widget _buildListItem(Movie itemMovie, MoviesDao movieDatabase) {
    return Expanded(
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(itemMovie.name),
                Text(itemMovie.createdAt.toIso8601String()),
                Text(itemMovie.rating.toString()),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(itemMovie.description),
                Text(itemMovie.id),
              ],
            )
          ],
        ),
      ),
    );
  }
}
