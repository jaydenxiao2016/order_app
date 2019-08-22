import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_app/common/utils/common_utils.dart';
import 'package:photo_view/photo_view.dart';

///大图查看
class BigPhotoView extends StatelessWidget {
  ///图片在线rul
  final String photoUrl;
  ///tagName
  final String tagName;

  BigPhotoView(this.photoUrl,this.tagName, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: PhotoView.customChild(
        child: Container(
            child:
                CommonUtils.displayImageWidget(photoUrl,fit: BoxFit.contain)),
        childSize: Size(ScreenUtil.screenWidth, ScreenUtil.screenHeight),
        backgroundDecoration: BoxDecoration(color: Colors.black),
        customSize: MediaQuery.of(context).size,
        heroTag: tagName,
        minScale: PhotoViewComputedScale.contained * 0.5,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained * 0.8,
        basePosition: Alignment.center,
      )),
    );
  }
}
