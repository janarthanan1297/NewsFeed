import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ten_news/model/categories_model.dart';
import '../../reusable/custom_cards.dart';

class Search extends StatefulWidget {
  final Map<String, List> newsData;

  const Search({Key key, this.newsData}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Map<String, List> _newsData = Map<String, List>();
  TextEditingController _searchController = TextEditingController();
  FocusNode searchNode;
  bool isCategory = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _newsData = Map.from(widget.newsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      children: <Widget>[
        SizedBox(
          height: 17,
        ),
        if (_searchController.text.isEmpty) ...[
          Text("Top Categories",
              style: TextStyle(
                fontFamily: "Avenir",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 149 / 114,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Category(
                                title: categories[index].name,
                                imageUrl: categories[index].imageUrl,
                                value: categories[index].imageUrl.toString().split("/")[3].split(".")[0].replaceAll("_", "-"),
                                index: index,
                                newsData: widget.newsData,
                              )));
                },
                child: CategoriesCard(
                  category: categories[index].name,
                  imageUrl: categories[index].imageUrl,
                ),
              );
            }),
          ),
          SizedBox(
            height: 40,
          ),
          Text("Browse All",
              style: TextStyle(
                fontFamily: "Avenir",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 149 / 114,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(categories.length - 4, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Category(
                                title: categories[index + 4].name,
                                imageUrl: categories[index + 4].imageUrl,
                                value: categories[index + 4].imageUrl.toString().split("/")[3].split(".")[0].replaceAll("_", "-"),
                                index: index + 4,
                                newsData: widget.newsData,
                              )));
                },
                child: CategoriesCard(
                  category: categories[index + 4].name,
                  imageUrl: categories[index + 4].imageUrl,
                ),
              );
            }),
          ),
        ] else ...[
          if (_searchController.text.isNotEmpty) ...[
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Search Result for ",
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.55),
                  )),
              TextSpan(
                  text: _searchController.text,
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1fa2f9),
                  )),
            ])),
            SizedBox(
              height: 17,
            ),
            Column(
              children: List.generate(10, (index) {
                return SearchCard();
              }),
            )
          ] else ...[
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "No Result Found for ",
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.55),
                  )),
              TextSpan(
                  text: _searchController.text,
                  style: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1fa2f9),
                  )),
            ])),
            SizedBox(
              height: 120,
            ),
            SvgPicture.asset(
              "assets/icons/search.svg",
              color: Color(0xff737373).withOpacity(.6),
              height: 159,
              width: 159,
            ),
            SizedBox(
              height: 59,
            ),
            Text(
              "no Result found",
              style: TextStyle(
                fontFamily: "Avenir",
                fontSize: 16,
                color: Color(0xffbebebe),
              ),
              textAlign: TextAlign.center,
            )
          ]
        ]
      ],
    );
  }
}

class Category extends StatefulWidget {
  final imageUrl, title, index, value;
  final Map<String, List> newsData;
  Category({Key key, this.imageUrl, this.title, this.index, this.value, this.newsData}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var response;
  var title;
  var key;
  var item;
  Map<String, List> _newsData = Map<String, List>();
  GlobalKey<RefreshIndicatorState> refreshKey;

  List<Element> discription;

  @override
  void initState() {
    super.initState();
    print(widget.value);
    setState(() {
      _newsData = Map.from(widget.newsData);
      key = widget.value;
    });
  }

  Future<Null> refreshList() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Category(
                  title: widget.title,
                  imageUrl: widget.imageUrl,
                  index: widget.index,
                  value: widget.value,
                  newsData: _newsData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    item = _newsData[key]?.length ?? 0;
    print(item);
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                            image: AssetImage(widget.imageUrl),
                            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.overlay),
                            fit: BoxFit.cover,
                            alignment: Alignment.center),
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
                  Positioned(
                      top: 180,
                      left: 30,
                      child: Container(
                        padding: EdgeInsets.all(05),
                        decoration: BoxDecoration(
                            color: Colors.black45, border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 34,
                            )),
                      )),
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: RefreshIndicator(
                onRefresh: refreshList,
                key: refreshKey,
                child: (item <= 1)
                    ? Container()
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(),
                        itemBuilder: (context, i) {
                          String time = _newsData[key][i]['pubDate']['__cdata'];
                          /* DateTime timeIST = DateTime.parse(time);
                          timeIST = timeIST.add(Duration(hours: 5)).add(Duration(minutes: 30));
 */
                          return HomePageCard(
                            title: _newsData[key][i]['title']['__cdata'].replaceAll(r"\'", ''),
                            subtitle: _newsData[key][i]['description']['__cdata'],
                            time: time.substring(5, 22),
                            imageUrl: _newsData[key][i]['media\$content']['url'],
                            link: _newsData[key][i]['link']['__cdata'],
                            topic: widget.title,
                          );
                        },
                        itemCount: _newsData[key]?.length ?? 0,
                      ),
              ),
            )),
          ])),
    );
  }
}
