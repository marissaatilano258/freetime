import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_time/Surprise/surprise_db_worker.dart';
import 'package:free_time/Surprise/surprise_model.dart';
import '../colors.dart' as color;
import 'dart:math' as math;

class Surprise extends StatefulWidget {
  Surprise({Key key}) : super(key: key);

  final dio = Dio(BaseOptions(
    baseUrl: 'http://www.boredapi.com/api/activity/',
  ));

  @override
  _SurpriseState createState() => _SurpriseState();
}

class _SurpriseState extends State<Surprise> with SingleTickerProviderStateMixin{
  String surprise;
  String type;
  String participants;
  bool isLoading = false;

  AnimationController animController;
  Animation<double> animation;

  void searchSurprise() async{
    isLoading = true;
    final response = await widget.dio.get('');
    setState((){
      surprise = response.data['activity'];
      type = response.data['type'];
      participants = response.data['participants'].toString();
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    searchSurprise();
    animController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    animation = Tween<double>(
      begin:0,
      end: 360 * math.pi / 180,
    ).animate(animController)
    ..addListener(() {
      setState(() {
      });
    });
    animController.repeat();
  }

  @override
  void dispose(){
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.background,
        body: Stack(
          children:[
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Transform.rotate(
                            angle: animation.value,
                            child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 30.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 30.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 30.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 30.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/green_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/yellow_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, left: 30.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 550,
              decoration: BoxDecoration(
                color: color.AppColor.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
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
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text('Here\'s an Idea',
                  style: TextStyle(color: color.AppColor.title, fontSize: 36, fontWeight: FontWeight.bold),),
                  isLoading
                      ? Padding(
                    padding: const EdgeInsets.only(top: 120.0, bottom: 180.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(color.AppColor.lightBlue)
                      ),
                    ),
                  )
                      : Container(
                    width: MediaQuery.of(context).size.width - 180,
                    height:400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text(surprise == null ? ' ' :surprise,
                            style: TextStyle(fontSize: 30, color: color.AppColor.title),),
                        SizedBox(height: 20),
                        Text('Type: ' + (type == null ? ' ' : type),
                            style: TextStyle(fontSize: 24, color: color.AppColor.title),),
                        SizedBox(height: 20),
                        Text('Participants: '  + (participants == null ? ' ' : participants),
                            style: TextStyle(fontSize: 24, color: color.AppColor.title),),
                        SizedBox(height: 20),
                        Expanded(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async{
                                SurpriseModel currEatModel = SurpriseModel.info(
                                    surprise,
                                    type,
                                    participants);
                                print('Created Model');
                                await SurpriseModelsDBWorker.db.create(currEatModel);
                                print('Created in DB');
                                Navigator.of(context).pop();
                              },
                              child: Text('Perfect!',
                              style: TextStyle(fontSize: 20),),
                              style: ElevatedButton.styleFrom(
                                primary: color.AppColor.lightBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home,
                          color: color.AppColor.title,),
                        onPressed: (){Navigator.pop(context);},
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            searchSurprise();
                          });
                        },
                        child: Text('Let\'s Try Again',
                          style: TextStyle(color: color.AppColor.title),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ]
        )
    );
  }
}
