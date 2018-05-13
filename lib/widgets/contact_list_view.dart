import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';

class ContactListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactBloc = ContactProvider.of(context);

    return StreamBuilder<List<Contact>>(
      stream: contactBloc.contacts,
      builder: (context, snapshot) => ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('${snapshot.data[index].firstName} ${snapshot
                                .data[
                            index].lastName}'),
                  ),
                ],
              ),
            );
          }),
    );
  }
}