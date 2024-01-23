import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:icecream_service/presentation/widgets/dialog/loading.dialog.dart';
import 'package:icecream_service/presentation/widgets/imageview.dart';
import 'package:http/http.dart' as http;
import 'package:icecream_service/presentation/widgets/loading.dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class CarousselSlide extends StatefulWidget {
  // final List data;
  const CarousselSlide({super.key});

  @override
  State<CarousselSlide> createState() => _CarousselSlideState();
}

class _CarousselSlideState extends State<CarousselSlide> {
  int currentIndex = 1;
  String url = "https://api-bantou-store.vercel.app/api/v1/images";
  var dataImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataListImages();
  }

  void test() async {
    await getDataListImages();
  }

  Future<void> getDataListImages() async {
    var dio = Dio();
    dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);
    var response = await dio.get(url,
        options: buildCacheOptions(const Duration(hours: 6))
        );
    var data = response.data;
    setState(() {
      dataImages = data;
    });
    print(data);
  }

  Future<void> launchUrlSite(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: dataImages.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        if (dataImages.length == 0) {
          return ImageViewerWidget(
            url: '',
            imageFit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.0),
            width: MediaQuery.of(context).size.width,
          );
        }
        return InkWell(
          onTap: () {
            if (dataImages[index]["inTheApp"] == false) {
              launchUrlSite(dataImages[index]["link"]);
            } else {
              print("in development");
            }
          },
          child: ImageViewerWidget(
            url: dataImages[index]["url"],
            imageFit: BoxFit.cover,
            borderRadius: BorderRadius.circular(8.0),
            width: MediaQuery.of(context).size.width,
          ),
        );
      },
      options: CarouselOptions(
        height: 150.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 3000),
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {
          // print(index);
        },
      ),
    );
  }
}
