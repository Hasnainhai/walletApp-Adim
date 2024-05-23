import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/view/dashboard_screen.dart';
import 'package:wallet_admin/view/slide_menu.dart';

import '../res/keys.dart';
import '../res/responsive.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getScaffoldKey,
      // key: context.read<MenuController>().getScaffoldKey,
      // drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
               Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: Column(
                  children: [
                    Header(fct: (){}),
                    SideMenu(),
                  ],
                ),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
