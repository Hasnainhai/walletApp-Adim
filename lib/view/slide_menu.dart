import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/view/deposite.dart';
import 'package:wallet_admin/view/increase_payment.dart';
import 'package:wallet_admin/view/mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_admin/view/my_details.dart';
import 'package:wallet_admin/view/my_subscribtions.dart';
import 'package:wallet_admin/view/user_screen.dart';
import 'package:wallet_admin/view/users_subscribtions.dart';
import 'package:wallet_admin/view/withdraw_users.dart';

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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UsersScreen(),
                ),
              );
            },
            icon: Icons.group_outlined,
          ),
          DrawerListTile(
            title: "My Details",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyDetails(),
                ),
              );
            },
            icon: Icons.data_exploration_outlined,
          ),
          DrawerListTile(
            title: "WithDraw",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WithdrawUsers(),
                ),
              );
            },
            icon: Icons.currency_exchange_outlined,
          ),
          DrawerListTile(
            title: "Deposite",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Deposite(),
                ),
              );
            },
            icon: Icons.payment_outlined,
          ),
          DrawerListTile(
            title: "User Subscribtions",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UsersSubscribtions(),
                ),
              );
            },
            icon: Icons.subscript_outlined,
          ),
          DrawerListTile(
            title: "My Subscribtions",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MySubscribtions(),
                ),
              );
            },
            icon: Icons.subscript_outlined,
          ),
          DrawerListTile(
            title: "Increase Payment",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const IncreasePayment(),
                ),
              );
            },
            icon: Icons.format_indent_increase_sharp,
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
