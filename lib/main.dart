import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';
import 'package:flutter_contacts/state/contact_bloc.dart';
import 'package:flutter_contacts/widgets/contact_list_view.dart';
import 'package:flutter_contacts/widgets/header.dart';
import 'package:flutter_contacts/widgets/themed_bottom_app_bar.dart';
import 'package:flutter_contacts/api/random_user_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContactProvider(
      contactBloc: ContactBloc(RandomUserApi(
        numOfResults: 30
      )),
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
  final String title;

  MyHomePage({ this.title });

  @override
  Widget build(BuildContext context) {
    final contactBloc = ContactProvider.of(context);
    contactBloc.fetchAllFromApi();

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
          contactBloc.addContacts.add(
              AddContacts.single(
                  Contact("3", "Janette", "Doette", "foobar.png")
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
