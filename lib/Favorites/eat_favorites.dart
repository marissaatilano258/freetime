import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:free_time/Do/do.dart';
import 'package:free_time/Eat/eat.dart';
import 'package:free_time/Eat/eat_db_worker.dart';
import 'package:free_time/Eat/eat_model.dart';
import 'package:free_time/Surprise/surprise.dart';
import 'package:free_time/See/see.dart';
import 'package:free_time/colors.dart' as color;
import 'package:url_launcher/url_launcher.dart';

class EatFavorites extends StatefulWidget {
  EatFavorites({Key key}) : super(key: key);

  @override
  _EatFavoritesState createState() => _EatFavoritesState();
}

class _EatFavoritesState extends State<EatFavorites> {
  int _selectedIndex = 0;
  List info = [];

  List<EatModel> eatList = [];

  void loadData() async {
    eatList.clear();
    eatList.addAll(await EatModelsDBWorker.db.getAll());
    setState((){
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
                  color.AppColor.pink.withOpacity(0.8),
                  color.AppColor.pink.withOpacity(0.8),
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
                      "Eat",
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
                      color: color.AppColor.pink,
                    )
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_backspace,
                    color: color.AppColor.pink),
                  onPressed: (){Navigator.pop(context);},
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                    child: ListView.builder(
                        itemCount: eatList.length,
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
                                  color: color.AppColor.pink.withOpacity(0.4),
                                ),
                                BoxShadow(
                                  offset: Offset(0,-1),
                                  blurRadius: 1,
                                  color: color.AppColor.pink.withOpacity(0.2),
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
                                    onTap: () => _deleteEat(context, i)
                                )
                              ],
                              child: ListTile(
                                  title: Text(eatList[i].name,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                                  subtitle: Text(eatList[i].phone + '\n' +
                                      'Address: ' + eatList[i].address,
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)),
                                  trailing: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      SizedBox(
                                          height: 28,
                                          child: TextButton(
                                            child: Text('Website ',
                                                style: TextStyle(color: color.AppColor.pink,fontSize: 12)),
                                            onPressed: () async {
                                              await canLaunch(eatList[i].website) ? await launch(eatList[i].website) :
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible: false, // user must tap button!
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Failed: Launch URL'),
                                                    content: Text('This URL can not be launched on a browser'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          )
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                  }
                              ),
                            ),
                          );
                        }
                    )
          ),
              )),
        ],
      ),
    );
  }

  _deleteEat(BuildContext context, int i) {
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
                      await EatModelsDBWorker.db.delete(eatList[i].id);
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
