import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_time/See/see_db_worker.dart';
import 'package:free_time/See/see_model.dart';
import 'choose_see.dart';
import '../colors.dart' as color;

class See extends StatefulWidget {
  See({Key key}) : super(key: key);

  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/movie/popular?api_key=100a9276c843992ab8b2d8e83f8bab42&language=en-US&page=1',
      headers: {
        'api_key': DotEnv().env['MOVIEDB_API_KEY'],
      }));

  @override
  _SeeState createState() => _SeeState();
}

class _SeeState extends State<See> {
  List <SeeModel> movies = [];
  List respondedMovies;
  List favorites = [];
  bool isLoading = false;

  void searchSee() async {
    isLoading = true;
    final response = await widget.dio.get('');
    setState(() {
      respondedMovies = response.data['results'];
      respondedMovies.shuffle();
      for (dynamic movie in respondedMovies) {
        movies.add(SeeModel.info(
            movie['title'],
            movie['overview'],
            movie['vote_average'].toString(),
            movie['release_date'],
            "https://image.tmdb.org/t/p/w200" + movie['poster_path']
        ));
      }
      favorites = List(movies.length);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    searchSee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.background,
      body: Column(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 175,
            decoration: BoxDecoration(
              color: color.AppColor.lightBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: 10,
                  color: color.AppColor.detail.withOpacity(0.2),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Let's See",
                          style: TextStyle(
                            fontSize: 40,
                            color: color.AppColor.title,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                      IconButton(
                        icon: Icon(Icons.home,
                          color: color.AppColor.title,),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        splashColor: Colors.blue,
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightBlueAccent,
                                color.AppColor.blue,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5, 10),
                                blurRadius: 10,
                                color: color.AppColor.detail.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: const Center(child: Text("Choose For Me!",
                            style: TextStyle(color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseSee(movies)));
                          print('Pressed Choose For Me');
                        },
                      ),
                    ),
                  ]
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? Padding(
            padding: const EdgeInsets.only(top: 120.0, bottom: 180.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      color.AppColor.lightBlue)
              ),
            ),
          )
              : Expanded(
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: movies == null ? 0 : movies.length,
                    itemBuilder: (_, i) {
                      return Container(
                        height: 220,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                        padding: EdgeInsets.only(top: 5),
                        child: ProductBox(
                            movies[i], i
                        ),
                      );
                    }
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget ProductBox(SeeModel movie, int i) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 110,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(width: 15,),
                  Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5, 10),
                            blurRadius: 10,
                            color: color.AppColor.lightBlue.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(movie.image)
                      )),
                  SizedBox(width: 15,),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(movie.name,
                                        style: TextStyle(fontSize: 17,
                                            fontWeight: FontWeight.bold)
                                    ),
                                  ),
                                  SizedBox(
                                      height: 20,
                                      child: TextButton(child: favorites[i] == null ? Icon(Icons.favorite_border,color: Colors.black, size: 15,)
                                          : Icon(Icons.check,color: color.AppColor.lightBlue, size: 15,),
                                          onPressed: () async {
                                            if (favorites[i] == null) {
                                              favorites[i] = 1;
                                              await SeeModelsDBWorker.db.create(
                                                  movie);
                                              print('Created in DB');
                                            }
                                            setState(() {});
                                          })
                                  ),
                                ],
                              ),
                              Text('\nRating: ' + movie.vote + "/10",
                                  style: TextStyle(fontSize: 11)),
                              Text('\nReleased: ' + movie.releaseDate,
                                  style: TextStyle(fontSize: 11)),
                              Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    child: Text('\n' + movie.description,
                                        style: TextStyle(fontSize: 9,
                                            fontWeight: FontWeight.w300)),
                                  )
                              ),
                            ],
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}