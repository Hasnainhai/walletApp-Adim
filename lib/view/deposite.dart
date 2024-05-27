// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_admin/Utils/utils.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/keys.dart';
import 'package:wallet_admin/res/responsive.dart';
import 'package:wallet_admin/view/deposite_image_container.dart';
import 'package:wallet_admin/view/slide_menu.dart';
import 'package:wallet_admin/view/widgets/user_detai_field.dart';

class Deposite extends StatefulWidget {
  const Deposite({super.key});

  @override
  State<Deposite> createState() => _DepositeState();
}

class _DepositeState extends State<Deposite> {
  Future<void> approveDepositeRequest(
      String userId, String requestId, double incrementAmount) async {
    try {
      var firestore = FirebaseFirestore.instance.collection("users");
      var uuid = Uuid().v1();
      var depositeRequestRef = FirebaseFirestore.instance
          .collection("deposite_request")
          .doc(requestId);

      // Check if the deposite request document exists
      var depositeRequestDoc = await depositeRequestRef.get();

      var depositeRequestData = depositeRequestDoc.data();
      if (depositeRequestData != null &&
          depositeRequestData.containsKey('status') &&
          depositeRequestData['status'] == 'accepted') {
        debugPrint("Deposite request is already accepted.");
        Utils.toastMessage("Deposite request is already accepted.");
        Navigator.pop(context);
        return; // Exit the function if the deposite request is already accepted
      }

      var userDoc = await firestore.doc(userId).get();
      if (userDoc.exists) {
        var userData = userDoc.data();
        if (userData != null && userData.containsKey('balance')) {
          double currentBalance = (userData['balance'] as num).toDouble();
          double newBalance = currentBalance + incrementAmount;

          // Update the user's balance
          await firestore.doc(userId).update({"balance": newBalance});

          // Update the status in the deposite_request subcollection
          await depositeRequestRef.update({
            "status": "accepted",
            "updatedAt":
                FieldValue.serverTimestamp() // Optional: add a timestamp
          });
          Map<String, dynamic> dataMap = {
            "Action": "Deposite",
            "date": DateTime.now(),
            "amount": incrementAmount,
          };
          await firestore
              .doc(userId)
              .collection("History")
              .doc(uuid)
              .set(dataMap);

          Navigator.pop(context);

          Utils.toastMessage(
              "User balance and request status updated successfully.");
        } else {
          debugPrint("User data does not contain a balance field.");
        }
      } else {
        debugPrint("User document does not exist.");
      }
    } catch (e) {
      debugPrint(
          "An error occurred while updating the user balance and request status: $e");
      Navigator.pop(context);

      Utils.toastMessage(
          "An error occurred while updating the user balance and request status.");
    }
  }

  final TextEditingController _searchController = TextEditingController();
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      searchTerm = _searchController.text;
      debugPrint("this is the search term:$searchTerm");
    });
  }

  Stream<QuerySnapshot> _getUserStream() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('deposite_request');

    if (searchTerm.isNotEmpty) {
      return users.where('userName', isEqualTo: searchTerm).snapshots();
    } else {
      return users
          .orderBy('createdAt', descending: true) // Order by createdAt field
          .snapshots();
    }
  }

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
                                        "Deposite",
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
                                            child: TextField(
                                              controller: _searchController,
                                              decoration: const InputDecoration(
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
                                              style: const TextStyle(
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
                                                  'Bank Name',
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
                                                  'Bank Number',
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
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: _getUserStream(),
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
                                              child: Text(
                                                  'No deposite request found'),
                                            ); // Handle no data scenario
                                          }

                                          return ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: documents.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 12),
                                            itemBuilder: (context, index) {
                                              // Safely retrieve and cast data for each document

                                              final bankDetails =
                                                  documents[index].data()
                                                      as Map<String, dynamic>;
                                              final String name =
                                                  bankDetails['userName'] ?? '';
                                              final String accountNumber =
                                                  bankDetails[
                                                          'accountNumber'] ??
                                                      'N/A';
                                              final Timestamp creationDate =
                                                  bankDetails['createdAt'] ??
                                                      'N/A';
                                              final String userId =
                                                  bankDetails['userId'] ??
                                                      'N/A';

                                              final String bankName =
                                                  bankDetails['bankName'] ??
                                                      'N/A';
                                              final String requestId =
                                                  bankDetails['uuid'] ?? 'N/A';
                                              final String balance =
                                                  bankDetails['amount'] ??
                                                      'N/A';
                                              final String slipImage =
                                                  bankDetails['slipImageUrl'] ??
                                                      'N/A';
                                              DateTime dateTime =
                                                  creationDate.toDate();
                                              // Format DateTime to string
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(dateTime);
                                              return Container(
                                                height: 38,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[300]!),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Text(
                                                            index.toString()),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child: Text(name),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Center(
                                                        child: Text(bankName),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child:
                                                            Text(accountNumber),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child:
                                                            Text(formattedDate),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                        onTap: () {
                                                          showCustomDialog(
                                                              context,
                                                              name,
                                                              bankName,
                                                              accountNumber,
                                                              formattedDate,
                                                              userId,
                                                              double.parse(
                                                                  balance),
                                                              slipImage,
                                                              requestId);
                                                        },
                                                        child: Container(
                                                          height: 28,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            "View",
                                                            style: GoogleFonts
                                                                .getFont(
                                                              "Poppins",
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(
      BuildContext context,
      String name,
      String bankName,
      String accountNumber,
      String phoneNumber,
      String userId,
      double depositeamount,
      String slipImage,
      String requestId) {
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
            width: MediaQuery.of(context).size.width / 2.8,
            height: MediaQuery.of(context).size.height / 1.2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserDetailField(
                        title: "Account Holder Name",
                        data: name,
                      ),
                      UserDetailField(
                        title: "Bank Name",
                        data: bankName,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserDetailField(
                        title: "Account Number",
                        data: accountNumber,
                      ),
                      UserDetailField(
                        title: "Deposite Amount",
                        data: depositeamount.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => ImageContainer(
                            imageSlip: slipImage,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              slipImage,
                            ),
                            fit: BoxFit.fill),
                        border: Border.all(
                          color: AppColor.borderColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        approveDepositeRequest(
                            userId, requestId, depositeamount);
                      },
                      child: Container(
                        height: 38,
                        width: 143,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.primaryColor),
                        child: Center(
                          child: Text(
                            'Apporve',
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
