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
        child: Column(
          children: [
            SizedBox(
              height: 64,
              child: Header(fct: () {}),
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    const SizedBox(
                      width: 250, // Set the width of the side menu
                      child: SideMenu(),
                    ),
                  const Expanded(
                    // It takes the remaining part of the screen
                    child: DashboardScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
