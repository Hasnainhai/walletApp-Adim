import 'package:flutter/material.dart';

class TableRowItem extends StatelessWidget {
  final int no;
  final String name;
  final String gmail;
  final String phoneNumber;
  final String status;
  final String date;

  const TableRowItem({
    Key? key,
    required this.no,
    required this.name,
    required this.gmail,
    required this.phoneNumber,
    required this.status,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(no.toString()),
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
              child: Text(gmail),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(phoneNumber),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(status),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(date),
            ),
          ),
        ],
      ),
    );
  }
}
