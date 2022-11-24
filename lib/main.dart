import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view/screens/splash_screen.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:news/componante/componante.dart';
import 'package:news/view_model/server/local/sharedpre.dart';
import 'package:news/view/screens/layout_screen.dart';
import 'package:news/view_model/server/remote/Dio_helper.dart';
import 'package:news/view_model/Cubit/Bloc_observer/bloc_obsrver.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() async {
   errorWidget();
  WidgetsFlutterBinding.ensureInitialized();
  
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheService.init();
    await translator.init(
    localeType: LocalizationDefaultType.device,
    language:CacheService.lange,
    languagesList: <String>['en' ,'ar'],
    assetsDirectory: 'assets/lang/',
  );
  
  runApp( LocalizedApp(child: MyApp(
    )));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
        //  BlocProvider(
        //   create: (context) => NewsCubit()..getBusiness(CacheService.lange)..getsports(CacheService.lange)..getscience(CacheService.lange)..getEntertainment(CacheService.lange)..getTechnology(CacheService.lange)..gethealth(CacheService.lange),
        // ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return ResponsiveSizer(
             builder: (context, orientation, screenType) {
            return  
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News Report -تقرير اخبارى',
               localizationsDelegates: translator.delegates,
      locale: translator.activeLocale, 
      supportedLocales: translator.locals(), 
              theme: ThemeData(
                cardColor: Colors.black,
                dividerColor: Colors.grey,
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.grey,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  backwardsCompatibility: false,
                  backgroundColor: Colors.white,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  elevation: .1,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              // backgroundColor: HexColor("333739"),
          
              darkTheme: ThemeData(
                scaffoldBackgroundColor: Color(0xFFFF212121),
                primarySwatch: Colors.red,
                dividerColor: Colors.white,
            
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  backwardsCompatibility: false,
                  backgroundColor: Color(0xFF373A3A) ,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:  Color(0xFF373A3A),
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  iconTheme: IconThemeData(
                    
                    color: Colors.white,
                  ),
                  elevation: .1,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Color(0xFFFF212121),
                ),
              ),
              themeMode:CacheService.getTheme??false?ThemeMode.dark:ThemeMode.light,
              // home: LayoutScreen(),
              home: AnimatedSplashScreen(
            duration: 2000,
            splash:SplashScreen(),
            nextScreen:  LayoutScreen(),
            backgroundColor:  Color(0xffD61123),
            // backgroundColor: Colors.blue,
            splashTransition: SplashTransition.decoratedBoxTransition,
            splashIconSize: 800,
           )
           );

             }
          );
        },
      ),
    );
  }
}
