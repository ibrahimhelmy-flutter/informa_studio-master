import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.1),
        child: Container(
          color: Colors.white,
        ));
  }
}
