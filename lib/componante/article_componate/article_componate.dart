import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:news/componante/componante.dart';
import 'package:news/componante/setting_componante/setting_componante.dart';
import 'package:share/share.dart';

import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/view_model/server/local/data_base.dart';
import 'package:news/model/artical_model_db.dart';
import 'package:news/componante/app_constaint.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget articleBuilder(list, BuildContext context, {isSreach = false}) {
  return ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => ArtcialCard(
              colorCategory: Colors.red,
              nameCategory: "Sreach".tr(),
              article: list[index],
            ),
        // builderArticalItem(
        //   context,
        //     list[index],

        // ),

        separatorBuilder: (context, index) {
          return Divider(
            height: 10,
            thickness: 1.5,
            endIndent: 8,
            indent: 8,
          );
        },
        itemCount: 2),
    fallback: (context) =>
        isSreach ? Container() : Center(child: CircularProgressIndicator()),
  );
}

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

class ArtcialCard extends StatefulWidget {
  ArtcialCard({
    this.article,
    this.addNote,
    this.colorCategory,
    this.nameCategory,
  });
  Future<void> addNote;
  dynamic article;
  String nameCategory;
  Color colorCategory;
  List<Artical> savedArtical;
  bool isLoading = false;

  @override
  State<ArtcialCard> createState() => _ArtcialCardState();
}


final refreshKey = GlobalKey<RefreshIndicatorState>();

class _ArtcialCardState extends State<ArtcialCard> {
  @override
  void initState() {
    refreshNote();
    super.initState();
  }
  Future refreshNote() async {
    setState(() => widget.isLoading = true);

    this.widget.savedArtical = await ArticalDataBase.instance.readAllNotes();

    setState(() => widget.isLoading = false);
  }
    int i ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
        // margin: EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
        elevation: 5,
        child: Row(
          children: [
            Container(
              height: Device.orientation == Orientation.portrait ? 18.h : 38.h,
              width: Device.orientation == Orientation.portrait ? 35.w : 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.article["urlToImage"] ?? nullImage,
                  ),
                ),
              ),
            ),
            // Container(
            //   height: Device.orientation == Orientation.portrait ? 18.h : 38.h,
            //   width: Device.orientation == Orientation.portrait ? 35.w : 40.w,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(4.0),
            //       topRight: Radius.circular(4.0),
            //     ),
            //     image: DecorationImage(
            //         fit: BoxFit.cover,
            //         image: AssetImage('assets/image/socket_error.png')),
            //   ),
            // ),
            // BuildNetworkImage(
            //   height:
            //       Device.orientation == Orientation.portrait ? 18.h : 38.h,
            //   width:
            //       Device.orientation == Orientation.portrait ? 35.w : 40.w,
            //   imageUrl: widget.article["urlToImage"] ?? nullImage,
            // ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height:
                    Device.orientation == Orientation.portrait ? 16.h : 35.h,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //               FadeInImage.memoryNetwork(
                    //   height: height,
                    //   width: width,
                    //   image: imageUrl,
                    //   fit: BoxFit.fill,
                    //   placeholder: kTransparentImage,
                    //   placeholderErrorBuilder: (_, value, error) {
                    //     return SizedBox(
                    //       height: height,
                    //       width: width,
                    //       child: const Center(
                    //         child: Icon(
                    //           Icons.error,
                    //           size: 28.0,
                    //           color: Colors.red,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   imageErrorBuilder: (_, value, error) {
                    //     return SizedBox(
                    //       height: height,
                    //       width: width,
                    //       child: const Center(
                    //         child: Icon(
                    //           Icons.error,
                    //           size: 28.0,
                    //           color: Colors.red,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Expanded(
                          child: Container(
                            // height: 23,
                            // width: 50,
                            decoration: BoxDecoration(
                              color: widget.colorCategory,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                widget.nameCategory,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Device.orientation == Orientation.portrait
                              ? translator.activeLanguageCode == 'en'
                                  ? 29.w
                                  : 25.w
                              : 38.w,
                        ),
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                          size: 17,
                        ),
                        Text(
                          translator.activeLanguageCode == 'en'
                              ? timeago.format(
                                  (DateTime.tryParse(
                                          widget.article['publishedAt']) ??
                                      nullDate),
                                  locale: 'en_short')
                              : ConvertToTimeAgo.convertToTimeAgo(
                                  DateTime.parse(widget.article['publishedAt']),
                                ),
                          style: TextStyle(
                            fontSize:
                                translator.activeLanguageCode == 'en' ? 17 : 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      "${widget.article["title"] ?? ''}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: translator.activeLanguageCode == 'en'
                            ? 1.2.pc
                            : 0.8.pc,
                        color: Colors.grey,
                      ),
                      maxLines: translator.activeLanguageCode == 'en' ? 3 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Align(
                      // alignment: Alignment.bottomRight,
                      alignment: translator.activeLanguageCode == 'en'
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,

                      child: Container(
                        height: 2.5.h,
                        width:
                            translator.activeLanguageCode == 'en' ? 15.w : 15.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //  Icon(
                            //   Icons.share,
                            //   size: 10,
                            //   color: Colors.grey,
                            // ),
                            BuildPopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.red,
                              ),
                              sizeOfIcon: 22.0,
                              onSelect: (value) async {
                                if (value == 'visit') {
                                  materialNavigateTo(
                                      context: context,
                                      screen: WebViewScreen(
                                          url: widget.article["url"] ??
                                              nullUrl));
                                } else if (value == 'save') {
                                  
    //                            if(!widget.isLoading)   
          
    //                             if (widget.article["title"] == widget.savedArtical[i].title) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Colors.grey, content: Text('Allready Saved'.tr())));
    // return;
    // }else{
      
    // }
                                 
                                  // else {
                                  addNote();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.grey,
                                          content: Text('Item Saved'.tr())));
                                  // }
                                } else {
                                  await Share.share((widget.article["url"]));
                                }
                              },
                              popupMenuItems: [
                                _buildPopupMenuItem(
                                  value: 'visit',
                                  title: 'visit Artical'.tr(),
                                  widget: const Icon(
                                    Icons.link,
                                    color: Colors.red,
                                  ),
                                ),
                                _buildPopupMenuItem(
                                  value: 'save',
                                  title: 'Save Artical'.tr(),
                                  widget: const Icon(
                                    Icons.bookmark,
                                    color: Colors.red,
                                  ),
                                ),
                                _buildPopupMenuItem(
                                  value: 'share',
                                  title: 'share'.tr(),
                                  widget: const Icon(
                                    Icons.share,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Future<void> addNote({
    bool dark,
    String url,
    String image,
    String title,
    String description,
    String createdTime,
  }) async {
    final note = Artical(
      dark: false,
      url: widget.article["url"],
      image: widget.article["urlToImage"],
      title: widget.article["title"],
      // description:widget.article["title"],
      createdTime: widget.article["publishedAt"],
    );
      await ArticalDataBase.instance.create(note);
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
      enableFeedback: true,
      icon: icon,
      iconSize: sizeOfIcon,
      onSelected: onSelect,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      itemBuilder: (_) {
        return popupMenuItems;
      },
    );
  }
}



