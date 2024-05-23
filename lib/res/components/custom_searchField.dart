import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 204, 
      height: 38,
      margin:
          const EdgeInsets.only(top: 11, left: 927), // Set top and left margins
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(0), // Set the background color with opacity
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
      ),
      child: Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search",
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Icon(
                  Icons.search,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
