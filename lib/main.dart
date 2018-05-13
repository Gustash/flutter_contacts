import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/models/contact_list.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';
import 'package:flutter_contacts/state/contact_bloc.dart';
import 'package:flutter_contacts/widgets/contact_list_view.dart';
import 'package:flutter_contacts/widgets/header.dart';
import 'package:flutter_contacts/widgets/themed_bottom_app_bar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContactProvider(
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: _buildTheme(),
        home: new MyHomePage(title: 'Contacts'),
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.blue,
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final contactBloc = ContactProvider.of(context);
    final sampleContacts = ContactList.sample().contacts;
    contactBloc.fetchContacts.add(FetchContacts(sampleContacts));

    return new Scaffold(
      bottomNavigationBar: ThemedBottomAppBar(),
      body: new SafeArea(
        child: new Column(
          children: <Widget>[
            Header(
              title: this.title,
            ),
            Expanded(
              child: ContactListView()
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contactBloc.newContact.add(
              NewContact(
                  Contact("3", "Janet", "Doe", "foobar.png")
              )
          );
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
