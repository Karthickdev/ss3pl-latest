import 'package:flutter/material.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initialize();
    });
  }

  Future initialize() async {
    await initializeResources(context: context);
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/icon.png",
                height: 100,
                width: 100,
              ),

              //         Column(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                  SvgPicture.asset(
              //           assets.coinbeelogo,
              //                     height: 159, width: 99,),
              //               ],
              // ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text('Powered by ',
            //               style: GoogleFonts.inter(
            //                 textStyle: const TextStyle(fontSize: 14),
            //               )),
            //         ],
            //       ),
            //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //         Text('CodiFi',
            //             style: GoogleFonts.inter(
            //               textStyle: const TextStyle(
            //                   fontSize: 14, fontWeight: FontWeight.bold),
            //             ))
            //       ]),
            //     ],
            //   ),
            // )
          ),
        ],
      ),
    );
  }
}
