import 'package:came/methods/firestore_methods.dart';
import 'package:came/methods/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PosterPage extends StatefulWidget {
  const PosterPage({Key? key}) : super(key: key);

  @override
  State<PosterPage> createState() => _PosterPageState();
}

class _PosterPageState extends State<PosterPage> {
  FirestoreMethods firestoreMedhods = FirestoreMethods();

  var currentUser = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {

     var ref = Provider.of<CameProvider>(context).ref;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    firestoreMedhods.updateData();
                  });
                },
                child: Icon(Icons.update),
              ),
              SizedBox(width: 20,),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    // firestoreMedhods.addData(ref,);
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
      body: StreamBuilder(
          stream: firestoreMedhods.getDocuments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var name = snapshot.data?[index];
                      return ListTile(
                        title: Text(name.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            firestoreMedhods.delete(name.toString());
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Text('There is nothing'),
                );
              }
            }
          }),
    );
  }
}
