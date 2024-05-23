import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/const.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          // Header(fct: () {}),
        ],
      ),
    ));
  }
}
