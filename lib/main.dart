import 'package:flutter/material.dart';
import 'package:flutter_contacts/models/contact.dart';
import 'package:flutter_contacts/models/contact_list.dart';
import 'package:flutter_contacts/providers/contact_provider.dart';
import 'package:flutter_contacts/state/contact_bloc.dart';

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
      bottomNavigationBar: _bottomAppBar(contactBloc),
      body: new SafeArea(
        child: new Column(
          children: <Widget>[_header(), _body(contactBloc)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contactBloc.newContact
              .add(NewContact(Contact("3", "Janet", "Doe", "foobar.png")));
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _bottomAppBar(ContactBloc contactBloc) {
    return Material(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      child: BottomAppBar(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Text(
            this.title,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24.0),
          ),
        ),
      ],
    );
  }

  Widget _body(ContactBloc contactBloc) {
    return Expanded(
      child: Center(
        child: StreamBuilder<List<Contact>>(
          stream: contactBloc.contacts,
          builder: (context, snapshot) => ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${snapshot.data[index].firstName} ${snapshot.data[
                            index].lastName}',
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
