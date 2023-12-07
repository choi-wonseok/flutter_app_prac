// To parse this JSON data, do
//
//     final rrs = rrsFromJson(jsonString);

import 'dart:convert';

Rrs rrsFromJson(String str) => Rrs.fromJson(json.decode(str));

String rrsToJson(Rrs data) => json.encode(data.toJson());

class Rrs {
  Rss rss;

  Rrs({
    required this.rss,
  });

  factory Rrs.fromJson(Map<String, dynamic> json) => Rrs(
    rss: Rss.fromJson(json["rss"]),
  );

  Map<String, dynamic> toJson() => {
    "rss": rss.toJson(),
  };
}

class Rss {
  Channel channel;

  Rss({
    required this.channel,
  });

  factory Rss.fromJson(Map<String, dynamic> json) => Rss(
    channel: Channel.fromJson(json["channel"]),
  );

  Map<String, dynamic> toJson() => {
    "channel": channel.toJson(),
  };
}

class Channel {
  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Item> items;

  Channel({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    lastBuildDate: json["lastBuildDate"],
    total: json["total"],
    start: json["start"],
    display: json["display"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lastBuildDate": lastBuildDate,
    "total": total,
    "start": start,
    "display": display,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String title;
  String link;
  String category;
  String description;
  String telephone;
  String address;
  String roadAddress;
  String mapx;
  String mapy;

  Item({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    title: json["title"],
    link: json["link"],
    category: json["category"],
    description: json["description"],
    telephone: json["telephone"],
    address: json["address"],
    roadAddress: json["roadAddress"],
    mapx: json["mapx"],
    mapy: json["mapy"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "category": category,
    "description": description,
    "telephone": telephone,
    "address": address,
    "roadAddress": roadAddress,
    "mapx": mapx,
    "mapy": mapy,
  };
}