import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salaryredesign/pages/employee/my_profile.dart';
import 'package:salaryredesign/pages/mark_attendance/mark_attendance.dart';
import 'package:salaryredesign/pages/settings/settings_page.dart';
import 'package:salaryredesign/pages/tab_pages/dashboard.dart';
import 'package:salaryredesign/providers/clock.dart';
import '../../constants/colors.dart';
import '../../constants/image_urls.dart';
import '../attendance/attendance_step1.dart';
import '../employee/employee_dshboard.dart';

/// This is the stateful widget that the main application instantiates.
class TabsPage extends StatefulWidget {
  static const String id="tab";
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

/// This is the private State class that goes with TabsPage.
class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );

  late List<Widget> _widgetOptions = <Widget>[
    Employee_dashboard_Page(),
    // CheckAttStatusPage(navigatorKey: null,),
      Mark_Attendance_Page(),
    // MyPorfile_Page(),
    Settings_Page(),
  ];
  static List<Widget> _widgetOptionsEmp = <Widget>[
    Employee_dashboard_Page(),

    // MyPorfile_Page(),
    Settings_Page(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  bool isEmp=false;
  check()async{
    if( Provider.of<GlobalModal>(context,listen: false).userData!.userId!=1){
      isEmp=true;
    }

  }
  // Map<int, GlobalKey> navigatorKeys = {
  //   0: GlobalKey(),
  //   1: GlobalKey(),
  //   2: GlobalKey(),
  // };
@override
  void initState() {
    // TODO: implement initState
  // check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Provider.of<GlobalModal>(context,listen: false).userData!.userId!=1?_widgetOptions.elementAt(_selectedIndex):_widgetOptionsEmp.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          // boxShadow: [
          //   boxShadowtop
          // ]
        ),
        // height: 60,
        child: BottomNavigationBar(
          backgroundColor: MyColors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          elevation: 0,
          unselectedFontSize: 12,
          selectedLabelStyle: TextStyle(fontFamily: 'medium'),
          unselectedLabelStyle: TextStyle(fontFamily: 'medium'),
          unselectedItemColor: MyColors.bottommenucolor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(MyImages.home_icon),
                color: MyColors.bottommenucolor,
                size: 24,
              ),
              activeIcon:ImageIcon(
                AssetImage(MyImages.home_icon),
                 color: MyColors.primaryColor,
                size: 24,
              ),
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label: 'Dashboard',
            ),
            if( Provider.of<GlobalModal>(context,listen: false).userData!.userId!=1)
              BottomNavigationBarItem(
                label: 'Mark Attendance',
                // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              icon: ImageIcon(
                AssetImage(MyImages.fingerprint_icon),
                color: MyColors.bottommenucolor,
                size: 24,
              ),
              activeIcon: ImageIcon(
                AssetImage(MyImages.fingerprint_icon),
                color: MyColors.primaryColor,
                size: 24,
              ),
            ),
            // BottomNavigationBarItem(
            //   label: 'Profile',
            //   // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
            //   icon: ImageIcon(
            //     AssetImage(MyImages.profile_icon),
            //     color: MyColors.bottommenucolor,
            //     size: 24,
            //   ),
            //   activeIcon: Stack(
            //     children: <Widget>[
            //       // Icon(Icons.shopping_cart, size: 30, color: themecolor,),
            //       ImageIcon(
            //         AssetImage(MyImages.profile_icon),
            //         color: MyColors.primaryColor,
            //         size: 24,
            //       ),
            //     ],
            //   ),
            // ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.school, size: 30, color: Colors.black,),
              icon: ImageIcon(
                AssetImage(MyImages.setting_icon),
                color: MyColors.bottommenucolor,
                size: 24,
              ),
              activeIcon: ImageIcon(
                AssetImage(MyImages.setting_icon),
                color: MyColors.primaryColor,
                size: 24,
              ),
              label: 'Settings',
              backgroundColor: Colors.white,
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
