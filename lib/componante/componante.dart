import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:news/Modules/Modules_webveiw.dart';

Widget builderArticalItem(
  article,
  context,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewScreen(url: article["url"])),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage("${article["urlToImage"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${article["title"]}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "${article["publishedAt"]}",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget articleBuilder(list, {isSreach = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => builderArticalItem(
              list[index],
              context,
            ),
        separatorBuilder: (context, index) {
          return Divider(
            height: 10,
            thickness: 1.5,
            endIndent: 8,
            indent: 8,
          );
        },
        itemCount: 10),
    fallback: (context) =>
        isSreach ? Container() : Center(child: CircularProgressIndicator()),
  );
}
