// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart';

var response;
var title;

getdata(link) async {
  var client = http.Client();
  response = await client.get(Uri.parse(link));
  Document document = parse(response.body);
  List<Element> discription = document.querySelectorAll('div.detail ');
  List<Map<String, dynamic>> linkMap = [];

  for (var link in discription) {
    linkMap.add({
      'story': link.text,
    });
  }
  final response2 = json.encode(linkMap);
  dynamic data = jsonDecode(response2);
  String rest = data[0]['story']
      .replaceAll('.The', '. \n\nThe')
      .replaceAll('. The', '. \n\nThe')
      .replaceAll('."', '. \n\n"')
      .replaceAll('"\n', '"')
      .replaceAll('+', '')
      .replaceAll(r"\'", '')
      .replaceAll('       View this post on Instagram            ', '');
  //var trim = rest;
  var trim = (rest.lastIndexOf('.') != -1)
      ? rest.substring(0, rest.lastIndexOf(' SHARE THIS ARTICLE ON'))
      : rest;
  //final List<Details> article = rest.map<Details>((json) => Details.fromJson(json)).toList();
  print(trim);
  return trim;
}

List<Details> detailsFromJson(String str) =>
    List<Details>.from(json.decode(str).map((x) => Details.fromJson(x)));
String detailsToJson(List<Details> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Details {
  Details({
    this.story,
  });

  String? story;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        story: json["story"],
      );

  Map<String, dynamic> toJson() => {
        "story": story,
      };
}
