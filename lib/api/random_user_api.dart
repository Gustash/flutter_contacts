import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_contacts/api/api.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class RandomUserApi implements Api{
  final String seed;
  final String baseUrl = 'https://randomuser.me/api/';
  final int numOfResults;

  RandomUserApi({ this.numOfResults, this.seed }) {
    if (seed != null && seed != '') {
      SharedPreferences.getInstance()
          .then((prefs) => prefs.setString('random_user_seed', seed));
    }
  }

  Future<String> _getSeed() async {
    if (seed != null && seed != '') return seed;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedSeed = prefs.getString('random_user_seed');
    if (storedSeed != null) return storedSeed;

    String randomSeed = Uuid().v4();
    await prefs.setString('random_user_seed', randomSeed);
    return randomSeed;
  }

  Future<String> _formatUrl() async =>
      "$baseUrl?results=${numOfResults ?? 10}&seed=${await _getSeed()}";

  String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  
  @override
  Future<List<Contact>> fetchAll() async {
    http.Response res =
      await http.get(Uri.parse(await _formatUrl()));
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