import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// Widget builderArticalItem(
//   article,
//   context,
// ) {
//   return InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => WebViewScreen(url: article["url"])),
//       );
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         children: [
//           Container(
//             height: 120,
//             width: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               image: DecorationImage(
//                 image: NetworkImage("${article["urlToImage"]}"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Container(
//               height: 120,
//               child: Column(
//                 // mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "${article["title"]}",
//                       style: Theme.of(context).textTheme.bodyText1,
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     "${article["publishedAt"]}",
//                     style: TextStyle(fontSize: 15, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// class BuildSearchErrorWidget extends StatelessWidget {
//   final String image, errorMessage;

//   const BuildSearchErrorWidget({Key  key,  this.image,  this.errorMessage}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.asset(
//               image,
//               height: 300.0,
//               width: 300.0,
//               fit: BoxFit.fill,
//             ),
//             Text(
//               errorMessage,
//               style:  TextStyle(
//                 color:Theme.of(context).textTheme.bodyText1.color,
//                 fontSize: 22.0,
//                 height: 1,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

// class BuildNetworkImage extends StatelessWidget {
//   final String imageUrl;
//   final double height, width;

//   const BuildNetworkImage({Key key, this.imageUrl, this.height, this.width})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           height: height,
//           width: width,
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: Image.asset(
//                 'assets/image/loading.png',
//                 color: Colors.grey.shade300,
//               ),
//             ),
//           ),
//         ),
//         FadeInImage.memoryNetwork(
//           height: height,
//           width: width,
//           image: imageUrl,
//           fit: BoxFit.fill,
//           placeholder: kTransparentImage,
//           placeholderErrorBuilder: (_, value, error) {
//             return SizedBox(
//               height: height,
//               width: width,
//               child: const Center(
//                 child: Icon(
//                   Icons.error,
//                   size: 28.0,
//                   color: Colors.red,
//                 ),
//               ),
//             );
//           },
//           imageErrorBuilder: (_, value, error) {
//             return SizedBox(
//               height: height,
//               width: width,
//               child: const Center(
//                 child: Icon(
//                   Icons.error,
//                   size: 28.0,
//                   color: Colors.red,
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

Widget defaultFormField({
  TextEditingController controller,
  TextInputType type,
  ValueChanged<String> onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  String label,
  IconData prefix,
  TextStyle style,
  IconData suffix,
  Function suffixpress,
  Widget suffixIcon,
  int maxLines = 1,
  String hintText,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        style: style,
        onTap: onTap,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
              color: Color(0xff9D9491),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          hintText: hintText,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,

            // borderSide: BorderSide(
            //   color:   Colors.blueGrey.shade900,
            //   width: 3.0,
            // ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );

Widget errorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/image/bad_request_error.png'),
                const SizedBox(height: 20.0),
                Text(
                  details.exception.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };
}

// Container buildDirectionDismissibleBackground(BuildContext context,
//     {AlignmentGeometry alignment, double startPadding, double endPadding}) {
//   return Container(
//     alignment: alignment,
//     decoration: const BoxDecoration(
//       color: Colors.transparent,
//       borderRadius: BorderRadius.all(
//         Radius.circular(8.0),
//       ),
//     ),
//     child: Padding(
//       padding: EdgeInsetsDirectional.only(start: startPadding, end: endPadding),
//       child: CircleAvatar(
//         radius: 20.0,
//         backgroundColor: Colors.redAccent,
//         child: Icon(
//           Icons.delete,
//           color: Theme.of(context).scaffoldBackgroundColor,
//         ),
//       ),
//     ),
//   );
// }

// ConvertToTimeAgo.convertToTimeAgo(
//                           DateTime.parse(articles[index].publishedAt),
//                         ),
///THIS CLASS CONVERTING DATE FROM STRING FORMAT TO TIME AGO
class ConvertToTimeAgo {
  static String convertToTimeAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inDays} ${('day').tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inDays} ${'day'.tr()}';
    } else if (diff.inHours == 2 || diff.inHours <= 10) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hours'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hours'.tr()}';
    } else if (diff.inHours == 1 || diff.inHours >= 11) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hour'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hour'.tr()}';
    } else if (diff.inMinutes >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inMinutes} ${'minute'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inMinutes} ${'minute'.tr()}';
    } else if (diff.inSeconds >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inSeconds} ${'second'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inSeconds} ${'second'.tr()}';
    } else {
      return 'just now'.tr();
    }
  }
}

class Text_Form_Widget extends StatelessWidget {
  String lableText;
  String hintText;
  Widget prefixIcon;
  Function onTap;
  Function validator;
  Function onChanged;
  TextInputType keyboardType;
  TextEditingController controller;
  Text_Form_Widget(
      {this.lableText,
      this.hintText,
      this.prefixIcon,
      this.onTap,
      this.validator,
      this.keyboardType,
      this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black,
          // backgroundColor: Colors.white,
        ),
        decoration: InputDecoration(
          filled: true,
            hintStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          prefixIcon: prefixIcon,
          labelText: lableText,
          hintText: hintText,
          
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,

            // borderSide: BorderSide(
            //   color:   Colors.blueGrey.shade900,
            //   width: 3.0,
            // ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 20,
          ),
          fillColor: Colors.lightBlue[50],
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
       
        ),
        onTap: onTap,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
