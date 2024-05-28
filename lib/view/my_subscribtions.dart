// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_admin/Utils/utils.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/components/vertical_spacing.dart';
import 'package:wallet_admin/res/keys.dart';
import 'package:wallet_admin/res/responsive.dart';
import 'package:wallet_admin/view/slide_menu.dart';
import 'package:wallet_admin/view/widgets/add_field.dart';

import '../res/components/roundedButton.dart';

class MySubscribtions extends StatefulWidget {
  const MySubscribtions({super.key});

  @override
  State<MySubscribtions> createState() => _MySubscribtionsState();
}

class _MySubscribtionsState extends State<MySubscribtions> {
  String date = 'YY-MM-DD';
  String? btn2SelectedVal;

  static const menuItems = <String>[
    '1',
    '3',
    "6",
    '12',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map<DropdownMenuItem<String>>(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  final TextEditingController durationController = TextEditingController();
  final TextEditingController chargesController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSubscription(
      String duration, String charges, String date) async {
    try {
      debugPrint("this is duration inside the function:$duration");
      var uuid = const Uuid().v1();
      await _db.collection('Subscriptions').doc(uuid).set({
        'duration': duration,
        'charges': charges,
        'date': date,
        'uuid': uuid
      });
      debugPrint("Subscription added successfully");
    } catch (e) {
      debugPrint("Failed to add subscription: $e");
    }
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Local variable to hold the date value
        String selectedDate = date;
        String? durationValue;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Dialog(
              backgroundColor: const Color(0xffF8F8F8),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height / 1.8,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDate,
                                  style: GoogleFonts.getFont(
                                    "Poppins",
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.textColor1,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2101),
                                    );
                                    if (picked != null) {
                                      setDialogState(() {
                                        selectedDate =
                                            picked.toString().substring(0, 10);
                                      });
                                      setState(() {
                                        date =
                                            picked.toString().substring(0, 10);
                                        // Update durationValue with selected value
                                      });

                                      debugPrint("this is the data: $date");
                                    }
                                  },
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
                      const SizedBox(
                        height: 20,
                      ),
                      AddField(
                        title: "Subscriptions Charges",
                        controller: chargesController,
                        keyboardType: TextInputType.number,
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
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust border radius as needed
                              border: Border.all(
                                color: Colors.grey, // Specify border color
                                width: 1.0, // Specify border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8,
                              ),
                              child: DropdownButton<String>(
                                underline: const SizedBox(),
                                isExpanded: true,
                                value: durationValue,
                                hint: const Text('Select Months'),
                                onChanged: (String? newValue) {
                                  if (mounted) {
                                    setState(() {
                                      btn2SelectedVal = newValue;
                                      durationValue = btn2SelectedVal;
                                    });
                                    debugPrint(
                                        "this is dropdown value: $btn2SelectedVal");
                                    setDialogState(() {});
                                  }
                                },
                                items: _dropDownMenuItems,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (durationValue != null &&
                                chargesController.text.isNotEmpty &&
                                selectedDate != 'YY-MM-DD') {
                              debugPrint(
                                  "this is the duration inside the conduction:$durationValue");
                              await addSubscription(
                                durationValue!,
                                chargesController.text,
                                selectedDate,
                              );
                              Navigator.of(context)
                                  .pop(); // Close the dialog after saving
                            } else {
                              Utils.flushBarErrorMessage(
                                "Please fill in all fields",
                                context,
                              );
                            }
                          },
                          child: Container(
                            height: 38,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.primaryColor,
                            ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteSubscriptionsDetails(String documentId) async {
    try {
      final CollectionReference bankDetailsRef =
          FirebaseFirestore.instance.collection('Subscriptions');
      await bankDetailsRef.doc(documentId).delete();
      Utils.toastMessage('Subscriptions deleted successfully!');

      // Consider showing a success message to the user
    } on FirebaseException catch (e) {
      Utils.flushBarErrorMessage(
          'Error deleting Subscriptions details: ${e.message}', context);
    } catch (e) {
      Utils.flushBarErrorMessage(
          'An unexpected error occurred: ${e.toString()}', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getFinanceScaffoldKey,
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
                                    ontap: () => showCustomDialog(context),
                                    title: 'Add Subscriptions')
                              ],
                            ),
                            const VerticalSpeacing(30.0),
                            //Subscribtions
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Subscriptions')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      'Error: ${snapshot.error}'); // Handle errors
                                }

                                if (!snapshot.hasData) {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator()); // Show loading indicator
                                }

                                final documents = snapshot.data!.docs;
                                // Check if there are any documents
                                if (documents.isEmpty) {
                                  return const Text(
                                      'No Subscriptions details found'); // Handle no data scenario
                                }

                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: documents.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    // Safely retrieve and cast data for each document

                                    final bankDetails = documents[index].data()
                                        as Map<String, dynamic>;
                                    final String charges =
                                        bankDetails['charges'] ?? '';
                                    final String date =
                                        bankDetails['date'] ?? 'N/A';
                                    final String duration =
                                        bankDetails['duration'] ?? 'N/A';
                                    final String documentId =
                                        bankDetails['uuid'] ?? 'N/A';

                                    return Container(
                                      color: AppColor.whiteColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Subscriptions',
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.textColor1,
                                                    ),
                                                  ),
                                                ),
                                                RoundedButton(
                                                  ontap: () {
                                                    deleteSubscriptionsDetails(
                                                        documentId);
                                                  },
                                                  title: 'Remove',
                                                ),
                                              ],
                                            ),
                                            const VerticalSpeacing(40.0),
                                            SizedBox(
                                              width: 800,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Duration of Subscriptions',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          "Poppins",
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColor
                                                                .textColor1,
                                                          ),
                                                        ),
                                                      ),
                                                      const VerticalSpeacing(
                                                          10.0),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .primaryColor,
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                          "$duration Months",
                                                          style: const TextStyle(
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Charge of Subscriptions',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          "Poppins",
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColor
                                                                .textColor1,
                                                          ),
                                                        ),
                                                      ),
                                                      const VerticalSpeacing(
                                                          10.0),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .primaryColor,
                                                        ),
                                                        onPressed: () {},
                                                        child: Text(
                                                          '₹$charges',
                                                          style: const TextStyle(
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Date of Creation',
                                                        style:
                                                            GoogleFonts.getFont(
                                                          "Poppins",
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColor
                                                                .textColor1,
                                                          ),
                                                        ),
                                                      ),
                                                      const VerticalSpeacing(
                                                          10.0),
                                                      Text(
                                                        date,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          "Poppins",
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColor
                                                                .textColor1,
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
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
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
