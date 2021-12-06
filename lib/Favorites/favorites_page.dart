import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:free_time/Favorites/see_favorites.dart';
import 'package:free_time/Favorites/surprise_favorites.dart';
import 'package:free_time/colors.dart' as color;
import 'do_favorites.dart';
import 'eat_favorites.dart';

class Favorites extends StatefulWidget {
  Favorites({Key key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List info = [];

  _initData(){
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value){
      info = json.decode(value);
      setState(() {
      });
    });

  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 125,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.AppColor.lightPurple,
                  color.AppColor.blue.withOpacity(0.8),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(5,10),
                  blurRadius: 10,
                  color: color.AppColor.detail.withOpacity(0.2),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(left:20, top: 50,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 40,
                        color: color.AppColor.title,
                        fontWeight: FontWeight.w700,
                      )
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SizedBox(height: 50,),
                Text(
                    "Area of focus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: color.AppColor.detail,
                    )
                ),
              ],
            ),
          ),
          Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: info.length,
                    itemBuilder: (BuildContext context, int i){
                      return Container(
                          margin: EdgeInsets.only(left: 15, right: 10, top: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: color.AppColor.detail.withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: color.AppColor.detail.withOpacity(0.1),
                                )
                              ]
                          ),
                        child: ElevatedButton(
                          child: Text('\n' + info[i]['title'] + '\n',
                          style: TextStyle(fontSize: 24),),
                          style: ElevatedButton.styleFrom(
                            primary: Color(int.parse(info[i]['color'])  )
                          ),
                          onPressed: () {
                            switch(info[i]['title']){
                              case 'Eat': Navigator.of(context).push(MaterialPageRoute(builder: (context) => EatFavorites()));
                              break;
                              case 'Do': Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoFavorites()));
                              break;
                              case 'See': Navigator.of(context).push(MaterialPageRoute(builder: (context) => SeeFavorites()));
                              break;
                              case 'Surprise': Navigator.of(context).push(MaterialPageRoute(builder: (context) => SurpriseFavorites()));
                              break;
                              default:
                              break;
                            }
                          },
                        )
                      );
                    }
              )
          )),
        ],
      );
  }
}
