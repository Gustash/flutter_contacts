import 'dart:async';

import 'package:flutter_contacts/api/api.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:rxdart/subjects.dart';

class AddContacts {
  final bool reset;
  final List<Contact> contacts;

  AddContacts(this.contacts, [this.reset = true]);

  AddContacts.single(Contact contact) :
        contacts = List<Contact>()..add(contact),
        reset = false;
}

class ContactBloc {
  final Api api;

  // Outputs
  final BehaviorSubject<List<Contact>> _contacts =
    BehaviorSubject<List<Contact>>(seedValue: []);
  Stream<List<Contact>> get contacts => _contacts.stream;

  // Inputs
  final StreamController<AddContacts> _addContactsController =
    StreamController<AddContacts>();
  Sink<AddContacts> get addContacts => _addContactsController.sink;

  ContactBloc(this.api) {
    _addContactsController.stream.listen((input) async {
      if (input.reset) {
        _contacts.add(input.contacts);
      } else {
        List<Contact> existingContacts = await contacts.first;
        _contacts.add(existingContacts..addAll(input.contacts));
      }
    });

    fetchAllFromApi();
  }

  Future<Null> fetchAllFromApi() async {
    List<Contact> contacts = await api.fetchAll();
    addContacts.add(AddContacts(contacts));
    return null;
  }

  void dispose() {
    _addContactsController.close();
    _contacts.close();
  }
}