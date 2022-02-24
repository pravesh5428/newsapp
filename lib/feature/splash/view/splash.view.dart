import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff3a718c),
                    Color(0xff509abd),
                  ],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              child: Text('Catalog App',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  )),
            ),
            Text(
              'Trending Products',
              style: GoogleFonts.nunitoSans(
                fontSize: 16,
                color: const Color(0xff4d95b6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
