import 'dart:async';

import 'package:flutter_contacts/models/contact_list.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:rxdart/subjects.dart';

class FetchContacts {
  final List<Contact> contacts;

  FetchContacts(this.contacts);
}

class NewContact {
  final Contact contact;

  NewContact(this.contact);
}

class ContactBloc {
  final ContactList _contactList = ContactList.empty();

  final BehaviorSubject<List<Contact>> _contacts =
    BehaviorSubject<List<Contact>>(seedValue: []);
  Stream<List<Contact>> get contacts => _contacts.stream;

//  final BehaviorSubject<int> _contactCount = BehaviorSubject<int>(seedValue: 0);
//  Stream<int> get contactCount => _contactCount.stream;

  final StreamController<FetchContacts> _fetchContactsController =
    StreamController<FetchContacts>();
  Sink<FetchContacts> get fetchContacts => _fetchContactsController.sink;

  final StreamController<NewContact> _newContactController =
  StreamController<NewContact>();

  Sink<NewContact> get newContact => _newContactController.sink;

  ContactBloc() {
    _fetchContactsController.stream.listen((fetched) {
      _contactList.reset(fetched.contacts);
      _contacts.add(_contactList.contacts);
    });

    _newContactController.stream.listen((newContact) {
      _contactList.add(newContact.contact);
      _contacts.add(_contactList.contacts);
    });
  }

  void dispose() {
    _fetchContactsController.close();
    _contacts.close();
  }
}