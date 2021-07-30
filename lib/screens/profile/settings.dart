import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ten_news/screens/profile/profile.dart';
import '../../main.dart';

class SettingsTwoPage extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SettingsTwoPage> {
  bool value1 = false;
  bool value2;
  String username = FirebaseAuth.instance.currentUser.displayName;
  String profile = FirebaseAuth.instance.currentUser.photoURL;
  String email = FirebaseAuth.instance.currentUser.email;
  final TextStyle whiteText = TextStyle(
    color: Colors.white,
  );
  final TextStyle greyTExt = TextStyle(
    color: Colors.grey.shade600,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: Theme(
        data: Theme.of(context).copyWith(brightness: Brightness.dark, primaryColor: Colors.purple, backgroundColor: Colors.white),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        //color: primary,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: Offset(0, 10))],
                        image: DecorationImage(
                          image: NetworkImage(profile == null ? "https://i.stack.imgur.com/l60Hf.png" : profile),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            username,
                            style: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 10, top: 20, bottom: 10),
                  title: Text(
                    "Profile Settings",
                    style: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    username,
                    style: greyTExt,
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: IconButton(
                        icon: Icon(Icons.person, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditProfilePage()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "Feedback",
                    style: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(Icons.feedback, color: Colors.white),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 10, bottom: 10),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.signOutAlt,
                          color: Colors.white,
                          size: 22,
                        ),
                        onPressed: null,
                      )),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  @override
  _Feedback createState() => _Feedback();
}

class _Feedback extends State<FeedbackPage> {
  TextEditingController details = TextEditingController();
  String email = FirebaseAuth.instance.currentUser.email;

  upload() async {
    await FirebaseFirestore.instance.collection('Feedback').add({
      'User': email,
      'Feedback': details.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Feedback",
          style: GoogleFonts.montserrat(color: Color.fromRGBO(59, 57, 60, 1), fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text("We also welcome your ideas, requests or comments. Please enter your feedback here:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey)),
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: null,
              controller: details,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]),
                ),
                hintText: 'Add feedback...',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'please give detail ';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                upload();
                Fluttertoast.showToast(msg: 'Thanks for your Feedback', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
