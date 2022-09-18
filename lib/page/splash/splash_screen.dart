
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iabd_com/index.dart';
import '../../controller/splash_screen_controller.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController controller = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
      _getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  _getUserLogin() async {
    String? login = await controller.getUserLogin();
    //String? customerNo = await controller.customerNo;
    //Get.offAll((login != null && customerNo != null ) ? const HomePageWidget() : const LoginWidget());
    Get.offAll((login != null  ) ? const CommercialHomeWidget() : const LoginWidget());
  }

}
