import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Widget contentToDisplay;
  final VoidCallback onPressed;
  const ItemCard(
      {Key? key, required this.contentToDisplay, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              contentToDisplay,
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[500],
              )
            ],
          ),
        ),
      ),
    );
  }
}
