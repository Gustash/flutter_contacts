import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';

class ContactDetailsPage extends StatelessWidget {
  final Contact contact;

  ContactDetailsPage(this.contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${contact.firstName} ${contact.lastName}",
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "avatar-${contact.id}",
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            contact.avatarUrl ?? contact.thumbnailUrl
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
