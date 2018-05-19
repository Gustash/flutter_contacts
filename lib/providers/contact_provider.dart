import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/state/contact_bloc.dart';
import 'package:flutter_contacts/api/random_user_api.dart';

class ContactProvider extends InheritedWidget {
  final ContactBloc contactBloc;

  ContactProvider({
    Key key,
    ContactBloc contactBloc,
    Widget child,
  })  : contactBloc = contactBloc ?? ContactBloc(RandomUserApi()),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContactBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ContactProvider) as ContactProvider)
          .contactBloc;
}