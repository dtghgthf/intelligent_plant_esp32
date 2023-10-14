import 'package:flutter/material.dart';
import 'package:intelligent_plant_esp32/custom/Cards/CardButton.dart';
import 'package:intelligent_plant_esp32/custom/CustomTextField.dart';
import 'package:intelligent_plant_esp32/screens/Auth/SignUp.dart';
import 'package:intelligent_plant_esp32/utils/auth.dart';
import 'package:intelligent_plant_esp32/utils/widget_functions.dart';

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();

  @override
  void initState() {
    _emailController.clear();
    _passwordController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            addVerticalSpace(15),
            Text("Sign In", style: themeData.textTheme.displayLarge),
            addVerticalSpace(50),
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
            addVerticalSpace(25),
            CardButton(
              onTap: () {
                _auth.signInWithEmailAndPassword(context, _emailController.text, _passwordController.text);
              },
              child: Text("Let's Go", style: themeData.textTheme.displayMedium),
            ),
            addVerticalSpace(5),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text("No Account yet? Sign Up here!", style: themeData.textTheme.bodyMedium,),
            ),
            addVerticalSpace(15),
            Divider(
              thickness: 4,
              indent: 15,
              endIndent: 15,
            ),
            addVerticalSpace(25),
            CardButton(
              width: screenSize.width - (screenSize.width / 3),
              onTap: () {
                _auth.signInWithGoogle(context);
              },
              child: Row(
                children: [
                  addHorizontalSpace(10),
                  Text("G", style: themeData.textTheme.displayLarge),
                  addHorizontalSpace(15),
                  Text("Sign In with Google", style: themeData.textTheme.labelLarge,)
                ],
              ),
            ),
            addVerticalSpace(15),
            CardButton(
              width: screenSize.width - (screenSize.width / 3),
              onTap: () {
                _auth.signInAnonymously(context);
              },
              child: Row(
                children: [
                  addHorizontalSpace(10),
                  Icon(Icons.person),
                  addHorizontalSpace(10),
                  Text("Sign In Anonymously", style: themeData.textTheme.labelLarge,)
                ],
              ),
            )
          ],
        )
      )
    );
  }
}
