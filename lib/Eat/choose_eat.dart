import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../colors.dart' as color;
import 'dart:math' as math;
import 'eat_db_worker.dart';
import 'eat_model.dart';

class ChooseEat extends StatefulWidget {
  List restaurants;
  ChooseEat(this.restaurants, {Key key}) : super(key: key);

  @override
  _ChooseEatState createState() => _ChooseEatState();
}

class _ChooseEatState extends State<ChooseEat> with SingleTickerProviderStateMixin{
  final _random = new Random();
  int currRandomIndex;
  AnimationController animController;
  Animation<double> animation;

  chooseEatActivity(){
    currRandomIndex = 0 + _random.nextInt(widget.restaurants?.length - 0);
  }


  @override
  void initState(){
    super.initState();
    chooseEatActivity();
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
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
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
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
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
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
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
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
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
                          child: Image.asset('assets/pink_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/pink_triangle.png'),
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
                ],
              ),
            ),
            Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 550,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
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
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                  Container(
                    width: MediaQuery.of(context).size.width - 180,
                    height:400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Text(widget.restaurants[currRandomIndex].name,
                            style: TextStyle(fontSize: 30, color: color.AppColor.pink),),
                        SizedBox(height: 20),
                        Text(widget.restaurants[currRandomIndex].phone + '\n' +
                            'Address: ' + widget.restaurants[currRandomIndex].address,
                            style: TextStyle(fontSize: 18, color: color.AppColor.pink),),
                        SizedBox(height: 20),
                            SizedBox(
                                height: 28,
                                child: TextButton(
                                  child: Text('Website ',
                                      style: TextStyle(color: color.AppColor.pink,fontSize: 12)),
                                  onPressed: () async {
                                    await canLaunch(widget.restaurants[currRandomIndex].website) ? await launch(widget.restaurants[currRandomIndex].website) :
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
                        SizedBox(height: 20),
                        Expanded(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async{
                                print('Created Model');
                                await EatModelsDBWorker.db.create(widget.restaurants[currRandomIndex]);
                                print('Created in DB');
                                Navigator.of(context).pop();
                              },
                              child: Text('Perfect!',
                              style: TextStyle(fontSize: 20),),
                              style: ElevatedButton.styleFrom(
                                primary: color.AppColor.pink,
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
                        icon: Icon(Icons.keyboard_backspace,
                          color: Colors.black),
                        onPressed: (){Navigator.pop(context);},
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            chooseEatActivity();
                          });
                        },
                        child: Text('Let\'s Try Again',
                          style: TextStyle(color: Colors.black),
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
