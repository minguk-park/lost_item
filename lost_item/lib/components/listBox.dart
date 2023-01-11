import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

defaultListBox(
    String imgUrl, String name, double avgPrice, double recentPrice) {
  print(imgUrl);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xffbbbbbb),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imgUrl,
              imageBuilder: (context, imageProvier) {
                return InteractiveViewer(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          image: imageProvier, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
            Container(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                ),
                Container(height: 7),
                Text(
                  '평균 가격: $avgPrice',
                ),
                Text(
                  '최근 가격: $recentPrice',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
