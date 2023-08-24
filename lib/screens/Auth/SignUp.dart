import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/main.dart';
import 'package:intelligent_plant_esp32/screens/Wrapper.dart';
import 'package:intelligent_plant_esp32/utils/custom_functions.dart';

import '../../custom/BorderBoxButton.dart';
import '../../custom/Cards/CardButton.dart';
import '../../custom/CustomTextField.dart';
import '../../utils/auth.dart';
import '../../utils/widget_functions.dart';

FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _nameController = TextEditingController();

List<NetworkImage> profilePictures = [];

class _SignUpState extends State<SignUp> {

  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();

    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    activePictureIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: userStreamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        addVerticalSpace(15),
                        Text("Sign Up", style: themeData.textTheme.displayLarge),
                        addVerticalSpace(50),
                        CustomTextField(
                          text: "Full Name",
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                        ),
                        addVerticalSpace(15),
                        CustomTextField(
                          text: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        addVerticalSpace(15),
                        CustomTextField(
                          text: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                        ),
                        addVerticalSpace(15),
                        Row(
                          children: [
                            addHorizontalSpace(screenSize.width - (screenSize.width / 1.1)),
                            Text("Picture", style: themeData.textTheme.displayMedium),
                            addHorizontalSpace(screenSize.width - (screenSize.width / 1.6)),
                            ProfilePictureSelecter(),
                          ],
                        ),
                        addVerticalSpace(25),
                        CardButton(
                          onTap: () {
                            _auth.createUser(_emailController.text, _passwordController.text, _nameController.text, profilePictures[activePictureIndex]);
                            _auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                            Navigator.pop(context);
                            setState(() {

                            });
                          },
                          child: Text("Create Account", style: themeData.textTheme.displayMedium),
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
                      child: Icon(Icons.arrow_back),
                    ),
                  )
                ]
            );
          }
          else if (snapshot.hasError) {
            return const Text("ERROR");
          } else if (snapshot.hasData) {
            return MyApp();
          } else {
            return Text(snapshot.data.toString());
          }
        },
      ),
    );
  }
}

class ProfilePictureSelecter extends StatefulWidget {
  const ProfilePictureSelecter({super.key});

  @override
  State<ProfilePictureSelecter> createState() => _ProfilePictureSelecterState();
}

int activePictureIndex = 0;

class _ProfilePictureSelecterState extends State<ProfilePictureSelecter> {

  int pictureCountInCloud = 0;

  Future<List<NetworkImage>> initList() async {
    pictureCountInCloud = await countItemsInFolder("profilepictures");

    for (int i = 0; i < pictureCountInCloud; i++) {
      profilePictures.add(NetworkImage("https://firebasestorage.googleapis.com/v0/b/intelligent-plant.appspot.com/o/profilepictures%2FPP_$i.png?alt=media&token=26c030d7-cdca-4553-b0a0-c4c22d528a9c"));
    }

    return profilePictures;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Ink(
              child: InkWell(
                  onTap: () {
                    activePictureIndex < (pictureCountInCloud - 1)
                        ? activePictureIndex++
                        : activePictureIndex = 0;
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profilePictures[activePictureIndex],
                  )
              )
          );
        } else if (snapshot.hasError) {
          return Text("ERROR");
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
