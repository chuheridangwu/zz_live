import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login/login.dart';
import 'home/home.dart';
import 'video/video.dart';
import 'rank/rank.dart';
import 'person/person.dart';


  void main() {
      WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        runApp(new MyApp());
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      });

  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZZ Live',
      debugShowCheckedModeBanner: false,
      theme: createAppThemeData(),
      home: MainPageWidget(),
      // initialRoute: "/demo",
      // routes: {
      //   "/":(context) => LoginView(),
      //   "/home":(context) => HomeLiveView(),
      //   "/video":(context) => VideoListView(),
      //   "/rank":(context) => RankView(),
      //   "/person":(context) => PersonView(),
      //   "/demo":(context) => DemoTest(),
      // },
    );
  }

  // 创建主题颜色
  ThemeData createAppThemeData(){
    return ThemeData(
      primarySwatch: Colors.yellow,
      iconTheme: IconThemeData(color: Colors.yellow), //用于Icon颜色
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar:BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
                          _currentIndex = index;
                        });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          items: navBarItems,
        )
    );
  }
}

class MyNavBarItem extends BottomNavigationBarItem {
  MyNavBarItem(String title,IconData icon,IconData activeIcon) : super(label: title,icon: Icon(icon),activeIcon: Icon(activeIcon));  
}

List<BottomNavigationBarItem> navBarItems = [
  MyNavBarItem("Home",Icons.home,Icons.home_outlined),
  MyNavBarItem("Video",Icons.play_circle_fill,Icons.play_circle_outline),
  MyNavBarItem("Rank",Icons.explore,Icons.explore),
  MyNavBarItem("Me",Icons.person,Icons.person_outline)
];

List<Widget> pages = [
  HomeLiveView(),
  VideoListView(),
  RankView(),
  PersonView(),
];