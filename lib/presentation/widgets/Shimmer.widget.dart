// ignore_for_file: prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:icecream_service/business_logic/cubit/signup/cubit/signup_cubit.dart';

class ShimmerImage extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Border? border;
  final BoxFit? imageFit;

  const ShimmerImage({
    Key? key,
    this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.imageFit
  });


  @override
  State<ShimmerImage> createState() => _ShimmerImageState();
}

class _ShimmerImageState extends State<ShimmerImage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Container(
          width: widget.width ?? 400.0,
          height: widget.height ?? 250.0,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ??  BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(
                widget.url??
                "https://app.web.trans-academia.cd/app-assets/img/utilisateurs/" +
                    state.field!["photo"],
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
