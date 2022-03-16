import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Widget contentToDisplay;
  const ItemCard({Key? key, required this.contentToDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      color: Colors.grey[200],
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
    );
  }
}
