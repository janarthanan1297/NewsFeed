import 'package:News_Feed/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUp> {
  bool isLoading = false;
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();
  FocusNode myFocusNode4 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(),
            child: Text(
              "Sign up with",
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
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2),
              )
            ],
          ),
          SizedBox(
            height: 26,
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
                          controller: nameController,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: myFocusNode1.hasFocus ? 24 : 18.0,
                                  color: myFocusNode1.hasFocus
                                      ? Colors.black
                                      : Colors.grey),
                              labelText: 'Enter Username',
                              filled: true,
                              // isDense: true,
                              fillColor: Colors.grey[200],
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.person,
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
                                    color: Colors.black,
                                  ))),
                          validator: (value) {
                            if (value == null) {
                              return 'Enter Username';
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
                          focusNode: myFocusNode2,
                          controller: emailController,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: myFocusNode2.hasFocus ? 24 : 18.0,
                                  color: myFocusNode2.hasFocus
                                      ? Colors.black
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
                                    color: Colors.black,
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
                          focusNode: myFocusNode3,
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              filled: true,
                              //isDense: true,
                              fillColor: Colors.grey[200],
                              labelText: 'Password',
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: myFocusNode3.hasFocus ? 24 : 18.0,
                                  color: myFocusNode3.hasFocus
                                      ? Colors.black
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
                                    color: Colors.black,
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
                          focusNode: myFocusNode4,
                          controller: retypePasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              filled: true,
                              //isDense: true,
                              fillColor: Colors.grey[200],
                              labelText: 'Re-Enter Password',
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: myFocusNode4.hasFocus ? 24 : 18.0,
                                  color: myFocusNode4.hasFocus
                                      ? Colors.black
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
                                    color: Colors.black,
                                  ))),
                          validator: (value) {
                            if (value == null) {
                              return 'Re-enter Password';
                            } else if (value.trim() !=
                                passwordController.text.trim()) {
                              return 'Passwords didn\'t match. Please re-enter password.';
                            }
                            return null;
                          },
                        ))
                  ])),
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
                    color: Colors.black,
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
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      registerToEmail();
                    }
                  },
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )),
          )),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  void registerToEmail() async {
    CircularProgressIndicator();
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = userCredential.user;
      //FirebaseAuth.instance.currentUser;
      if (user != null) {
        // added "await" Nov 1,2020. new method to update user profile
        user.updateDisplayName(nameController.text.trim());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } catch (err) {
      isLoading = false;

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
    }
  }
}
