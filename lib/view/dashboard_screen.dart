import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/const.dart';
import 'package:wallet_admin/view/widgets/dashboard_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _totalUserCount = 0;
  int _blockedUserCount = 0;
  double _totalFunds = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      QuerySnapshot totalUsersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      QuerySnapshot blockedUsersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('isBlock', isEqualTo: true)
          .get();

      double totalFunds = 0.0;
      for (var doc in totalUsersSnapshot.docs) {
        // Ensure the balance is treated as a number
        totalFunds += (doc['balance'] as num).toDouble();
      }

      setState(() {
        _totalUserCount = totalUsersSnapshot.docs.length;
        _blockedUserCount = blockedUsersSnapshot.docs.length;
        _totalFunds = totalFunds;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Container(
        height: 232,
        color: AppColor.whiteColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DashboardWidget(
                  icon: Icons.people_outline_outlined,
                  iconColor: AppColor.textColor1,
                  title: _totalUserCount.toString(),
                  subtitle: 'Total Users'),
              DashboardWidget(
                  icon: Icons.people_outline_outlined,
                  iconColor: AppColor.textColor1,
                  title: _blockedUserCount.toString(),
                  subtitle: 'Block Users'),
              DashboardWidget(
                  icon: Icons.currency_rupee_outlined,
                  iconColor: AppColor.primaryColor,
                  title: '₹$_totalFunds',
                  subtitle: 'Total Funds'),
              const DashboardWidget(
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
