import 'dart:async';
import 'dart:convert';

import 'package:flutter_contacts/api/api.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class RandomUserApi implements Api{
  final String baseUrl = 'https://randomuser.me/api/';
  final int numOfResults;

  RandomUserApi({ this.numOfResults });

  String _formatUrl() => "$baseUrl?results=${numOfResults ?? 10}";

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  
  @override
  Future<List<Contact>> fetchAll() async {
    http.Response res =
      await http.get(Uri.parse(_formatUrl()));
    var decoded = await json.decode(res.body);

    if (decoded['results'] == null) return List<Contact>();

    List<Contact> contacts = List<Contact>();

    for (var json in decoded['results']) {
      String id = Uuid().v4();
      String first = _capitalize(json['name']['first']);
      String last = _capitalize(json['name']['last']);
      String thumbnail = json['picture']['thumbnail'];
      String avatar = json['picture']['large'];
      String email = json['email'];
      String phone = json['cell'];

      contacts.add(
          Contact(
            id,
            first,
            last,
            thumbnail,
            email: email,
            phone: phone,
            avatarUrl: avatar
          )
      );
    }

    return contacts;
  }
}