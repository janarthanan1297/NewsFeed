import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_news/backend/web.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home.dart';

class HomePageCard extends StatelessWidget {
  final imageUrl, title, subtitle, time, link, topic;
  const HomePageCard({
    Key key,
    this.imageUrl = "assets/cardimage.jpg",
    this.topic = "",
    this.title = "Watch: Gameplay for the first 13 games optimised for Xbox Series X",
    this.time = "07 May  07:19",
    this.subtitle = "Microsoft showcased 13 games, with their gameplay trailers, that will come to Xbox Series X with optimisations.",
    this.link =
        "https://www.hindustantimes.com/education/competitive-exams/neet-2021-registration-begins-here-s-how-to-apply-at-ntaneetnicin-101626178496700.html",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Web(link: link, title: title, time: time, subtitle: subtitle, imageUrl: imageUrl, topic: topic)),
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
                      builder: (context) => Web(
                            link: link,
                            title: title,
                            time: time,
                            subtitle: subtitle,
                            imageUrl: imageUrl,
                            topic: topic,
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
                  image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.fill),
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
            Text(time, style: TextStyle(fontFamily: "Times", fontSize: 13, color: Color(0xff8a8989))),
            SizedBox(
              height: 7,
            ),
            Text(title, style: TextStyle(fontFamily: "League", fontSize: 23, fontWeight: FontWeight.bold)),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final imageUrl, category;

  CategoriesCard({
    Key key,
    this.imageUrl,
    this.category,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: 149,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: AssetImage(imageUrl),
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.overlay),
            fit: BoxFit.cover,
            alignment: Alignment.center),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(.1),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final imageUrl, title, date;

  const SearchCard(
      {Key key,
      this.imageUrl = "assets/cardimage.jpg",
      this.title = "Watch: Gameplay for the first 13 games optimised for Xbox Series X",
      this.date = "07 May  07:19"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 29),
      child: Container(
          height: 106,
          child: Row(
            children: <Widget>[
              Container(
                height: 105,
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: "League",
                      fontSize: 14,
                    ),
                    maxLines: 4,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: "Times",
                      fontSize: 13,
                      color: Color(0xff8a8989),
                    ),
                  )
                ],
              ))
            ],
          )),
    );
  }
}

class Web extends StatefulWidget {
  final link, imageUrl, title, subtitle, time, topic;
  Web({Key key, this.link, this.imageUrl, this.subtitle, this.time, this.title, this.topic}) : super(key: key);

  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  var response;
  var jsondata;
  var title;
  DateTime _currentdate = new DateTime.now();
  String email = FirebaseAuth.instance.currentUser.email;
  List<Element> discription;

  fetchdata() async {
    jsondata = await getdata(widget.link);
    //var article = json;
    print(jsondata);
  }

  upload() async {
    await FirebaseFirestore.instance.collection('$email').add({
      'Title': widget.title,
      'Subtitle': widget.subtitle,
      'Time': widget.time,
      'Image': widget.imageUrl,
      'Topic': widget.topic,
      'Link': widget.link,
      'Story': jsondata,
      'currentdate': _currentdate,
    }).then((value) => Fluttertoast.showToast(msg: 'Article added to Favourite', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM));
  }

