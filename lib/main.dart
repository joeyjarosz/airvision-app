import 'package:air_vision/screens/camera/camera_screen.dart';
import 'package:air_vision/screens/debug_screen.dart';
import 'package:air_vision/screens/map_screen.dart';
import 'package:air_vision/screens/settings_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

void main() => runApp(AirVision());

class AirVision extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air Vision',
      theme: ThemeData(
          primaryColor: Color(0xFF3496F7), accentColor: Color(0xFF3496F7)),
      // initialRoute: MapScreen.id,
      // routes: {
      //   MapScreen.id: (context) => MapScreen(),
      //   CameraScreen.id: (context) => CameraScreen(),
      //   SettingsScreen.id: (context) => SettingsScreen(),
      //   DebugScreen.id: (context) => DebugScreen()
      // },
      home: MyHomePage(
        title: "home",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          MapScreen(),
          CameraScreen(),
          Container(
            child: Center(
              child: Text("Profile page WIP"),
            ),
            color: Colors.greenAccent,
          ),
          DebugScreen()
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 25,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          });
        }),
        items: [
          BottomNavyBarItem(
              icon: Icon(FontAwesomeIcons.globeEurope),
              title: Text('Home'),
              activeColor: Colors.purple,
              textAlign: TextAlign.center,
              inactiveColor: Color(0xff1B2531)),
          BottomNavyBarItem(
              icon: Icon(Icons.camera),
              title: Text('Camera'),
              activeColor: Colors.lightBlue,
              textAlign: TextAlign.center,
              inactiveColor: Color(0xff1B2531)),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'Profile',
              ),
              activeColor: Colors.green,
              textAlign: TextAlign.center,
              inactiveColor: Color(0xff1B2531)),
          BottomNavyBarItem(
              icon: Icon(Icons.bug_report),
              title: Text('Debug'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
              inactiveColor: Color(0xff1B2531)),
        ],
      ),
    );
  }
}
