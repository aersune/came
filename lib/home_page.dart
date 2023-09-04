import 'package:came/methods/provider.dart';
import 'package:came/pages/about_comp_page.dart';
import 'package:came/pages/came_page.dart';
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
    ChatsPage(),
    CamePage(),
    AboutComp(),
  ];

  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = PosterPage();
  var currentUser = FirebaseAuth.instance.currentUser;
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  String  formattedDate = DateFormat('M_d_y').format(DateTime.now());

  var iconHeight = 40;
  var bottomAppbarHeight = 60;
  var isActive = false;

  @override
  void initState() {
    super.initState();
    initVariables();
  }

  Future initVariables() async{
    Provider.of<CameProvider>(context, listen: false).ref = await FirebaseDatabase.instance.ref("users/$currentUserId/$formattedDate");
  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: PageStorage(bucket: bucket, child: _pages[currentTab]),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: EdgeInsets.only(bottom: isActive ? 20 : 0),
            width: isActive ? size.width * 0.6 : 0,
            child: TextField(
              controller: _messageController,
              obscureText: false,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
              decoration: InputDecoration(
                labelText: ' Message',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: AppColor.secondColor.withOpacity(0.8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none)),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.only(bottom: isActive ? 10 : 0),
              child: floatingActionButtonWidget())
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppColor.secondColor,
        notchMargin: 10,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: bottomAppbarHeight.toDouble(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  // MyIcons(0, Icons.account_box),
                  // MyIcons(1, Icons.account_box),
                  MaterialButtonWidget(0, Remix.newspaper_line, PosterPage(),
                      'Новости', iconHeight.toDouble()),
                  MaterialButtonWidget(1, Remix.map_2_line, MapsPage(), 'Карта',
                      iconHeight.toDouble()),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButtonWidget(3, Remix.arrow_up_down_line, CamePage(),
                      'В работе', iconHeight.toDouble()),
                  MaterialButtonWidget(4, Remix.contacts_book_line, AboutComp(),
                      'Контакты', iconHeight.toDouble()),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MaterialButtonWidget(
      int index, IconData icon, Widget page, String title, height) {
    return SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: height,
        child: MaterialButton(
          // minWidth: height,
          height: height,
          onPressed: () {
            setState(() {
              currentTab = index;
              currentScreen = page;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: currentTab == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                    size: height,
                  ),
                  currentTab == index
                      ? Text(
                          title,
                          style: TextStyle(color: Colors.white),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget floatingActionButtonWidget() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          currentTab = 2;
          currentScreen = ChatsPage();
          isActive = !isActive;
          !isActive ? iconHeight = 40 : iconHeight = 0;
          !isActive ? bottomAppbarHeight = 60 : bottomAppbarHeight = 0;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: isActive ? 4 : 0),
        child: Icon(
          isActive ? Remix.send_plane_2_line : Remix.send_plane_fill,
          size: 30,
        ),
      ),
      backgroundColor: AppColor.secondColor,
    );
  }
}
