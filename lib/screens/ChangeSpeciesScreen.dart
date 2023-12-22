import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/utils/auth.dart';

import '../custom/BorderBoxButton.dart';
import '../custom/CustomTextField.dart';
import '../utils/widget_functions.dart';

class ChangeSpeciesScreen extends StatefulWidget {
  const ChangeSpeciesScreen({super.key});

  @override
  State<ChangeSpeciesScreen> createState() => _ChangeSpeciesScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController _addSpeciesTextFieldController = TextEditingController();

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
                Text("Change Species", style: themeData.textTheme.displayLarge),
                addVerticalSpace(50),
                Expanded(
                  child: FutureBuilder(
                    future: getSpecies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data!.isEmpty) {
                          return Column(
                            children: [
                              Icon(Icons.question_mark),
                              addVerticalSpace(15),
                              Text("Hm. No species here..", style: themeData.textTheme.labelLarge,),
                            ],
                          );
                        } else {
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
                                                  onPressed: () async {
                                                    Navigator.pop(context); //TODO: add delete Species

                                                    await deleteSpecies(snapshot.data![index]);

                                                    setState(() {});
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
                        }
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
            right: screenSize.width / 56,
            bottom: screenSize.height / 56,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      _addSpeciesTextFieldController.clear();
                      return SimpleDialog(
                        title: Text("Add Species"),
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                                child: TextField(
                                  controller: _addSpeciesTextFieldController,
                                  maxLength: 20,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        List<String> species =  await getSpecies();

                                        if (_addSpeciesTextFieldController.text != "") {
                                          if (!species.contains(_addSpeciesTextFieldController.text)) {
                                            addSpecies(_addSpeciesTextFieldController.text);
                                          } else {
                                            showErrorSnackbar(context, "The Species ${_addSpeciesTextFieldController.text} already exists!");
                                          }
                                        } else {
                                          showErrorSnackbar(context, "Please set a Name");
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Text("Continue"),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                );
              },
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
  DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${_auth.currentUser!.uid}');
  List<String> species = await getSpecies();

  species.add(name);

  await userDoc.update({
    "plantSpecies": species
  });
}

Future deleteSpecies(String name) async {
  DocumentReference userDoc = FirebaseFirestore.instance.doc('Users/${_auth.currentUser!.uid}');
  List<String> species = await getSpecies();

  species.remove(name);

  await userDoc.update({
    "plantSpecies": species
  });
}