import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:note_bucket/components/res/assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(AnimationAssets.empty),
        Text(" ", style: GoogleFonts.poppins(fontSize: 18),),
      ],
    );
  }
}