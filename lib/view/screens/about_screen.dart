
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AboutView extends StatelessWidget {
  static const String id = 'AboutView';

  const AboutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height) * 0.6,
              width: double.infinity,
              alignment: AlignmentDirectional.topStart,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 227, 84, 73),
               
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(80.0),
                  bottomStart: Radius.circular(80.0),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                height: (MediaQuery.of(context).size.height) * 0.6,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(15.0),
                    topStart: Radius.circular(15.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5.0),
                        // Image.asset(
                        //   'assets/images/logo.png',
                        //   height: 100.0,
                        //   width: 110.0,
                        //   fit: BoxFit.fill,
                        // ),
                        const SizedBox(height: 5.0),
                        Text(
                          'app name'.tr(),
                          textAlign: TextAlign.center,
                           style: TextStyle(
                color:  Theme.of(context).textTheme.bodyText1.color,
                fontSize: 22.0.sp,
                // fontFamily: 'Ananda',
                fontWeight: FontWeight.w300,
                height: 1.8),
                        ),
                        
                        const SizedBox(height: 5.0),
                        Text(
                          'about_us'.tr(),
                          textAlign: TextAlign.center,
                           style: TextStyle(
                color:  Theme.of(context).textTheme.bodyText1.color,
                fontSize: 18.0.sp,
                // fontFamily: 'Ananda',
                fontWeight: FontWeight.w400,
                height: 1.8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
      Key key,
    this.gradient,
    this.style,
  }) : super(key: key);

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}