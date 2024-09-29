import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    this.leading,
    this.actions,
    this.height = 20,
  });
  final Widget leading;
  List<Widget> actions;
  double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w,),
        child: Container(
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.search,
                  size: 15,
                  color: Colors.grey[200],
                ),
                Spacer(),
                Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 5.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height.h);
}
