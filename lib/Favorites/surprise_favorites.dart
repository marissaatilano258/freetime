import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:free_time/Surprise/surprise_db_worker.dart';
import 'package:free_time/Surprise/surprise_model.dart';
import 'package:free_time/colors.dart' as color;

class SurpriseFavorites extends StatefulWidget {
  SurpriseFavorites({Key key}) : super(key: key);

  @override
  _SurpriseFavoritesState createState() => _SurpriseFavoritesState();
}

class _SurpriseFavoritesState extends State<SurpriseFavorites> {
  int _selectedIndex = 0;
  List info = [];

  List<SurpriseModel> surpriseList = [];

  void loadData() async {
    surpriseList.clear();
    surpriseList.addAll(await SurpriseModelsDBWorker.db.getAll());
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
                  color.AppColor.blue.withOpacity(0.8),
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
                      "Surprise",
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
                      color: color.AppColor.blue,
                    )
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_backspace,
                    color: color.AppColor.blue),
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
                      itemCount: surpriseList.length,
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
                                color: color.AppColor.blue.withOpacity(0.6),
                              ),
                              BoxShadow(
                                offset: Offset(0,-1),
                                blurRadius: 1,
                                color: color.AppColor.blue.withOpacity(0.2),
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
                                  onTap: () => _deleteSurprise(context, i)
                              )
                            ],
                            child: ListTile(
                                title: Text(surpriseList[i].surprise,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                subtitle: Text('Type: ' + surpriseList[i].type + '\n' +
                                    'Participants: ' + surpriseList[i].participants,
                                    style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)),
                                onTap: () async {
                                }
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

  _deleteSurprise(BuildContext context, int i) {
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
                      await SurpriseModelsDBWorker.db.delete(surpriseList[i].id);
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
