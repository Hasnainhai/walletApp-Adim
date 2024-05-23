import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/custom_searchField.dart';
import 'package:wallet_admin/res/const.dart';

import '../../view/widgets/notification_icon_badget.dart';
import '../responsive.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.fct,
  });

  final Function fct;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
          horizontal: 30.0), // Add padding to left and right
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                fct();
              },
            ),
          if (Responsive.isDesktop(context))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Dashboard",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          if (Responsive.isDesktop(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                fillColor: Theme.of(context).cardColor,
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding * 0.75),
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          const NotificationIconWithBadge(notificationCount: 5),
          const SizedBox(width: 64.0),
          const Text(
            'Hi, John Doe',
            style: TextStyle(
                color: AppColor.textColor1,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(width: 12.0),
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
          ),
        ],
      ),
    );
  }
}
