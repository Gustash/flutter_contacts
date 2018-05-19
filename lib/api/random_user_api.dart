import 'dart:async';
import 'dart:convert';

import 'package:flutter_contacts/api/api.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:http/http.dart' as http;

class RandomUserApi implements Api{
  final String baseUrl = 'https://randomuser.me/api/';
  final int numOfResults;

  RandomUserApi({ this.numOfResults });

  String _formatUrl() => "${baseUrl}?results=${numOfResults ?? 10}";

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  
  @override
  Future<List<Contact>> fetchAll() async {
    http.Response res =
      await http.get(Uri.parse(_formatUrl()));
    var decoded = await json.decode(res.body);

    if (decoded['results'] == null) return List<Contact>();

    List<Contact> contacts = List<Contact>();

    for (var json in decoded['results']) {
      String id = "${json['id']['name'] ?? "no-name"}-${json['id']['value'] ?? 'no-value'}";
      String first = _capitalize(json['name']['first']);
      String last = _capitalize(json['name']['last']);
      String avatar = json['picture']['thumbnail'];

      contacts.add(Contact(id, first, last, avatar));
    }

    return contacts;
  }
}