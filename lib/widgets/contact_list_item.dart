import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  ContactListItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: _buildUserAvatar(),
            title: Text('${contact.firstName} ${contact.lastName}'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    if (contact.avatarUrl == null) return CircleAvatar();
    else return CircleAvatar(
      backgroundImage: NetworkImage(contact.avatarUrl),
    );
  }
}
