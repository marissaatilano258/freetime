import 'dart:math';
import 'package:flutter/material.dart';
import 'package:free_time/See/see_db_worker.dart';
import 'package:free_time/See/see_model.dart';
import '../colors.dart' as color;
import 'dart:math' as math;

class ChooseSee extends StatefulWidget {
  List movies;
  ChooseSee(this.movies, {Key key}) : super(key: key);

  @override
  _ChooseSeeState createState() => _ChooseSeeState();
}

class _ChooseSeeState extends State<ChooseSee> with SingleTickerProviderStateMixin{
  final _random = new Random();
  int currRandomIndex;
  AnimationController animController;
  Animation<double> animation;

  chooseSeeActivity(){
    currRandomIndex = 0 + _random.nextInt(widget.movies.length - 0);
  }


  @override
  void initState(){
    super.initState();
    chooseSeeActivity();
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
                            child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
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
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
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
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
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
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
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
                          child: Image.asset('assets/blue_triangle.png'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Transform.rotate(
                          angle: animation.value,
                          child: Image.asset('assets/blue_triangle.png'),
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
                  SizedBox(height: 20,),
                  Text('Here\'s an Idea',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                  Container(
                    width: MediaQuery.of(context).size.width - 180,
                    height:400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductBox(
                            name: widget.movies[currRandomIndex].name,
                            description: widget.movies[currRandomIndex].description,
                            vote: widget.movies[currRandomIndex].vote,
                            releaseDate: widget.movies[currRandomIndex].releaseDate,
                            image: widget.movies[currRandomIndex].image
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async{
                                print('Created Model');
                                await SeeModelsDBWorker.db.create(widget.movies[currRandomIndex]);
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
                        icon: Icon(Icons.keyboard_backspace,
                          color: Colors.black),
                        onPressed: (){Navigator.pop(context);},
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            chooseSeeActivity();
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
        height: 370,
        child: Column(
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
              SizedBox(height: 10,),
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
    );
  }
}