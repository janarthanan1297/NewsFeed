import 'dart:io';
import 'package:News_Feed/home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:News_Feed/screens/landing/forgotpassword.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  String? username = FirebaseAuth.instance.currentUser?.displayName;
  ValueNotifier<String> profile =
      ValueNotifier<String>(FirebaseAuth.instance.currentUser?.photoURL ?? '');
  String? email = FirebaseAuth.instance.currentUser?.email;
  File? file;

  Future selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path ?? ""));
    if (file == null) return;
    setState(() async {
      //isLoading = true;
      final Reference storageReference =
          FirebaseStorage.instance.ref().child("$username/profile");
      await storageReference.putFile(file!).whenComplete(() async {
        await storageReference.getDownloadURL().then((value) async {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            // var result = await FirebaseFirestore.instance
            //     .collection("timeline")
            //     .where("email", isEqualTo: "$email")
            //     .get();
            // result.docs.forEach((res) async {
            //   await FirebaseFirestore.instance
            //       .collection('timeline')
            //       .doc(res['id'])
            //       .update({'profile': value});
            //   await FirebaseFirestore.instance
            //       .collection('$email')
            //       .doc(res.id)
            //       .update({'profile': value});
            // });
            // var result2 = await FirebaseFirestore.instance
            //     .collection("$email")
            //     .where("email", isEqualTo: "$email")
            //     .get();
            // result2.docs.forEach((res2) async {
            //   await FirebaseFirestore.instance
            //       .collection('$email')
            //       .doc(res2.id)
            //       .update({'profile': value});
            // });
            await user.updatePhotoURL(value);
            profile.value = value;
            Fluttertoast.showToast(
                msg: 'Profile Updated',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
                (Route<dynamic> route) => false);
            /*  Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyNavigationBar()),
              ); */
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Profile",
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Stack(
                  children: [
                    // Container(
                    //   width: 130,
                    //   height: 130,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //           width: 4,
                    //           color: Theme.of(context).scaffoldBackgroundColor),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             spreadRadius: 2,
                    //             blurRadius: 10,
                    //             color: Colors.black.withOpacity(0.1),
                    //             offset: Offset(0, 10))
                    //       ],
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: NetworkImage(profile == null
                    //               ? "https://i.stack.imgur.com/l60Hf.png"
                    //               : profile.toString()))),
                    // ),
                    Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          // boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: Offset(0, 10))],
                        ),
                        child: ValueListenableBuilder(
                            valueListenable: profile,
                            builder: (context, String profile, child) {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(profile == null
                                    ? "https://i.stack.imgur.com/l60Hf.png"
                                    : profile),
                                radius: 35,
                              );
                            })),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            selectFile();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              buildTextField("Full Name", username ?? '', false),
              buildTextField("E-mail", email ?? '', false),
              // buildTextField("Password", "********", true),
              // ListTile(
              //   contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
              //   title: Text(
              //     "Reset Password",
              //     style: TextStyle(
              //       fontFamily: "Times",
              //       fontSize: 22,
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              //   leading: CircleAvatar(
              //       backgroundColor: Colors.blue,
              //       child: IconButton(
              //         icon: Icon(Icons.lock_open, color: Colors.white),
              //         onPressed: null,
              //       )),
              //   trailing: Icon(
              //     Icons.keyboard_arrow_right,
              //     color: Colors.grey,
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ForgotPassword()),
              //     );
              //   },
              // ),
              // Divider(thickness: 1, color: Colors.grey),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextField(
        enabled: false,
        enableInteractiveSelection: false,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontFamily: "Times",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  String? username = FirebaseAuth.instance.currentUser?.displayName;
  String? profile = FirebaseAuth.instance.currentUser?.photoURL;
  String? email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Profile",
                style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(profile == null
                                  ? "https://i.stack.imgur.com/l60Hf.png"
                                  : profile.toString()))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", username ?? '', false),
              buildTextField("E-mail", email ?? '', false),
              buildTextField("Password", "********", true),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                title: Text(
                  "Reset Password",
                  style: TextStyle(
                    fontFamily: "Times",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: Icon(Icons.lock_open, color: Colors.white),
                      onPressed: null,
                    )),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
              ),
              Divider(thickness: 1, color: Colors.grey),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextField(
        enabled: false,
        enableInteractiveSelection: false,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
              fontFamily: "Times",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
      ),
    );
  }
}
