import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:free_time/See/see_db_worker.dart';
import 'package:free_time/See/see_model.dart';
import 'package:free_time/colors.dart' as color;

class SeeFavorites extends StatefulWidget {
  SeeFavorites({Key key}) : super(key: key);

  @override
  _SeeFavoritesState createState() => _SeeFavoritesState();
}

class _SeeFavoritesState extends State<SeeFavorites> {
  int _selectedIndex = 0;
  List info = [];

  List<SeeModel> seeList = [];

  void loadData() async {
    seeList.clear();
    seeList.addAll(await SeeModelsDBWorker.db.getAll());
    setState(() {
    });
  }

  _initData(){
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value){
      info = json.decode(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.background,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 125,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.AppColor.lightBlue,
                  color.AppColor.lightBlue.withOpacity(0.8),
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
                      "See",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Favorites",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: color.AppColor.lightBlue,
                    )
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_backspace,
                    color: color.AppColor.lightBlue),
                  onPressed: (){Navigator.pop(context);},
                ),
              ],
            ),
          ),
          Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                  child: ListView.builder(
                      itemCount: seeList.length,
                      itemBuilder: (_, i){
                        return Container(
                          decoration: BoxDecoration(
                            color: color.AppColor.background,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5,5),
                                blurRadius: 5,
                                color: color.AppColor.lightBlue.withOpacity(0.6),
                              ),
                              BoxShadow(
                                offset: Offset(0,-1),
                                blurRadius: 1,
                                color: color.AppColor.lightBlue.withOpacity(0.2),
                              ),
                            ],
                          ),
                          margin : EdgeInsets.only(left: 15, right: 15, top: 15),
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Slidable(
                            actionPane: SlidableScrollActionPane(),
                            actionExtentRatio: .25,
                            secondaryActions: [
                              IconSlideAction(
                                  caption: "Delete",
                                  color: color.AppColor.lightPurple,
                                  icon: Icons.delete,
                                  onTap: () => _deleteSee(context, i)
                              )
                            ],
                            child: ProductBox(
                                name: seeList[i].name,
                                description: seeList[i].description,
                                vote: seeList[i].vote,
                                releaseDate: seeList[i].releaseDate,
                                image: seeList[i].image
                            ),
                          ),
                        );
                      }
                  )
          )),
        ],
      ),
    );
  }

  _deleteSee(BuildContext context, int i) {
    return showDialog(
        context : context,
        barrierDismissible : false,
        builder : (BuildContext alertContext) {
          return AlertDialog(
              title : Text("Remove Favorite"),
              content : Text("Are you sure you want to remove this from your favorites?"),
              actions : [
                TextButton(child : Text("Cancel"),
                  onPressed: ()  => {Navigator.of(alertContext).pop()},
                ),
                TextButton(child : Text("Remove"),
                    onPressed : () async {
                      Navigator.of(alertContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                              backgroundColor : color.AppColor.lightPurple,
                              duration : Duration(seconds : 2),
                              content : Text("Removed from Favorites")
                          )
                      );
                      await SeeModelsDBWorker.db.delete(seeList[i].id);
                      setState(() {
                        loadData();
                      });
                    }
                )
              ]
          );
        }
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({ Key key, this.name, this.description, this.vote, this.releaseDate, this.image}) :
        super(key: key);
  final String name;
  final String description;
  final String vote;
  final String releaseDate;
  final String image;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 200,
        child: Card(
          elevation: 0.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(width: 15,),
                  Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(5,10),
                            blurRadius: 10,
                            color: color.AppColor.lightBlue.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(image)
                      )),
                  SizedBox(width: 15,),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(this.name,
                                  style: TextStyle(fontSize: 17,
                                      fontWeight: FontWeight.bold)
                              ),
                              Text('Rating: ' + this.vote + "/10",
                                  style: TextStyle(fontSize: 11)),
                              Text('Released: ' + this.releaseDate,
                                  style: TextStyle(fontSize: 11)),
                              Text(this.description,
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w300)),
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