import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_time/Surprise/surprise.dart';
import 'package:free_time/See/see.dart';
import 'colors.dart' as color;
import 'Do/do.dart';
import 'Eat/eat.dart';

class MainPage extends StatefulWidget {
  String idea;
  MainPage(this.idea,{Key key}) : super(key: key);

  final dio = Dio(BaseOptions(
      baseUrl: 'http://www.boredapi.com/api/activity/',
      ));

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List info = [];
  //bool isLoading = false;

  _initData(){
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value){
      info = json.decode(value);
      setState(() {
      });
    });
  }

  //void searchIdea() async{
  //  isLoading=true;
  //  widget.dio.get('').then((response) {
      //idea = response.data['activity'];
  //    setState(() {
  //      isLoading=false;
  //    });
  //  });
  //}

  @override
  void initState() {
    super.initState();
    _initData();
    //searchIdea();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.AppColor.lightPurple,
                  color.AppColor.blue,
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
                  SizedBox(height:20,),
                  Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 40,
                        color: color.AppColor.title,
                        fontWeight: FontWeight.w700,
                      )
                  ),
                  SizedBox(height:5,),
                  Text(
                      "What do you want to do today?",
                      style: TextStyle(
                        fontSize: 25,
                        color: color.AppColor.title,
                      )
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top:30),
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/white_card.png"
                        ),
                        fit: BoxFit.fill,
                      ),
                      boxShadow:[
                        BoxShadow(
                          blurRadius: 40,
                          offset: Offset(8,10),
                          color: color.AppColor.detail.withOpacity(0.1),
                        ),
                        BoxShadow(
                          blurRadius: 10,
                          offset: Offset(-1,-5),
                          color: color.AppColor.detail.withOpacity(0.1),
                        ),
                      ]
                  ),
                ),
                Container(
                  height: 135,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(right: 230, top: 20, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(
                          "assets/confetti.png",
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 100,
                  margin: const EdgeInsets.only(left: 140, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Here's an idea,",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: color.AppColor.lightPurple,
                          )
                      ),
                      const SizedBox(height: 10,),
                      Flexible(child: Text(widget.idea ?? '',
                        style: TextStyle(
                          color: color.AppColor.lightPurple,
                          fontSize: 16,
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
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
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      //childAspectRatio:((MediaQuery.of(context).size/2) / 50),
                    ),
                    itemCount: info.length,
                    itemBuilder: (BuildContext context, int i){
                      return Container(
                          margin: EdgeInsets.only(left: 15, right: 10, bottom: 15, top: 15),
                          padding: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: color.AppColor.detail.withOpacity(0.1),
                                  //int.parse(info[i]["color"])
                                  //color: color.AppColor.homePageDetail.withOpacity(0.1)
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: color.AppColor.detail.withOpacity(0.1),
                                )
                              ]
                          ),
                        child: IconButton(
                          icon: Image.asset(info[i]['img']),
                          iconSize: 80,
                          onPressed: () {
                            switch(info[i]['title']){
                              case 'Eat': Navigator.of(context).push(MaterialPageRoute(builder: (context) => Eat()));
                              break;
                              case 'Do': Navigator.of(context).push(MaterialPageRoute(builder: (context) => Do()));
                              break;
                              case 'See': Navigator.of(context).push(MaterialPageRoute(builder: (context) => See()));
                              break;
                              case 'Surprise': Navigator.of(context).push(MaterialPageRoute(builder: (context) => Surprise()));
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
