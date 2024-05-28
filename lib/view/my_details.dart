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

class MyDetails extends StatefulWidget {
  const MyDetails({super.key});

  @override
  State<MyDetails> createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  // var fireStore = FirebaseFirestore.instance;
  // var uuid = const Uuid().v1();

  void storeBankDetails(
      TextEditingController nameController,
      TextEditingController bankNameController,
      TextEditingController accountNumberController,
      TextEditingController isfcControoler) async {
    try {
      // Create a map to store valid data
      final Map<String, dynamic> data = {};

      // Check if controllers have text and add them to the map
      if (nameController.text.isNotEmpty) {
        data['accountHolderName'] = nameController.text;
      }
      if (bankNameController.text.isNotEmpty) {
        data['bankName'] = bankNameController.text;
      }
      if (accountNumberController.text.isNotEmpty) {
        data['accountNumber'] = accountNumberController.text;
      }
      if (isfcController.text.isNotEmpty) {
        data['ISFCCode'] = isfcControoler.text;
      }

      // Only store data if the map is not empty
      if (data.isNotEmpty) {
        final String documentId = const Uuid().v1();
        final CollectionReference bankDetailsRef =
            FirebaseFirestore.instance.collection('BankDetails');
        data['uuid'] = documentId;
        await bankDetailsRef.doc(documentId).set(data);
        Utils.toastMessage("Bank details stored successfully!");
        debugPrint('Bank details stored successfully!');
        Navigator.pop(context);
      } else {
        debugPrint('No data to store. Please fill in the required fields.');
        Utils.toastMessage(
            "No data to store. Please fill in the required fields.");
      }
    } on FirebaseException catch (e) {
      Utils.flushBarErrorMessage(
          'Error storing bank details: ${e.message}', context);
      Navigator.pop(context);
    } catch (e) {
      Utils.flushBarErrorMessage(
          'An unexpected error occurred: ${e.toString()}', context);
      Navigator.pop(context);
    }
  }

  void deleteBankDetails(String documentId) async {
    try {
      final CollectionReference bankDetailsRef =
          FirebaseFirestore.instance.collection('BankDetails');
      await bankDetailsRef.doc(documentId).delete();
      print('Bank details deleted successfully!');
      // Consider showing a success message to the user
    } on FirebaseException catch (e) {
      Utils.flushBarErrorMessage(
          'Error deleting bank details: ${e.message}', context);
    } catch (e) {
      Utils.flushBarErrorMessage(
          'An unexpected error occurred: ${e.toString()}', context);
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController isfcController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: getOrderScaffoldKey,
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
                      child: SingleChildScrollView(
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
                                    title: 'Add Bank Details')
                              ],
                            ),
                            //my bank details section

                            const VerticalSpeacing(40.0),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('BankDetails')
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
                                  return const Center(
                                    child: Text('No bank details found'),
                                  ); // Handle no data scenario
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
                                    final String bankName =
                                        bankDetails['bankName'] ?? '';
                                    final String accountNumber =
                                        bankDetails['accountNumber'] ?? 'N/A';
                                    final String accountHolderName =
                                        bankDetails['accountHolderName'] ??
                                            'N/A';
                                    final String documentId =
                                        bankDetails['uuid'] ?? 'N/A';
                                    final String isfccode =
                                        bankDetails['ISFCCode'] ?? 'N/A';

                                    return Container(
                                      height: 218,
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
                                                  'My Bank Account Details',
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
                                                    deleteBankDetails(
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
                                                        'Bank Name',
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
                                                            bankName,
                                                            style: const TextStyle(
                                                                color: AppColor
                                                                    .whiteColor),
                                                          ))
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
                                                        'Account Number',
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
                                                        accountNumber,
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
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'ISFC Code',
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
                                                        isfccode,
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
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Account Holder Name',
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
                                                        accountHolderName,
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
                            const VerticalSpeacing(16.0),
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
            height: MediaQuery.of(context).size.height / 1.4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Account details',
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
                  AddField(
                    title: "Account Holder Name",
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AddField(
                    title: "Bank Name",
                    controller: bankNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AddField(
                    title: "Account Number",
                    controller: accountNumberController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AddField(
                    title: "ISFC Code",
                    controller: isfcController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Call storeBankDetails function with all controllers
                        storeBankDetails(
                          nameController,
                          bankNameController,
                          accountNumberController,
                          isfcController,
                        );
                      },
                      child: Container(
                        height: 38,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Add Details',
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
  }
}
