import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/pages/contact_details_page.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  ContactListItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Hero(
              tag: 'avatar-${contact.id}',
              child: _buildUserAvatar()
            ),
            title: Text('${contact.firstName} ${contact.lastName}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactDetailsPage(contact),
                )
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    Widget image;
    if (Uri.parse(contact.thumbnailUrl).scheme == '') image = CircleAvatar();
    else image = CircleAvatar(
        backgroundImage: NetworkImage(contact.thumbnailUrl),
      );

    return Material(
      child: image,
    );
  }
}
