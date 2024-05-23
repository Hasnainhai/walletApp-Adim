// ignore: file_names
import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.ontap,
    required this.title,
  });
  final Function ontap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ontap();
      },
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(194, 44),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 0,
          backgroundColor: AppColor.primaryColor),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
