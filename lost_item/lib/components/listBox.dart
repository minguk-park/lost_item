import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

defaultListBox(
    String imgUrl, String name, double avgPrice, double recentPrice) {
  print(imgUrl);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
    child: Row(
      children: [
        CachedNetworkImage(
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvier) {
            return InteractiveViewer(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvier, fit: BoxFit.cover),
                ),
              ),
            );
          },
        ),
        Column(
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
      ],
    ),
  );
}
