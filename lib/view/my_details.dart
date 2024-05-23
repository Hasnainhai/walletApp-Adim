import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/components/vertical_spacing.dart';
import 'package:wallet_admin/res/keys.dart';
import 'package:wallet_admin/res/responsive.dart';
import 'package:wallet_admin/view/slide_menu.dart';

import '../res/components/roundedButton.dart';

class MyDetails extends StatelessWidget {
  const MyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getAddProductscaffoldKey,
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
                  Expanded(
                    flex: 5,
                    // It takes the remaining part of the screen
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpeacing(30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RoundedButton(
                                  ontap: () {}, title: 'Add Bank Details')
                            ],
                          ),
                          const VerticalSpeacing(30.0),
                          //my bank details section
                          Container(
                            height: 218,
                            color: AppColor.whiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'My Bank Account Details',
                                        style: GoogleFonts.getFont(
                                          "Poppins",
                                          textStyle: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.textColor1,
                                          ),
                                        ),
                                      ),
                                      RoundedButton(
                                        ontap: () {},
                                        title: 'Edit details',
                                      ),
                                    ],
                                  ),
                                  const VerticalSpeacing(40.0),
                                  SizedBox(
                                    width: 800,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'bank accounts',
                                              style: GoogleFonts.getFont(
                                                "Poppins",
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.textColor1,
                                                ),
                                              ),
                                            ),
                                            const VerticalSpeacing(10.0),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.primaryColor,
                                                ),
                                                onPressed: () {},
                                                child: const Text(
                                                  'Upi',
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.whiteColor),
                                                ))
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Account number',
                                              style: GoogleFonts.getFont(
                                                "Poppins",
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.textColor1,
                                                ),
                                              ),
                                            ),
                                            const VerticalSpeacing(10.0),
                                            Text(
                                              '7150105931624',
                                              style: GoogleFonts.getFont(
                                                "Poppins",
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.textColor1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Bank Zip',
                                              style: GoogleFonts.getFont(
                                                "Poppins",
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.textColor1,
                                                ),
                                              ),
                                            ),
                                            const VerticalSpeacing(10.0),
                                            Text(
                                              '938493',
                                              style: GoogleFonts.getFont(
                                                "Poppins",
                                                textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.textColor1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const VerticalSpeacing(16.0),
                        ],
                      ),
                    ),
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
