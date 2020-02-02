import 'package:flutter/material.dart';
import 'package:movies_app_flutter/add_movie.dart';
import 'package:movies_app_flutter/database/dao.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies App")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_buildMoviesList(context)],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMovie()));
        },
        label: Text("Add Movie and Genre"),
        icon: Icon(Icons.airplay),
      ),
    );
  }

  StreamBuilder<List<Movie>> _buildMoviesList(BuildContext context) {
    final movieDatabase = Provider.of<MoviesDao>(context);
    return StreamBuilder(
      stream: movieDatabase?.allMovies(),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        final movies = snapshot.data ?? [];
        return Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: movies.length ?? 0,
              itemBuilder: (context, index) {
                final itemMovie = movies[index];
                return _buildListItem(itemMovie, movieDatabase);
              }),
        );
      },
    );
  }

  Widget _buildListItem(Movie itemMovie, MoviesDao movieDatabase) {
    return SizedBox(
      height: 100,
      width: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(itemMovie.name),
            Text(itemMovie.createdAt.toIso8601String()),
            Text(itemMovie.rating.toString()),
            Text(itemMovie.description),
            Text(itemMovie.id),
          ],
        ),
      ),
    );
  }
}
