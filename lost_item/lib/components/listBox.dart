import 'package:flutter/material.dart';

defaultListBox(String name, double avgPrice, double recentPrice) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
        ),
        Text(
          avgPrice.toString(),
        ),
        Text(
          recentPrice.toString(),
        ),
      ],
    ),
  );
}
