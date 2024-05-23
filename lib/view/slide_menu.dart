import 'package:flutter/material.dart';
import 'package:wallet_admin/view/mainScreen.dart';

import '../res/components/textWidget.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/groceries.png",
            ),
          ),
          DrawerListTile(
            title: "Main",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            icon: Icons.home_filled,
          ),
          DrawerListTile(
            title: "Product",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const AllProducts(),
              //   ),
              // );
            },
            icon: Icons.store,
          ),
          DrawerListTile(
            title: "Popular Packs",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const PopularPacks(),
              //   ),
              // );
            },
            icon: Icons.move_down_outlined,
          ),
          DrawerListTile(
            title: "Fashion",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const FashionView(),
              //   ),
              // );
            },
            icon: Icons.style_outlined,
          ),
          DrawerListTile(
            title: "Orders",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const OrderScreen(),
              //   ),
              // );
            },
            icon: Icons.badge,
          ),
          DrawerListTile(
            title: "Finance",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const FinanceScreen(),
              //   ),
              // );
            },
            icon: Icons.badge,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(0.0), // Adjust the radius as needed
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.badge,
                ),
                const SizedBox(width: 10.0),
                const Expanded(
                  child: Text(
                    'Theme',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          0.0), // Adjust the radius as needed
                      color: Colors.grey, // Use appropriate colors
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Logout",
            press: () {},
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  });

  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: Icon(
          icon,
          size: 18,
          color: Colors.black,
        ),
        title: TextWidget(
          text: title,
          color: Colors.black,
        ));
  }
}
