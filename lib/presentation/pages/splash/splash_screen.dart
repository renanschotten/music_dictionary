import 'package:flutter/material.dart';
import 'package:music_dictionary/shared/config/routes.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 900))
        ..forward();

  late final Animation<Offset> _offsetAnimationLTR = Tween<Offset>(
    end: Offset.zero,
    begin: Offset(-2.0, 0),
  ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

  late final Animation<Offset> _offsetAnimationRTL = Tween<Offset>(
    end: Offset.zero,
    begin: Offset(2.0, 0),
  ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

  @override
  void initState() {
    super.initState();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimationLTR,
              child: Text(
                'Dicionário',
                style: AppTextStyles.montserrat32w900,
              ),
            ),
            SlideTransition(
              position: _offsetAnimationRTL,
              child: Text(
                'Musical',
                style: AppTextStyles.montserrat32w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
