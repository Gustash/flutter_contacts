import 'package:flutter_contacts/models/contact.dart';

class ContactList {
  final List<Contact> contacts;

  ContactList(this.contacts);

  ContactList.empty() : contacts = [];

  ContactList.sample() : contacts = [
    Contact("1", "John", "Doe", "stuff.jpg"),
    Contact("2", "Jane", "Doe", "things.jpg")
  ];

  void add(Contact contact) {
    contacts.add(contact);
  }

  void reset(List<Contact> contacts) {
    this.contacts.replaceRange(0, contactCount, contacts);
  }

  int get contactCount => contacts.length;
}