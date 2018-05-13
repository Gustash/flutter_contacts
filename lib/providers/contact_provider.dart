import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/state/contact_bloc.dart';

class ContactProvider extends InheritedWidget {
  final ContactBloc contactBloc;

  ContactProvider({
    Key key,
    ContactBloc contactBloc,
    Widget child,
  })  : contactBloc = contactBloc ?? ContactBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContactBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ContactProvider) as ContactProvider)
          .contactBloc;
}