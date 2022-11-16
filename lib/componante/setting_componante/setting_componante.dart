import 'package:flutter/material.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import '../../view_model/Cubit/states.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view/screens/about_screen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news/view_model/server/local/sharedpre.dart';
import 'package:flutter_switch/flutter_switch.dart';

class BuildSettingItemWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function() onClick;
  final bool isThemeIcon;

  const BuildSettingItemWidget(
      {Key key, this.icon, this.title, this.onClick, this.isThemeIcon = false})
      : super(key: key);

  @override
  _BuildSettingItemWidgetState createState() => _BuildSettingItemWidgetState();
}

class _BuildSettingItemWidgetState extends State<BuildSettingItemWidget> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      focusColor: widget.isThemeIcon
          ? Colors.transparent
          : Theme.of(context).highlightColor,
      splashColor: widget.isThemeIcon
          ? Colors.transparent
          : Theme.of(context).splashColor,
      highlightColor: widget.isThemeIcon
          ? Colors.transparent
          : Theme.of(context).highlightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              widget.icon,
              color: Theme.of(context).textTheme.bodyText1.color,
              size: 24.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 18.0,
                height: 1.0,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            widget.isThemeIcon
                ? BlocConsumer<NewsCubit, NewsStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var cubit = NewsCubit.get(context);

                      return FlutterSwitch(
                        width: 50.0,
                        height: 25.0,
                        toggleSize: 15.0,
                        value: CacheService.getTheme,
                        borderRadius: 30.0,
                        padding: 3.0,
                        toggleColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        switchBorder: Border.all(
                          color: Colors.deepOrange,
                          width: 2,
                        ),
                        toggleBorder: Border.all(
                          color: Colors.deepOrange,
                          width: 1.5,
                        ),
                        activeColor: Color(0xFFEAEDED),
                        inactiveColor: Color(0xFF373A3A),
                        onToggle: (isDark) {
                          cubit.changeAppTheme(switchValue: isDark);
                        },
                      );
                    },
                  )
                : Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).textTheme.bodyText1.color,
                    size: 20.0,
                  ),
          ],
        ),
      ),
    );
  }
}

class BuildContactUsItemWidget extends StatelessWidget {
  final String title, imageIcon;
  final Function() onClick;

  const BuildContactUsItemWidget(
      {Key key, this.title, this.imageIcon, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imageIcon,
            height: 25.0,
            width: 25.0,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                height: 1.8),
          ),
        ],
      ),
    );
  }
}

void materialNavigateTo({BuildContext context, Widget screen}) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

void namedNavigateTo({BuildContext context, String routeName, arguments}) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}

class BuildVersionWidget extends StatelessWidget {
  const BuildVersionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'version'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  snapshot.data.version,
                  style: TextStyle(
                    color:Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          default:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'version'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).tabBarTheme.labelColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '0.10.1',
                  style: TextStyle(
                    color: Theme.of(context).tabBarTheme.labelColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}

List<BuildSettingItemWidget> settingItems(BuildContext context) {
  return [
    BuildSettingItemWidget(
      title: 'About'.tr(),
      icon: Icons.help_outline,
      onClick: () => materialNavigateTo(context: context, screen: AboutView()),
    ),
    BuildSettingItemWidget(
      title: 'Service Provider'.tr(),
      icon: Icons.web,
      onClick: () => launchURL('https://newsapi.org/'),
    ),
    BuildSettingItemWidget(
      title: 'country'.tr(),
      icon: Icons.language_outlined,
      onClick: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return Container(
                height: 170.0,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 3.0,
                        width: 200.0,
                        margin: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                        color: Colors.deepOrange,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bottomSheetItems(context).length,
                        itemBuilder: (_, index) {
                          return bottomSheetItems(context)[index];
                        },
                        separatorBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Divider(
                            height: 5.0,
                            color: Theme.of(context).tabBarTheme.labelColor,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    ),
    BuildSettingItemWidget(
      title: 'Dark Mode'.tr(),
      icon: Icons.wb_incandescent_outlined,
      isThemeIcon: true,
      onClick: () {},
    ),
  ];
}

List<BuildContactUsItemWidget> contactItems() {
  return [
    BuildContactUsItemWidget(
      title: 'Gmail',
      imageIcon: 'assets/image/gmail.png',
      onClick: () {
        launchURL('mailto:abdelramanahmed00@gmail.com');
      },
    ),
    BuildContactUsItemWidget(
      title: 'Facebook',
      imageIcon: 'assets/image/facebook.png',
      onClick: () {
        launchURL(
            'https://www.facebook.com/people/%D8%B9%D8%A8%D8%AF%D8%A7%D9%84%D8%B1%D8%AD%D9%85%D9%86-%D8%A7%D9%84%D9%85%D8%A3%D9%85%D9%88%D8%B1/100004846755414/');
      },
    ),
    BuildContactUsItemWidget(
      title: 'LinkedIn',
      imageIcon: 'assets/image/linkedin.png',
      onClick: () {
        launchURL('https://www.linkedin.com/in/abdulrahman-almamur/');
      },
    ),
  ];
}

void launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch';
}

List<BuildBottomSheetItem> bottomSheetItems(BuildContext context) {
  return [
    BuildBottomSheetItem(
      title: ' مِصْرَ',
      iconImage: 'assets/image/eg_flag.png',
      onClick: () {
        if (CacheService.lange == 'ar') {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('بالفعل انت تشاهد اخبار مصر')));
        } else {
          CacheService.cacheData(key: 'Getlange', value: 'ar');
          translator
              .setNewLanguage(context, newLanguage: 'ar', restart: true)
              .then((value) {});
        }
      },
    ),
    BuildBottomSheetItem(
      title: 'United states',
      iconImage: 'assets/image/us_flag.png',
      onClick: () {
        if (CacheService.lange == 'en') {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Already you are watching the news of the United States of America')));
        } else {
          CacheService.cacheData(key: 'Getlange', value: 'en');
          translator
              .setNewLanguage(context, newLanguage: 'en', restart: true)
              .then((value) {});
        }
      },
    ),
  ];
}

class BuildBottomSheetItem extends StatelessWidget {
  final String title, iconImage;
  final Function() onClick;

  const BuildBottomSheetItem(
      {Key key, this.title, this.iconImage, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w500),
          ),
          Container(
            height: 25.0,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconImage),
                fit: BoxFit.fill,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
