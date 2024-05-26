import 'package:flutter/material.dart';
import 'package:wallet_admin/res/components/colors.dart';

class ImageContainer extends StatelessWidget {
  final String imageSlip;
  const ImageContainer({super.key, required this.imageSlip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.borderColor,
            ),
          ),
          child: Image.network(imageSlip),
        ),
      ),
    );
  }
}
