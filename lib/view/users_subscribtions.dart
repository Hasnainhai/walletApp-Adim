// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_admin/Utils/utils.dart';
import 'package:wallet_admin/res/components/colors.dart';
import 'package:wallet_admin/res/components/header.dart';
import 'package:wallet_admin/res/components/roundedButton.dart';
import 'package:wallet_admin/res/keys.dart';
import 'package:wallet_admin/res/responsive.dart';
import 'package:wallet_admin/view/slide_menu.dart';
import 'package:wallet_admin/view/widgets/user_detai_field.dart';

class UsersSubscribtions extends StatefulWidget {
  const UsersSubscribtions({super.key});

  @override
  State<UsersSubscribtions> createState() => _UsersSubscribtionsState();
}

class _UsersSubscribtionsState extends State<UsersSubscribtions> {
  String searchTerm = '';
  String selectedCategory = 'All'; // Default to show all users
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

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
    });
  }

  Stream<QuerySnapshot> _getUserStream() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('subscriptionRequests');
    if (searchTerm.isNotEmpty) {
      return users.where('userName', isEqualTo: searchTerm).snapshots();
    } else {
      return users.snapshots();
    }
  }

  Future<void> updateSubscriptionStatus(String userId, String requestId) async {
    try {
      var userRef = FirebaseFirestore.instance.collection("users");
      var requestRef =
          FirebaseFirestore.instance.collection("subscriptionRequests");

      // Start a batch to ensure all operations succeed or fail together
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Update the user's category to Subscribed
      batch.update(userRef.doc(userId), {"category": "Subscribed"});

      // Update the user's subscription request status to Active
      batch.update(
          userRef.doc(userId).collection("subscriptionRequests").doc(requestId),
          {"subscribtionStatus": "Active"});

      // Update the withdraw request status to Active
      batch.update(requestRef.doc(requestId), {
        "subscribtionStatus": "Active",
        "startDate": DateTime.now(),
      });

      // Commit the batch
      await batch.commit();
      Navigator.pop(context);
      Utils.toastMessage("Subscription status updated successfully.");
    } catch (e) {
      Utils.toastMessage("Failed to update subscription status");
    }
  }

  Future<void> createChatNodesForSubscribedUsers() async {
    try {
      var userRef = FirebaseFirestore.instance.collection("users");
      var uuid = const Uuid().v4();
      var chatData = {
        'message': messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'unread'
      };
      var subscribedUsersQuery =
          await userRef.where("category", isEqualTo: "Subscribed").get();
      FirebaseFirestore.instance.collection("Chats").doc(uuid).set(chatData);
      for (var doc in subscribedUsersQuery.docs) {
        var userId = doc.id;

        // Generate a unique ID for the new chat document

        // Create a map with the data you want to store in the new chat document

        // Create the chat node and the new document with the generated UUID
        await userRef.doc(userId).collection('chat').doc(uuid).set(chatData);
      }
      setState(() {
        messageController.clear();
      });
    } catch (e) {
      print("Failed to create chat nodes: $e");
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
                                        "Users Subscribtions",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
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
                                                      color:
                                                          AppColor.borderColor,
                                                      width:
                                                          1.0, // Adjust the width as needed
                                                    ),
                                                    top: BorderSide(
                                                      color:
                                                          AppColor.borderColor,
                                                      width:
                                                          1.0, // Adjust the width as needed
                                                    ),
                                                    bottom: BorderSide(
                                                      color:
                                                          AppColor.borderColor,
                                                      width:
                                                          1.0, // Adjust the width as needed
                                                    ),
                                                    // No border on the right side
                                                    right: BorderSide.none,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: TextField(
                                                  controller: _searchController,
                                                  decoration:
                                                      const InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0),
                                                    hintText: 'Search here',
                                                    hintStyle: TextStyle(
                                                        color: Colors.black),
                                                    border: InputBorder.none,
                                                    prefixIcon: Icon(
                                                        Icons.search,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Search",
                                                    style: GoogleFonts.getFont(
                                                      "Poppins",
                                                      textStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          RoundedButton(
                                              ontap: () {
                                                showCustomDialog(context);
                                              },
                                              title: 'Send message'),
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
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  'Subscribation Charges',
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
                                                  'Subscribtions Duration',
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
                                                  'Date',
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
                                                  'No Users details found'),
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
                                              final int userBalance = bankDetails[
                                                      'usercurrentBalance'] ??
                                                  'N/A';
                                              final String creationDate =
                                                  bankDetails['dateTime'] ??
                                                      'N/A';
                                              final String status = bankDetails[
                                                      'subscribtionStatus'] ??
                                                  'N/A';
                                              // final String charges = bankDetails[
                                              //         'usercurrentBalance'] ??
                                              //     'N/A';
                                              final String subCharges =
                                                  bankDetails[
                                                          'subscribtionCharges'] ??
                                                      'N/A';
                                              final String duration = bankDetails[
                                                      'subscriptionDuration'] ??
                                                  'N/A';
                                              final String requestId =
                                                  bankDetails['Uuid'] ?? 'N/A';
                                              final String userId =
                                                  bankDetails['userId'] ??
                                                      'N/A';

                                              // Format DateTime to string

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
                                                      flex: 3,
                                                      child: Center(
                                                        child: Text(subCharges
                                                            .toString()),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child: Text(
                                                            "$duration Months"),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Center(
                                                        child:
                                                            Text(creationDate),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: InkWell(
                                                        onTap: () {
                                                          subPopup(
                                                            context,
                                                            name,
                                                            subCharges,
                                                            userBalance,
                                                            duration,
                                                            status,
                                                            creationDate,
                                                            userId,
                                                            requestId,
                                                          );
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

  void subPopup(
    BuildContext context,
    String name,
    String subCharge,
    int balance,
    String duration,
    String status,
    String date,
    String userId,
    String requestId,
  ) {
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
            height: MediaQuery.of(context).size.height / 1.8,
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
                        title: "Name",
                        data: name,
                      ),
                      UserDetailField(
                        title: "Subscribtion Charges",
                        data: subCharge,
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
                        title: "Current Balance",
                        data: balance.toString(),
                      ),
                      UserDetailField(
                        title: "Date",
                        data: date,
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
                        title: "Subscribtion Duration",
                        data: duration,
                      ),
                      UserDetailField(
                        title: "subscribtion Status",
                        data: status,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (status == "Active") {
                        Utils.toastMessage("Status has Been already update!");
                        Navigator.pop(context);
                      } else {
                        updateSubscriptionStatus(userId, requestId);
                      }
                    },
                    child: Container(
                      height: 38,
                      width: 143,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.primaryColor),
                      child: Center(
                        child: Text(
                          'Approve',
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 446.77,
                    height: MediaQuery.of(context).size.height / 1.2,
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Send Message',
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
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Chats")
                                  .orderBy('timestamp',
                                      descending:
                                          false) // Order by createdAt field
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
                                    child: Text('No chats to show'),
                                  ); // Handle no data scenario
                                }
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                });

                                return ListView.separated(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: documents.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    // Safely retrieve and cast data for each document

                                    final bankDetails = documents[index].data()
                                        as Map<String, dynamic>;
                                    final String message =
                                        bankDetails['message'] ?? '';

                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFDFDFF),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            width: 1,
                                            color: const Color(0xffA5A6F6),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            message,
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: AppColor.textColor1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    hintText: 'Type a message',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  if (messageController.text.isNotEmpty) {
                                    createChatNodesForSubscribedUsers();
                                  }
                                },
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.send,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
