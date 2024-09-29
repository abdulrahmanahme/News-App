import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:news/componante/componante.dart';
import 'package:news/componante/setting_componante/setting_componante.dart';
import 'package:news/model/artical_model_db.dart';
import 'package:share/share.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/view_model/server/local/data_base.dart';
import 'package:news/componante/app_constaint.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget ArticleBuilder(list, BuildContext context, {isSearch = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ArticleCard(
                colorCategory: Colors.red,
                nameCategory: "Search".tr(),
                article: list[index],
              ),
            ),
        separatorBuilder: (context, index) {
          return SizedBox();
        },
        itemCount: 2),
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()),
  );
}

Widget builderArticleItem(
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

class ArticleCard extends StatefulWidget {
  ArticleCard({
    this.article,
    this.addNote,
    this.colorCategory,
    this.nameCategory,
  });
  Future<void> addNote;
  dynamic article;
  String nameCategory;
  Color colorCategory;
  List<Article> savedArticle;
  bool isLoading = false;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

final refreshKey = GlobalKey<RefreshIndicatorState>();

class _ArticleCardState extends State<ArticleCard> {
  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  Future refreshNote() async {
    setState(() => widget.isLoading = true);

    this.widget.savedArticle = await ArticleDataBase.instance.readAllNotes();

    setState(() => widget.isLoading = false);
  }

  int i;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        materialNavigateTo(
          context: context,
          screen: WebViewScreen(url: widget.article["url"] ?? nullUrl),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Container(
          height: 25.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 17.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.article["urlToImage"] ?? nullImage,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 2.w,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .78,
                    child: Text(
                      "${widget.article["title"] ?? ''}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  BuildPopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    sizeOfIcon: 25,
                    onSelect: (value) async {
                      if (value == 'save') {
                        addNote();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.grey,
                            content: Text('Item Saved'.tr())));
                      } else {
                        await Share.share((widget.article["url"]));
                      }
                    },
                    popupMenuItems: [
                      _buildPopupMenuItem(
                        value: 'save',
                        title: 'Save Article'.tr(),
                        widget: const Icon(
                          Icons.bookmark,
                          color: Colors.grey,
                        ),
                      ),
                      _buildPopupMenuItem(
                        value: 'share',
                        title: 'share'.tr(),
                        widget: const Icon(
                          Icons.share,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNote({
    bool dark,
    String url,
    String image,
    String title,
    String description,
    String createdTime,
  }) async {
    final note = Article(
      dark: false,
      url: widget.article["url"],
      image: widget.article["urlToImage"],
      title: widget.article["title"],
      // description:widget.article["title"],
      createdTime: widget.article["publishedAt"],
    );
    await ArticleDataBase.instance.create(note);
  }
}

PopupMenuItem<String> _buildPopupMenuItem(
    {String value, String title, Widget widget}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        widget,
      ],
    ),
  );
}

class BuildPopupMenuButton extends StatelessWidget {
  final Icon icon;
  final double sizeOfIcon;
  final Function(dynamic) onSelect;
  final List<PopupMenuItem> popupMenuItems;

  const BuildPopupMenuButton(
      {Key key, this.icon, this.sizeOfIcon, this.onSelect, this.popupMenuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: EdgeInsets.all(0),
      enableFeedback: true,
      icon: icon,
      splashRadius: 10,
      iconSize: sizeOfIcon,
      onSelected: onSelect,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(8.0),
      // ),
      itemBuilder: (_) {
        return popupMenuItems;
      },
    );
  }
}
