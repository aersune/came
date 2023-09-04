import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {





  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: null,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/registon.jpg",
                    ),fit: BoxFit.cover
                )
            ),
          ),
          ListTile(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AllChapters()));
            },
            leading: const Icon(Icons.home),
            title: Text("Main"),
          ),
          ListTile(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AllLaws()));
            },
            leading: const Icon(Icons.newspaper),
            title: Text("News"),
          ),
          ListTile(
            onTap: () {
            },
            leading: const Icon(Icons.account_balance_outlined),
            title: Text("About comp"),
          ),
          ListTile(
            onTap: () {
            },
            leading: const Icon(Icons.telegram),
            title: Text("ms"),
          ),



        ],
      ),
    );
  }

}