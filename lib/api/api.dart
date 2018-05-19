import 'dart:async';

import 'package:flutter_contacts/models/contact.dart';

abstract class Api {
  Future<List<Contact>> fetchAll();
}