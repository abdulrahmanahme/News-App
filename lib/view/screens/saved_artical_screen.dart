import 'package:flutter/material.dart';
import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/view_model/server/local/data_base.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../componante/setting_componante/setting_componante.dart';
import '../../model/artical_model_db.dart';

class ArticleSaved extends StatefulWidget {
  // ArticleSaved({this.Article});
  List<Article> savedArticle;
  bool isLoading = false;

  Article Articlefiled;
  @override
  State<ArticleSaved> createState() => _ArticleSavedState();
}

class _ArticleSavedState extends State<ArticleSaved> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.savedArticle.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      Text(
                        'No Article Saved'.tr(),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.8),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: ConditionalBuilder(
                    condition: widget.savedArticle.length > 0,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => SavedArticle(
                              articlefiled: widget.savedArticle[index],
                              onPressed: () {
                                ArticleDataBase.instance
                                    .delete(widget.savedArticle[index].id);
                                refreshNote();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.grey,
                                        content: Text('Item Deleted'.tr())));
                              },
                            ),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 1.h,
                          );
                        },
                        itemCount: widget.savedArticle.length),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
    );
  }

// }
}

class SavedArticle extends StatelessWidget {
  Article articlefiled;
  void Function() onPressed;
  SavedArticle({this.articlefiled, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(url: articlefiled.url)),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Container(
          height: 25.6.h,
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
                      articlefiled.image,
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
                      articlefiled.title,
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
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 1),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
