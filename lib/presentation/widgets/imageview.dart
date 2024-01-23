import 'package:icecream_service/theme.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:icecream_service/utils/color.util.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:icecream_service/theme.dart';

// class MyCacheManager {
//   final _storage = FirebaseStorage(
//     app: FirebaseFirestore.instance.app,
//     storageBucket: 'gs://my-project.appspot.com',
//   );

//   final defaultCacheManager = DefaultCacheManager();

//   Future<String> cacheImage(String imagePath) async {
//     final String ref = _storage.ref().child(imagePath);

//     // Get your image url
//     final imageUrl = await ref.getDownloadURL();

//     // Check if the image file is not in the cache
//     if ((await defaultCacheManager.getFileFromCache(imageUrl))?.file == null) {
//       // Download your image data
//       final imageBytes = await ref.getData(10000000);

//       // Put the image file in the cache
//       await defaultCacheManager.putFile(
//         imageUrl,
//         imageBytes,
//         fileExtension: "jpg",
//       );
//     }

//     // Return image download url
//     return imageUrl;
//   }
// }


class ImageViewerWidget extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Border? border;
  final BoxFit? imageFit;
  const ImageViewerWidget({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.imageFit
  }) : super(key: key);

  @override
  _ImageViewerWidgetState createState() => _ImageViewerWidgetState();
}

class _ImageViewerWidgetState extends State<ImageViewerWidget> {
  // final BaseCacheManager baseCacheManager = DefaultCacheManager();
  // late String _imageUrl;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //       final myCacheManager = MyCacheManager();

  //   // Image path from Firebase Storage
  //   var imagePath = 'selfies/me2.jpg';
    
  //   // This will try to find image in the cache first
  //   // If it can't find anything, it will download it from Firabase storage
  //   myCacheManager.cacheImage(imagePath).then((String imageUrl) {
  //     setState(() {
  //       // Get image url
  //       _imageUrl = imageUrl;
  //     });
  //   });
    
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.url!,
      // imageUrl: _imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: this.widget.width ?? 30,
        height: this.widget.height ?? 30,
        decoration: BoxDecoration(
          borderRadius: this.widget.borderRadius, //  BorderRadius.circular(40),
          // border: this.widget.border ?? Border.all(color: primaryColor, width: 1),
          image: DecorationImage(
            fit: widget.imageFit ?? BoxFit.cover,
            image: imageProvider
          )
        ),
      ),
      placeholder: (context, url) => ClipRRect(
        borderRadius: this.widget.borderRadius ?? BorderRadius.circular(0),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: this.widget.width ?? 30,
          height: this.widget.height ?? 30,
          decoration: BoxDecoration(
            borderRadius: this.widget.borderRadius ?? BorderRadius.circular(0),
          ),
          child: LinearProgressIndicator(
            backgroundColor: Color(ColorUtil.getColorHexFromStr("#f4f4f4")),
            minHeight: this.widget.height ?? 30,
            valueColor: new AlwaysStoppedAnimation<Color>(
              Color(ColorUtil.getColorHexFromStr("#ededed"))
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => ClipRRect(
        borderRadius: this.widget.borderRadius ?? BorderRadius.circular(0),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: this.widget.width ?? 30,
          height: this.widget.height ?? 30,
          decoration: BoxDecoration(
            borderRadius: this.widget.borderRadius ?? BorderRadius.circular(0),
          ),
          child: LinearProgressIndicator(
            backgroundColor:  Color(ColorUtil.getColorHexFromStr("#f4f4f4")),
            minHeight: this.widget.height ?? 30,
            valueColor: new AlwaysStoppedAnimation<Color>(
              Color(ColorUtil.getColorHexFromStr("#ededed"))
            ),
          ),
        ),
      )
    );
  }
}
