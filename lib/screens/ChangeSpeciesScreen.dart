import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom/BorderBoxButton.dart';
import '../custom/CustomTextField.dart';
import '../utils/widget_functions.dart';

class ChangeSpeciesScreen extends StatefulWidget {
  const ChangeSpeciesScreen({super.key});

  @override
  State<ChangeSpeciesScreen> createState() => _ChangeSpeciesScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ChangeSpeciesScreenState extends State<ChangeSpeciesScreen> {
  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Column(
              children: [
                addVerticalSpace(15),
                Text("Add Plant", style: themeData.textTheme.displayLarge),
                addVerticalSpace(50),
                Expanded(
                  child: FutureBuilder(
                    future: getSpecies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot.data![index], style: themeData.textTheme.headlineMedium),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete), color: Colors.red,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("DELETE?"),
                                          content: Text("You can't undo this action!"),
                                          actions: [
                                            TextButton(
                                              child: Text("CANCEL"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("OKAY"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        )
                                      );
                                    },
                                  ),
                                ),
                                index != snapshot.data!.length - 1 ?
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                  indent: 15,
                                  endIndent: 15,
                                ) :
                                Container()
                              ],
                            );
                          },
                        );
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("ERROR: ${snapshot.error}");
                      } else {
                        return Text("${snapshot.data}");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 15,
            left: 15,
            child: BorderBoxButton(
              width: 50,
              height: 50,
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          )
        ],
      )
    );
  }
}

Future<List<String>> getSpecies() async {
  List<String> output = [];
  DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${_auth.currentUser!.uid}');

  DocumentSnapshot data = await userDoc.get();

  output = List<String>.from(data["plantSpecies"]);

  print("---------------- ${output} -------------------");

  return output;
}

Future addSpecies(String name) async {

}