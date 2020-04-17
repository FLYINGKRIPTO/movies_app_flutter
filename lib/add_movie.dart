import 'package:flutter/material.dart';
import 'package:movies_app_flutter/database/dao.dart';
import 'package:provider/provider.dart';

class AddMovie extends StatefulWidget {
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  String movieName, description, year, genre;
  double rating;
  TextEditingController movieTextFieldController = TextEditingController();
  TextEditingController descriptionFieldController = TextEditingController();
  TextEditingController yearFieldController = TextEditingController();
  TextEditingController ratingFieldController = TextEditingController();
  TextEditingController genreFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final moviesDao = Provider.of<MoviesDao>(context);
    final genreDao = Provider.of<GenresDao>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add  Movie and Genre "),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Add a movie"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Movie Name"),
                  controller: movieTextFieldController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Description"),
                  controller: descriptionFieldController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Year"),
                  controller: yearFieldController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Rating from 1 to 10"),
                  controller: ratingFieldController,
                ),
              ),
              Center(
                child: RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                  onPressed: () {
                    movieName = movieTextFieldController.text;
                    description = descriptionFieldController.text;
                    year = yearFieldController.text;
                    rating = double.parse(ratingFieldController.text);
                    moviesDao.add(
                        name: movieName,
                        description: description,
                        rating: rating,
                        year: int.parse(year));
                  },
                  child: Text("Save Movie"),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Genre"),
                      controller: genreFieldController,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RaisedButton(
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    onPressed: () {
                      genre = genreFieldController.text;
                      genreDao.add(name: genre);
                      genreFieldController.clear();
                    },
                    child: Text("Save Genre"),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  Future.delayed(Duration(seconds: 2), () {
                    genreDao.allGenres().listen((event) {
                      event.forEach((element) {
                        debugPrint(element.name);
                      });
                    });
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
