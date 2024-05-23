import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/view/mainScreen.dart';

import 'package:google_fonts/google_fonts.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        children: [
          DrawerListTile(
            title: "Dashboard",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            icon: Icons.home_outlined,
          ),
          DrawerListTile(
            title: "Users",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const AllProducts(),
              //   ),
              // );
            },
            icon: Icons.group_outlined,
          ),
          DrawerListTile(
            title: "My Details",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const PopularPacks(),
              //   ),
              // );
            },
            icon: Icons.data_exploration_outlined,
          ),
          DrawerListTile(
            title: "WithDraw",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const FashionView(),
              //   ),
              // );
            },
            icon: Icons.currency_exchange_outlined,
          ),
          DrawerListTile(
            title: "Deposite",
            press: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const OrderScreen(),
              //   ),
              // );
            },
            icon: Icons.payment_outlined,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {super.key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.press,
      this.imageIcon,
      this.icon});

  final String title;
  final VoidCallback press;
  final String? imageIcon;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: imageIcon != null
          ? ImageIcon(
              AssetImage(
                imageIcon!,
              ),
              color: AppColor.textColor2,
              size: 20,
            )
          : Icon(
              icon,
              color: AppColor.textColor2,
              size: 20,
            ),
      minLeadingWidth: 40,
      title: Text(
        title,
        style: GoogleFonts.getFont(
          "Poppins",
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.textColor2,
          ),
        ),
      ),
    );
  }
}
