import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:News_Feed/reusable/custom_cards.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String? email = FirebaseAuth.instance.currentUser?.email;
  int? length;
  var imageUrl, title, subtitle, time, link, topic, story;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(email ?? '')
                      .orderBy('currentdate', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 70),
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator())),
                            ],
                          ),
                        ),
                      );
                    }
                    length = snapshot.data?.docs.length;
                    if (length == 0) {
                      return Center(
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Color(0xFFfddad9),
                                    size: 150,
                                  )),
                              Text(
                                'No Favourite',
                                style: GoogleFonts.montserrat(
                                    color: Color.fromRGBO(59, 57, 60, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Your favourite articles will be displayed here.',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Color(0xFFfddad9),
                                    size: 150,
                                  )),
                              Text(
                                'No Favourite',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Your favourite articles will be displayed here.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        itemCount: length,
                        itemBuilder: (context, i) {
                          link = snapshot.data?.docs[i]["Link"].toString();
                          title = snapshot.data?.docs[i]["Title"].toString();
                          time = snapshot.data?.docs[i]["Time"].toString();
                          subtitle =
                              snapshot.data?.docs[i]["Subtitle"].toString();
                          imageUrl = snapshot.data?.docs[i]["Image"].toString();
                          topic = snapshot.data?.docs[i]["Topic"].toString();
                          story = snapshot.data?.docs[i]["Story"].toString();
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Favouriteitem(
                                          link: snapshot.data?.docs[i]["Link"]
                                              .toString(),
                                          title: snapshot.data?.docs[i]["Title"]
                                              .toString(),
                                          time: snapshot.data?.docs[i]["Time"]
                                              .toString(),
                                          subtitle: snapshot
                                              .data?.docs[i]["Subtitle"]
                                              .toString(),
                                          imageUrl: snapshot
                                              .data?.docs[i]["Image"]
                                              .toString(),
                                          topic: snapshot.data?.docs[i]["Topic"]
                                              .toString(),
                                          story: snapshot.data?.docs[i]["Story"]
                                              .toString(),
                                          id: snapshot.data?.docs[i].id,
                                        )),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Favouriteitem(
                                                  link: snapshot
                                                      .data?.docs[i]["Link"]
                                                      .toString(),
                                                  title: snapshot
                                                      .data?.docs[i]["Title"]
                                                      .toString(),
                                                  time: snapshot
                                                      .data?.docs[i]["Time"]
                                                      .toString(),
                                                  subtitle: snapshot
                                                      .data?.docs[i]["Subtitle"]
                                                      .toString(),
                                                  imageUrl: snapshot
                                                      .data?.docs[i]["Image"]
                                                      .toString(),
                                                  topic: snapshot
                                                      .data?.docs[i]["Topic"]
                                                      .toString(),
                                                  story: snapshot
                                                      .data?.docs[i]["Story"]
                                                      .toString(),
                                                  id: snapshot.data?.docs[i].id,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      height: 203,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Color(0xff707070),
                                          width: 1,
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.fill),
                                      ),
                                      /* child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.black.withOpacity(0.33),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Center(
                          child: Text(
                            subtitle,
                            style: TextStyle(fontFamily: "Avenir", fontSize: 16, color: Colors.white),
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                    ],
                  ),
                ), */
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(time,
                                      style: TextStyle(
                                          fontFamily: "Times",
                                          fontSize: 13,
                                          color: Color(0xff8a8989))),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(title,
                                      style: TextStyle(
                                          fontFamily: "League",
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold)),
                                  Divider(
                                    thickness: 2,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }))
        ],
      ),
    ));
  }
}
