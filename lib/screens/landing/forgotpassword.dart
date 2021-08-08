import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ten_news/main.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  TextEditingController emailController = TextEditingController();

  String email;

  String password;
  Widget _buildLogo() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
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
                  style: TextStyle(fontFamily: "Stencil", fontSize: 36, color: Colors.black, fontWeight: FontWeight.w700, letterSpacing: 2),
                ),
                Text(
                  'FEED',
                  style: TextStyle(fontFamily: "Stencil", fontSize: 36, color: Colors.blue, fontWeight: FontWeight.w700, letterSpacing: 2),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1C1C1C),
                  height: 1,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                //height: 50,
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: TextFormField(
                        focusNode: myFocusNode,
                        controller: emailController,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle:
                                TextStyle(fontSize: myFocusNode.hasFocus ? 24 : 18.0, color: myFocusNode.hasFocus ? Colors.blue : Colors.grey),
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
                                color: Colors.grey[200],
                              ),
                            ),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(
                                  color: Colors.blue,
                                ))),
                        validator: (value) {
                          if (value.isEmpty) {
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
            SizedBox(
              height: 24,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15), boxShadow: [
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
                      if (_formKey.currentState.validate()) {
                        FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyApp()));
                        Fluttertoast.showToast(
                            msg: 'Reset mail sent to your email-id', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                      }
                    },
                    child: Text(
                      'Reset Password',
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildLogo(),
              // _buildContainer(),
            ],
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