  @override
  void initState() {
    super.initState();
    fetchdata().whenComplete(() {
      setState(() {});
      print("success");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });

    /* getdata(widget.link).then((details) {
      setState(() {
        _details = details;
      });
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (jsondata == null)
          ? Center(
              child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            ))
          : SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 300,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 35,
                          left: 17,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white54,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                iconSize: 22,
                                color: Colors.black,
                                splashColor: Colors.blue,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[200],
                                border: Border.all(color: Colors.blue[200]),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(05),
                            child: Text(
                              widget.topic,
                              style: TextStyle(
                                fontFamily: "Times",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(),
                            child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.heart,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () {
                                upload();
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidClock,
                                color: Colors.grey,
                                size: 19,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(widget.time, style: TextStyle(fontFamily: "Times", fontSize: 18, color: Color(0xff8a8989))),
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      SelectableText(
                        widget.title,
                        style: TextStyle(
                          fontFamily: "League",
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          selectAll: true,
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        color: Colors.blue,
                        endIndent: 200,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        widget.subtitle + '.',
                        style: TextStyle(fontFamily: "Avenir", fontSize: 19, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.justify,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          selectAll: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => _showimg(context, widget.imageUrl),
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(05),
                            border: Border.all(
                              color: Color(0xff707070),
                              width: 1,
                            ),
                            image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SelectableText(
                        jsondata,
                        style: TextStyle(
                          fontFamily: "Bookman",
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.justify,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          selectAll: true,
                        ),
                      ),
                      Text(
                        "SOURCE:",
                        style: TextStyle(fontFamily: "Bookman", fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 05),
                        child: TextButton(
                          child: Text(
                            widget.link,
                            style: TextStyle(fontFamily: "Times", fontSize: 18, color: Colors.blue),
                            textAlign: TextAlign.justify,
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue[100]),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Webview(
                                          link: widget.link,
                                        )));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ]),
            ),
    );
  }

  void _onImagDownloadButtonPressed(dynamic url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage("$url");
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
    Fluttertoast.showToast(msg: 'Image downloaded', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void _showimg(BuildContext context, dynamic url) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Hero(
                tag: 'my-hero-animation-tag',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 30, right: 15),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white54,
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: IconButton(
                                  icon: Icon(Icons.file_download),
                                  iconSize: 22,
                                  color: Colors.black,
                                  splashColor: Colors.blue,
                                  onPressed: () {
                                    _onImagDownloadButtonPressed(url);
                                  },
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 30, right: 15),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white54,
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  iconSize: 22,
                                  color: Colors.black,
                                  splashColor: Colors.blue,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            )),
                      ],
                    ),
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(05),
                        border: Border.all(
                          color: Color(0xff707070),
                          width: 1,
                        ),
                        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}

class Webview extends StatefulWidget {
  final link;
  Webview({Key key, this.link}) : super(key: key);

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

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
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(
                width: 80,
              ),
              Text(
                'NEWS',
                style: TextStyle(fontFamily: "Stencil", fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Text(
                'FEED',
                style: TextStyle(fontFamily: "Stencil", fontSize: 28, color: Colors.blue, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: WebView(
        initialUrl: widget.link,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        javascriptChannels: <JavascriptChannel>{
          // _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}

class Favouriteitem extends StatefulWidget {
  final link, imageUrl, title, subtitle, time, topic, story, id;
  Favouriteitem({Key key, this.link, this.imageUrl, this.subtitle, this.time, this.title, this.topic, this.story, this.id}) : super(key: key);

  @override
  _FavouriteitemState createState() => _FavouriteitemState();
}

class _FavouriteitemState extends State<Favouriteitem> {
  var response;
  var title;
  String email = FirebaseAuth.instance.currentUser.email;
  List<Element> discription;

  Future showdialog(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext build) => new AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                new ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                      FirebaseFirestore.instance.collection(email).doc(widget.id).delete().then((_) {
                        Fluttertoast.showToast(msg: 'Article removed from Favourites', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
                      });
                    },
                    child: new Text('Ok')),
                new ElevatedButton(onPressed: () => Navigator.pop(context), child: new Text("Cancel"))
              ],
            ));
  }

  @override
  void initState() {
    super.initState();

    /* getdata(widget.link).then((details) {
      setState(() {
        _details = details;
      });
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 300,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  height: 260,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.fill),
                    ),
                  ),
                ),
                Positioned(
                    top: 35,
                    left: 17,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white54,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          iconSize: 22,
                          color: Colors.black,
                          splashColor: Colors.blue,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[200], border: Border.all(color: Colors.blue[200]), borderRadius: BorderRadius.all(Radius.circular(5))),
                      padding: EdgeInsets.all(05),
                      child: Text(
                        widget.topic,
                        style: TextStyle(
                          fontFamily: "Times",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.solidHeart,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () {
                          //upload();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.solidTrashAlt,
                          color: Colors.blue,
                          size: 19,
                        ),
                        onPressed: () {
                          showdialog(context, 'Are you sure you want to remove this article');
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.symmetric(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidClock,
                          color: Colors.grey,
                          size: 19,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.time, style: TextStyle(fontFamily: "Times", fontSize: 18, color: Color(0xff8a8989))),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                  widget.title,
                  style: TextStyle(
                    fontFamily: "League",
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  ),
                ),
                Divider(
                  thickness: 3,
                  color: Colors.blue,
                  endIndent: 200,
                ),
                SizedBox(
                  height: 10,
                ),
                SelectableText(
                  widget.subtitle,
                  style: TextStyle(fontFamily: "Avenir", fontSize: 19, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => _showimg(context, widget.imageUrl),
                  child: Container(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(05),
                      border: Border.all(
                        color: Color(0xff707070),
                        width: 1,
                      ),
                      image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.fill),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SelectableText(
                  widget.story,
                  style: TextStyle(
                    fontFamily: "Bookman",
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                  toolbarOptions: ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  ),
                ),
                Text(
                  "SOURCE:",
                  style: TextStyle(fontFamily: "Bookman", fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 05),
                  child: TextButton(
                    child: Text(
                      widget.link,
                      style: TextStyle(fontFamily: "Times", fontSize: 18, color: Colors.blue),
                      textAlign: TextAlign.justify,
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue[100]),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Webview(
                                    link: widget.link,
                                  )));
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _onImagDownloadButtonPressed(dynamic url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage("$url");
      if (imageId == null) {
        return;
      }

      // ignore: unused_local_variable
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
    Fluttertoast.showToast(msg: 'Image downloaded', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void _showimg(BuildContext context, dynamic url) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Hero(
                tag: 'my-hero-animation-tag',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 30, right: 15),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white54,
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: IconButton(
                                  icon: Icon(Icons.file_download),
                                  iconSize: 22,
                                  color: Colors.black,
                                  splashColor: Colors.blue,
                                  onPressed: () {
                                    _onImagDownloadButtonPressed(url);
                                  },
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 30, right: 15),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white54,
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  iconSize: 22,
                                  color: Colors.black,
                                  splashColor: Colors.blue,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            )),
                      ],
                    ),
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(05),
                        border: Border.all(
                          color: Color(0xff707070),
                          width: 1,
                        ),
                        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
