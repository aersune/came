import 'package:came/methods/provider.dart';
import 'package:came/pages/about_comp_page.dart';
import 'package:came/pages/attendance_screen.dart';
import 'package:came/pages/chats_page.dart';
import 'package:came/pages/maps_page.dart';
import 'package:came/pages/poster_page.dart';
import 'package:came/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _messageController = TextEditingController();

  final List<Widget> _pages = [
    PosterPage(),
    MapsPage(),
    AttendanceScreen(),
    ChatsPage(),
    AboutComp(),
  ];

  int currentTab = 2;

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = PosterPage();
  var currentUser = FirebaseAuth.instance.currentUser;
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  String formattedDate = DateFormat('M_d_y').format(DateTime.now());

  double iconHeight = 40.0;
  var bottomAppbarHeight = 60;
  var isActive = false;

  @override
  void initState() {
    super.initState();
    initVariables();
  }

  Future initVariables() async {
    Provider.of<CameProvider>(context, listen: false).ref =
        await FirebaseDatabase.instance
            .ref("users/$currentUserId/$formattedDate");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: PageStorage(bucket: bucket, child: _pages[currentTab]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        color: AppColor.secondColor,
        // notchMargin: 10,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: size.height / 12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              // MyIcons(0, Icons.account_box),
              // MyIcons(1, Icons.account_box),
              ButtonWidget(0, Remix.newspaper_line, context),
              ButtonWidget(1, Remix.map_2_line, context),
              ButtonWidget(2, Remix.arrow_up_down_line,context ),
              ButtonWidget(3, Remix.message_2_line, context),
              ButtonWidget(4, Remix.contacts_book_line, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget ButtonWidget(int index, IconData icon,context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
          currentTab = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: currentTab == index
                  ? Colors.white
                  : Colors.white.withOpacity(0.6),
              size: size.width / 10,
            ),
           AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: EdgeInsets.only(top:currentTab == index ? 5 :0),
              height: currentTab == index ? size.height  / 100 : 0,
              width: size.width / 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
            )
          ],
        ),
      ),
    );
  }
}
