import 'package:flutter/material.dart';
import 'package:News_Feed/home.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:News_Feed/screens/landing/forgotpassword.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF1C1C1C),
                height: 2,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                'NEWS',
                style: TextStyle(
                    fontFamily: "Stencil",
                    fontSize: 36,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2),
              ),
              Text(
                'FEED',
                style: TextStyle(
                    fontFamily: "Stencil",
                    fontSize: 36,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 07),
            child: Text(
              "Please login to continue",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF1C1C1C),
                height: 1,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
              //height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        child: TextFormField(
                          focusNode: myFocusNode,
                          controller: emailController,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: myFocusNode.hasFocus ? 24 : 18.0,
                                  color: myFocusNode.hasFocus
                                      ? Colors.blue
                                      : Colors.grey),
                              labelText: 'Enter email-id',
                              filled: true,
                              // isDense: true,
                              fillColor: Colors.grey[200],
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.email,
                                  ),
                                  onPressed: null),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(
                                    color: Colors.blue,
                                  ))),
                          validator: (value) {
                            if (value == null) {
                              return 'Enter Email Address';
                            } else if (!value.contains('@')) {
                              return 'Please enter a valid email address!';
                            }
                            return null;
                          },
                        ))
                  ])),
          SizedBox(
            height: 16,
          ),
          Container(
              //height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        child: TextFormField(
                          focusNode: myFocusNode1,
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              filled: true,
                              //isDense: true,
                              fillColor: Colors.grey[200],
                              labelText: 'Password',
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: myFocusNode1.hasFocus ? 24 : 18.0,
                                  color: myFocusNode1.hasFocus
                                      ? Colors.blue
                                      : Colors.grey),
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                  icon: Icon(Icons.lock), onPressed: null),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(
                                    color: Colors.blue,
                                  ))),
                          validator: (value) {
                            if (value == null) {
                              return 'Enter Password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters!';
                            }
                            return null;
                          },
                        ))
                  ])),
          SizedBox(
            height: 16,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
              child: Text(
                "FORGOT PASSWORD?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  height: 1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.60,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 01,
                        offset: const Offset(0.0, 5.0),
                      )
                    ]),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      logInToEmail();
                      //Navigator.pushNamed(context, 'Home');
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),
                )),
          )),
          SizedBox(
            height: 16,
          ),
          Center(
              child: Container(
                  child: Text(
            "OR",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1,
              color: Color(0xFF1C1C1C),
            ),
          ))),
          Center(
              child: Padding(
                  padding: EdgeInsets.all(07.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.60,
                      height: 50,
                      child: SignInButton(
                        Buttons.Google,
                        padding: EdgeInsets.only(left: 10.0),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        text: "Continue with Google",
                        onPressed: () async {
                          // ignore: unused_local_variable
                          UserCredential userCredential =
                              await signInWithGoogle();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        },
                      )))),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void logInToEmail() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (err) {
      // updated Nov 1, 2020
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.toString()),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } //finally {
    //isLoading = false;
    //}
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
