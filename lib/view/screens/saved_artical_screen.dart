import 'package:flutter/material.dart';
import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/view_model/server/local/data_base.dart';
import 'package:news/model/artical_model_db.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:localize_and_translate/localize_and_translate.dart';

class ArtcialSaved extends StatefulWidget {
  // ArtcialSaved({this.article});
  List<Artical> savedArtical;
  bool isLoading = false;

  Artical articlefiled;
  @override
  State<ArtcialSaved> createState() => _ArtcialSavedState();
}

class _ArtcialSavedState extends State<ArtcialSaved> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(
      //   //   'Notes',
      //   //   style: TextStyle(fontSize: 24),
      //   // ),
      //   // actions: [Icon(Icons.search), SizedBox(width: 12)],
      // ),
      body: widget.isLoading
          ? const  Center(
                  child:CircularProgressIndicator())
          : widget.savedArtical.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 
                      Text(
                        'No Artical Saved'.tr(),
                       style: TextStyle(
                color:  Theme.of(context).textTheme.bodyText1.color,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                height: 1.8),
          
                      ),
                    ],
                  ),
                )
              : Center(
                  child: ConditionalBuilder(
                    condition: widget.savedArtical.length > 0,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => SavedArtical(
                              articlefiled: widget.savedArtical[index],
                              onDismiss: (DismissDirection direction) {
                               
                                    ArticalDataBase.instance
                                    .delete(widget.savedArtical[index].id);
                                  
                              
                              
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.grey,
                                    content: Text(
                                        'Item Deleted'.tr())));
                              },
                              // id: widget.savedArtical[index].id,
                            ),

                            

                        // artcialCard(
                        //   context,
                        //       cubit.sports[index],

                        //     ),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 1.h,
                          );
                        },
                        itemCount: widget.savedArtical.length),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
    );
  }

// }
}

class SavedArtical extends StatelessWidget {
  Artical articlefiled;

  DismissDirectionCallback onDismiss;
  SavedArtical({this.articlefiled, this.onDismiss});
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
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: onDismiss,
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            color: Theme.of(context).appBarTheme.backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))),
            // margin: EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
            elevation: 5,
            child: Row(
              children: [
                  Container(
             height:
                      Device.orientation == Orientation.portrait ? 16.h : 38.h,
                  width:
                      Device.orientation == Orientation.portrait ? 35.w : 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                image: DecorationImage(
                    fit: BoxFit.cover,
                     image: NetworkImage(articlefiled.image),
               
                    ),
              ),
            ),
                // Container(
                //   height:
                //       Device.orientation == Orientation.portrait ? 16.h : 38.h,
                //   width:
                //       Device.orientation == Orientation.portrait ? 35.w : 40.w,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(articlefiled.image),
                //       fit: BoxFit.cover,
                //     ),
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(18),
                //       bottomLeft: Radius.circular(18),
                //     ),
                //   ),
                // ),
                // Container(
                //   height: 120,
                //   width: 120,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.0),
                //     image: DecorationImage(
                //       image: NetworkImage("${article["urlToImage"]}"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: Device.orientation == Orientation.portrait
                        ? 16.h
                        : 35.h,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            Container(
                              height: 23,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "Saved",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Device.orientation == Orientation.portrait
                                  ? 25.w
                                  : 38.w,
                            ),
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                            Text(
                              timeago.format(
                                  (DateTime.tryParse(articlefiled.createdTime)),
                                  locale: 'en_short'),

                              // DateTime.tryParse(articlefiled.createdTime).toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          articlefiled.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 1.2.pc,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //  SizedBox(
                        //    height: 1,
                        //  ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {
                        //         // ArticalDataBase.instance.delete(id);
                        //       },
                        //       icon: Icon(
                        //         Icons.delete,
                        //         size: 20,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: Device.orientation == Orientation.portrait
                        //           ? 30.w
                        //           : 48.w,
                        //     ),
                        //     Icon(
                        //       Icons.share,
                        //       size: 20,
                        //       color: Colors.grey,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
