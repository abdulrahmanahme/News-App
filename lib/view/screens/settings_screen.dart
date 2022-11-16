import 'package:flutter/material.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../componante/setting_componante/setting_componante.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingView extends StatelessWidget {
  static const String id = 'SettingView';

  const SettingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildCustomAppBar(title: 'setting'.tr()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
           const BuildVersionWidget(),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: settingItems(context).length,
                itemBuilder: (_, index) {
                  return settingItems(context)[index];
                },
                separatorBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    height: 2,
                    color: Theme.of(context).tabBarTheme.labelColor,
                    thickness: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Divider(
                  color: Theme.of(context).tabBarTheme.labelColor,
                  thickness: 1.0,
                ),
              ),
              Text(
                'contact us'.tr(),
                style: TextStyle(
                  // color: Theme.of(context).tabBarTheme.labelColor,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  // color: Theme.of(context).brightness == Brightness.dark? Colors.black:Colors.white,

                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: contactItems().length,
                  itemBuilder: (_, index) {
                    return contactItems()[index];
                  },
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 15.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



