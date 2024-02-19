import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lost_item/utils/book_mark.dart';

defaultListBox(String imgUrl, String name, double avgPrice, double recentPrice,
    double curPrice, int? tradeRemainCount, Map createdBookmarkInfo) {
  final func = Get.put(BookMark());

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
                    Text(
                      '현재 최저가: $curPrice',
                    ),
                    () {
                      if (tradeRemainCount != null) {
                        return Text(
                          '남은 거래 횟수: $tradeRemainCount',
                        );
                      }
                      return Container();
                    }()
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                print('tap bookmark Icon');
                if (await func.isBookMark(createdBookmarkInfo)) {
                  await func.deleteBookmark(createdBookmarkInfo);
                } else {
                  await func.createBookMark(createdBookmarkInfo);
                }
              },
              child: GetBuilder<BookMark>(
                builder: (context) {
                  if (func.bookMarkList
                      .contains(createdBookmarkInfo.toString())) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 242, 192, 44),
                          ),
                          Icon(
                            Icons.star_border,
                            color: Color.fromARGB(255, 200, 150, 20),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                      child: Icon(
                        Icons.star_border,
                        color: Color.fromARGB(75, 0, 0, 0),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
