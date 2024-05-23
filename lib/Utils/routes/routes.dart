import 'package:flutter/material.dart';
import 'package:wallet_admin/Utils/routes/routes_name.dart';
import 'package:wallet_admin/view/my_details.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.mydetails:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MyDetails());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No routes define'),
            ),
          );
        });
    }
  }
}
