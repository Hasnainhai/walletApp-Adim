import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/const.dart';
import 'package:wallet_admin/view/widgets/dashboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        height: 232,
        color: AppColor.whiteColor,
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DashboardWidget(
                  icon: Icons.people_outline_outlined,
                  iconColor: AppColor.textColor1,
                  title: '100+',
                  subtitle: 'Total Users'),
              DashboardWidget(
                  icon: Icons.people_outline_outlined,
                  iconColor: AppColor.textColor1,
                  title: '99',
                  subtitle: 'Block Users'),
              DashboardWidget(
                  icon: Icons.currency_rupee_outlined,
                  iconColor: AppColor.primaryColor,
                  title: '₹10000',
                  subtitle: 'Total Funds'),
              DashboardWidget(
                  icon: Icons.currency_rupee_outlined,
                  iconColor: AppColor.primaryColor,
                  title: '₹10000',
                  subtitle: 'Total Withdraws'),
            ],
          ),
        ),
      ),
    ));
  }
}
