import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'choose_do.dart';
import '../colors.dart' as color;
import 'do_db_worker.dart';
import 'do_model.dart';

class Do extends StatefulWidget {
  Do({Key key}) : super(key: key);

  final dio = Dio(BaseOptions(
      baseUrl: 'https://app.ticketmaster.com/discovery/v2/events?apikey=8b29rZF5fEhG2xI4KXR0qGfZv5POxdS8&locale=*&city=El%20Paso&stateCode=TX',
      headers: {
        'apikey': DotEnv().env['TICKETMASTER_API_KEY'],
      }));

  @override
  _DoState createState() => _DoState();
}

class _DoState extends State<Do> {
  List<DoModel> events = [];
  List respondedEvents;
  List favorites = [];
  bool isLoading = false;

  void searchDo() async{
    isLoading = true;
    final response = await widget.dio.get('');
    setState((){
      var jsonResponse = json.decode(response.data);
      respondedEvents = jsonResponse['_embedded']['events'];
      respondedEvents.shuffle();
      for(dynamic event in respondedEvents){
        events.add(DoModel.info(event['name'],
            event['_embedded']['venues'][0]['name'],
            event['dates']['start']['localDate'],
            event['dates']['start']['localTime'],
            event['url']
        ));
      }
      favorites = List(events.length);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    searchDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.background,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 175,
            decoration: BoxDecoration(
              color: color.AppColor.lightOrange,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(5,5),
                  blurRadius: 10,
                  color: color.AppColor.detail.withOpacity(0.2),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(left:20, top: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Let's Do",
                          style: TextStyle(
                            fontSize: 40,
                            color: color.AppColor.title,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                      IconButton(
                        icon: Icon(Icons.home,
                          color: color.AppColor.title,),
                        onPressed: (){Navigator.pop(context);},
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        splashColor: Colors.blue,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orangeAccent.withOpacity(0.8),
                                color.AppColor.pink.withOpacity(0.8)
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(5,10),
                                blurRadius: 10,
                                color: color.AppColor.detail.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child:  const Center(child: Text("Choose For Me!",
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseDo(events)));
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
                  valueColor: AlwaysStoppedAnimation<Color>(color.AppColor.lightOrange)
              ),
            ),
          )
              : Expanded(
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                    itemCount: events == null ? 0 : events.length,
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
                              color: color.AppColor.lightOrange.withOpacity(0.7),
                            ),
                            BoxShadow(
                              offset: Offset(0,-1),
                              blurRadius: 1,
                              color: color.AppColor.lightOrange.withOpacity(0.3),
                            ),
                          ],
                        ),
                        margin : EdgeInsets.only(left: 15, right: 15, top: 15),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                            title: Text(events == null ? '' : events[i].name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                            subtitle: Text('Location: ' + (events == null ? '' : events[i].location + '\n' +
                                'Date: ' + (events == null ? '' : events[i].date) + ' ' +
                                (events == null ? '' : events[i].time)),
                                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)),
                            trailing: Column(
                              children: [
                                SizedBox(height:5),
                                SizedBox(
                                    height: 20,
                                    child: TextButton(child: favorites[i] == null ? Icon(Icons.favorite_border,color: Colors.black, size: 15,)
                                        : Icon(Icons.check,color: color.AppColor.lightOrange, size: 15,),
                                        onPressed: () async{
                                          if(favorites[i] == null){
                                            favorites[i] = 1;
                                            await DoModelsDBWorker.db.create(events[i]);
                                            print('Created in DB');
                                          }
                                          setState(() {
                                          });
                                        })
                                ),
                                SizedBox(height: 3),
                                SizedBox(
                                    height: 28,
                                    child: TextButton(
                                      child: Text('Website ',
                                          style: TextStyle(color: color.AppColor.lightOrange,fontSize: 12)),
                                      onPressed: () async {
                                        await canLaunch(events[i].website) ? await launch(events[i].website) :
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
                      );
                    }
                )
            ),
          ),
        ],
      ),
    );
  }
}
