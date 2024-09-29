import 'package:flutter/material.dart';
import 'package:news/componante/componante.dart';
import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/componante/app_constaint.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:timeago/timeago.dart' as timeago;

Widget buildImageSlider(BuildContext context, List<dynamic> Article) {
  var md = MediaQuery.of(context).size;
  int size = Article.length;
  var element = List<int>.generate(size, (i) => i);

  return SingleChildScrollView(
    child: (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: md.height * 0.03,
      ),
      CarouselSlider(
        options: CarouselOptions(
          height: Device.orientation == Orientation.portrait ? 25.h : 100.h,
          initialPage: 0,
          autoPlay: true,
          onPageChanged: (index, _) {},
          autoPlayInterval: const Duration(seconds: 3),
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
        items: element.map((i) {
          return Builder(builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebViewScreen(url: Article[i]["url"])),
                );
              },
              child:  Card(
        color: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        // margin: EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
        elevation: 2,
                child:SizedBox(
                  height:
                      Device.orientation == Orientation.portrait ? 23.h : 100.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: Container(
                          height: Device.orientation == Orientation.portrait
                              ? 30.h
                              : 100.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${(Article[i]['urlToImage']) == null ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png' : Article[i]['urlToImage']}',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  translator.activeLanguageCode == 'en'
                                      ? timeago.format(
                                          (DateTime.tryParse(
                                                  Article[i]['publishedAt']) ??
                                              nullDate),
                                        )
                                      : ConvertToTimeAgo.convertToTimeAgo(
                                          DateTime.parse(
                                              Article[i]['publishedAt']),
                                        ),
                                  ///////////Technology
              
                                  style: TextStyle(
                                    fontSize:
                                        translator.activeLanguageCode == 'en'
                                            ? 17
                                            : 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              Article[i]['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        }).toList(),
      ),
    ])),
  );
}
