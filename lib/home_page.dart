import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:free_time/Favorites/favorites_page.dart';
import 'colors.dart' as color;
import 'main_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  final dio = Dio(BaseOptions(
    baseUrl: 'http://www.boredapi.com/api/activity/',
  ));

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List _children = [MainPage(''), Favorites()];

  String idea;
  bool isLoading = false;

  void searchIdea() async{
    isLoading=true;
    widget.dio.get('').then((response) {
      idea = response.data['activity'];
      setState(() {
        _children = [MainPage(idea), Favorites()];
        print(idea);
        isLoading=false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    searchIdea();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
      backgroundColor: color.AppColor.lightPurple,
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Image(image: AssetImage(
                  "assets/FreeTimeLogo.png",
                )),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(color.AppColor.title)
                ),
              ],
            ),
          ),
        ) : Scaffold(
      backgroundColor: color.AppColor.background,
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: color.AppColor.lightPurple,
        unselectedItemColor: color.AppColor.detail.withOpacity(0.3),
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
