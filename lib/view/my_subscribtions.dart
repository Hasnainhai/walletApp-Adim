import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/components/vertical_spacing.dart';
import 'package:wallet_admin/res/keys.dart';
import 'package:wallet_admin/res/responsive.dart';
import 'package:wallet_admin/view/slide_menu.dart';
import 'package:wallet_admin/view/widgets/add_field.dart';

import '../res/components/roundedButton.dart';

class MySubscribtions extends StatelessWidget {
  const MySubscribtions({super.key});

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
                                  ontap: () {
                                    showCustomDialog(context);
                                  },
                                  title: 'Add Subspcribtions')
                            ],
                          ),
                          const VerticalSpeacing(30.0),
                          //Subscribtions
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
                                        'subscribtions',
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
                                      children: [
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
                                                    'month of subscribtions',
                                                    style: GoogleFonts.getFont(
                                                      "Poppins",
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.textColor1,
                                                      ),
                                                    ),
                                                  ),
                                                  const VerticalSpeacing(10.0),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          AppColor.primaryColor,
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      '6 months',
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .whiteColor),
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
                                                    '6 month payment',
                                                    style: GoogleFonts.getFont(
                                                      "Poppins",
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.textColor1,
                                                      ),
                                                    ),
                                                  ),
                                                  const VerticalSpeacing(10.0),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          AppColor.primaryColor,
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      '₹200',
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .whiteColor),
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
                                                    'expire date',
                                                    style: GoogleFonts.getFont(
                                                      "Poppins",
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.textColor1,
                                                      ),
                                                    ),
                                                  ),
                                                  const VerticalSpeacing(10.0),
                                                  Text(
                                                    '25/06/2025',
                                                    style: GoogleFonts.getFont(
                                                      "Poppins",
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.textColor1,
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
                                ],
                              ),
                            ),
                          ),
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

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xffF8F8F8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SizedBox(
            width: 446.77,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Subscriptions details',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const AddField(
                    title: "Duration of subscriptions",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AddField(
                    title: "Subscriptions Charges",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textColor1,
                          ),
                        ),
                      ),
                      Container(
                        height: 38,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors
                                .grey, // Replace with your AppColor.borderColor
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: AppColor.textColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const AddField(
                  //   title: "Account Number",
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 38,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.primaryColor),
                      child: Center(
                        child: Text(
                          'Add Subscriptions',
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
