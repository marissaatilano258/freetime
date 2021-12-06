import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'choose_eat.dart';
import '../colors.dart' as color;
import 'eat_db_worker.dart';
import 'eat_model.dart';

class Eat extends StatefulWidget {
  Eat({Key key}) : super(key: key);

  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.documenu.com/v2/restaurants/search/geo?lat=31.853996&lon=-106.436571&distance=10&size=50',
      headers: {
        'X-API-KEY': DotEnv().env['DOCUMENU_API_KEY'],
      }));

  @override
  _EatState createState() => _EatState();
}

class _EatState extends State<Eat> {
  List <EatModel> restaurants = [];
  List respondedRestaurants;
  List favorites = [];
  bool isLoading = false;

  void searchEat() async{
    isLoading = true;
    final response = await widget.dio.get('');
    setState((){
      respondedRestaurants = response.data['data'];
      respondedRestaurants.shuffle();
      for(dynamic restaurant in respondedRestaurants){
        restaurants.add(EatModel.info(restaurant['restaurant_name'],
            restaurant['restaurant_phone'],
            restaurant['address']['formatted'],
            restaurant['restaurant_website']
        ));
      }
      favorites = List(restaurants.length);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    searchEat();
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
                color: color.AppColor.pink.withOpacity(0.8),
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
                            "Let's Eat",
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
                                  Colors.pinkAccent.shade100,
                                  Colors.yellow.shade500.withOpacity(0.7)
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChooseEat(restaurants)));
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
                    valueColor: AlwaysStoppedAnimation<Color>(color.AppColor.pink)
                ),
              ),
            )
                : Expanded(
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      itemCount: restaurants == null ? 0 :restaurants.length,
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
                                color: color.AppColor.pink.withOpacity(0.6),
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
                          child: ListTile(
                            title: Text(restaurants == null ? '' : restaurants[i].name,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                            subtitle: Text((restaurants == null ? '' : restaurants[i].phone) + '\n' +
                                'Address: ' + (restaurants == null ? '' : restaurants[i].address),
                                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)),
                            trailing: Column(
                              children: [
                                SizedBox(height:5),
                                SizedBox(
                                    height: 20,
                                    child: TextButton(child: favorites[i] == null ? Icon(Icons.favorite_border,color: Colors.black, size: 15,)
                                        : Icon(Icons.check,color: color.AppColor.pink, size: 15,),
                                        onPressed: () async{
                                            if(favorites[i] == null){
                                              favorites[i] = 1;
                                              await EatModelsDBWorker.db.create(restaurants[i]);
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
                                            style: TextStyle(color: color.AppColor.pink,fontSize: 12)),
                                      onPressed: () async {
                                        await canLaunch(restaurants[i].website) ? await launch(restaurants[i].website) :
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
