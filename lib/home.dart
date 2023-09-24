import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:News_Feed/backend/rss_to_json.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:News_Feed/screens/home/homepage.dart';
import 'package:News_Feed/screens/profile/favourite.dart';
import 'package:News_Feed/screens/profile/profile.dart';
import 'package:News_Feed/screens/profile/settings.dart';
import 'package:News_Feed/screens/search/search.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  String? profile = FirebaseAuth.instance.currentUser?.photoURL;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String, List> newsData = Map<String, List>();
  bool isLoading = true;
  getData() async {
    Future.wait([
      rssToJson('topnews'),
      rssToJson('india-news'),
      rssToJson('cities'),
      rssToJson('world-news'),
      rssToJson('business'),
      rssToJson('sports'),
      rssToJson('cricket'),
      rssToJson('education'),
      rssToJson('entertainment'),
      rssToJson('lifestyle'),
      rssToJson('science'),
      rssToJson('trending'),
      rssToJson('astrology'),
      rssToJson('opinion'),
    ]).then((value) {
      value[0] = [];
      value.forEach((element) {
        value[0].addAll([...element]);
      });
      value[0].shuffle();
      newsData['topnews'] = value[0].sublist(0, 15);
      newsData['india'] = value[1];
      newsData['cities'] = value[2];
      newsData['world'] = value[3];
      newsData['business'] = value[4];
      newsData['sports'] = value[5];
      newsData['cricket'] = value[6];
      newsData['education'] = value[7];
      newsData['entertainment'] = value[8];
      newsData['lifestyle'] = value[9];
      newsData['science'] = value[10];
      newsData['its-viral'] = value[11];
      newsData['astrology'] = value[12];
      newsData['opinion'] = value[13];

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/menu.svg",
                    height: 50,
                    width: 34,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              SizedBox(
                width: 80,
              ),
              Text(
                'NEWS',
                style: TextStyle(
                    fontFamily: "Stencil",
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'FEED',
                style: TextStyle(
                    fontFamily: "Stencil",
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Spacer(),
              Container(
                height: 170,
                padding: EdgeInsets.only(top: 20),
                child: Container(
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
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(profile == null
                            ? "https://i.stack.imgur.com/l60Hf.png"
                            : profile.toString())),
                  ),
                  // child: CircleAvatar(
                  //   backgroundImage: NetworkImage(profile == null
                  //       ? "https://i.stack.imgur.com/l60Hf.png"
                  //       : profile.toString()),
                  //   radius: 100.0,
                  // ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsTwoPage()));
                },
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Favourites',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  GoogleSignIn().disconnect();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                  Fluttertoast.showToast(
                      msg: 'Logged out successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM);
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'v1.0',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
      body: isLoading
          ? SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Top News Updates",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Times",
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            child: Row(
                              children: [
                                Skeleton(
                                  style: SkeletonStyle.text,
                                  textColor: Colors.grey,
                                  height: 14,
                                  width: 100,
                                ),
                                Spacer(),
                                Skeleton(
                                  style: SkeletonStyle.text,
                                  textColor: Colors.grey,
                                  height: 14,
                                  width: 50,
                                ),
                                Spacer(),
                                Skeleton(
                                  style: SkeletonStyle.text,
                                  textColor: Colors.grey,
                                  height: 14,
                                  width: 50,
                                ),
                                Spacer(),
                                Skeleton(
                                  style: SkeletonStyle.text,
                                  textColor: Colors.grey,
                                  height: 14,
                                  width: 80,
                                ),
                                Spacer(),
                                Skeleton(
                                  style: SkeletonStyle.text,
                                  textColor: Colors.grey,
                                  height: 14,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 203,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 14,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 150, bottom: 10),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 14,
                              width: 220,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 14,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 203,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 14,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 120, bottom: 10),
                            child: Skeleton(
                              style: SkeletonStyle.text,
                              textColor: Colors.grey,
                              height: 14,
                              width: 250,
                            ),
                          ),
                          Skeleton(
                            style: SkeletonStyle.text,
                            textColor: Colors.grey,
                            height: 14,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : <Widget>[
              HomePage(
                newsData: newsData,
              ),
              Search(
                newsData: newsData,
              ),
              Favourite(),
              // ProfilePage()
            ][currentIndex],
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          // barStyle: BubbleBarStyle.vertical,
          barStyle: BubbleBarStyle.vertical,
          bubbleFillStyle: BubbleFillStyle.fill,
          // bubbleFillStyle: BubbleFillStyle.outlined,
          opacity: 0.3,
        ),
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        items: [
          BottomBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black54,
              ),
              selectedIcon: Icon(
                Icons.home_outlined,
                color: Colors.blue,
              ),
              title: Text("Home")),
          BottomBarItem(
              backgroundColor: Colors.blue,
              icon: SvgPicture.asset(
                'assets/icons/grid.svg',
                // width: 21,
                color: Colors.black54,
                height: 21,
              ),
              selectedIcon: SvgPicture.asset(
                'assets/icons/grid.svg',
                // width: 21,
                color: Colors.blue,
              ),
              title: Text("Categories")),
          BottomBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.favorite_border,
                size: 30,
                color: Colors.black54,
              ),
              selectedIcon: Icon(
                Icons.favorite_border,
                size: 30,
                color: Colors.blue,
              ),
              title: Text("Favourites")),
          // BottomBarItem(
          //     backgroundColor: Colors.blue,
          //     icon: Container(
          //       height: 24,
          //       width: 24,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         image: DecorationImage(
          //             image: NetworkImage(profile == null
          //                 ? "https://i.stack.imgur.com/l60Hf.png"
          //                 : profile.toString())),
          //         boxShadow: [
          //           BoxShadow(
          //               color: Color(0x5c000000),
          //               offset: Offset(0, 1),
          //               blurRadius: 5)
          //         ],
          //       ),
          //     ),
          //     title: Text("Profile")),
        ],
      ),
    );
  }
}
