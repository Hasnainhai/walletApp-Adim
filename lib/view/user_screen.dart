import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/keys.dart';
import 'package:wallet_admin/res/responsive.dart';
import 'package:wallet_admin/view/slide_menu.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String? _btn2SelectedVal;
  static const menuItems = <String>[
    'Normal',
    'Subscribe',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, right: 16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                //     ? 650
                                //     : MediaQuery.of(context).size.width,
                                color: AppColor.whiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Users",
                                        style: GoogleFonts.getFont(
                                          "Poppins",
                                          textStyle: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  color: AppColor.borderColor,
                                                  width:
                                                      1.0, // Adjust the width as needed
                                                ),
                                                top: BorderSide(
                                                  color: AppColor.borderColor,
                                                  width:
                                                      1.0, // Adjust the width as needed
                                                ),
                                                bottom: BorderSide(
                                                  color: AppColor.borderColor,
                                                  width:
                                                      1.0, // Adjust the width as needed
                                                ),
                                                // No border on the right side
                                                right: BorderSide.none,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: const TextField(
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                hintText: 'Search here',
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                prefixIcon: Icon(Icons.search,
                                                    color: Colors.black),
                                              ),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13,
                                            decoration: const BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Search",
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
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  8.0), // Adjust border radius as needed
                                              border: Border.all(
                                                color: Colors
                                                    .grey, // Specify border color
                                                width:
                                                    1.0, // Specify border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                              ),
                                              child: DropdownButton(
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                value: _btn2SelectedVal,
                                                hint: const Text('Category'),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() =>
                                                        _btn2SelectedVal =
                                                            newValue);
                                                  }
                                                },
                                                items: _dropDownMenuItems,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: const Color(0xffF8F8F8),
                                        child: const Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  'Name',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                  'Gmail',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  'Phone Number',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  'Date',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'Phone Number',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  'Phone Number',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("1"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("2"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("3"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("4"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("5"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("6"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 38,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[300]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text("7"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("Basit Ali"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                    "Basitalyshah51214@gmail.com"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("03554500599"),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text("22/4/2024"),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "View",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 28,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "Block",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
