import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:southshore3pl/providers/user_provider.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/util/sizer.dart';

import 'login/login_view_model.dart';

class MainmenuScreen extends StatefulWidget {
  const MainmenuScreen({Key? key}) : super(key: key);

  @override
  State<MainmenuScreen> createState() => _MainmenuScreenState();
}

class _MainmenuScreenState extends State<MainmenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, watch, child) {
      final loginModel = watch(loginViewProvider);
      return WillPopScope(
        onWillPop: () async {
          Phoenix.rebirth(context);
          Fluttertoast.showToast(msg: "LOGOUT");
          return true;
        },
        child: SafeArea(
            child: Scaffold(
          backgroundColor: colors.kColorWhite,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(148.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: colors.kColorWhite,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              elevation: 0,
              centerTitle: true,
              flexibleSpace: Container(
                height: 260,
                width: sizes.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/homebg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: sizes.extraLargePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Sizer.vertical80(),
                      Sizer.vertical80(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.pickmenuscreen);
                            },
                            child: Container(
                                height: 150,
                                width: 450,
                                decoration: BoxDecoration(
                                    color: colors.kColorlogogreen,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "PICK APP",
                                      style: textStyles.kTextbuttonTitle,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                      const Sizer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.packmenuScreen);
                            },
                            child: Container(
                            height: 150,
                                width: 450,
                                decoration: BoxDecoration(
                                    color: colors.KColorblue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "PACK APP",
                                      style: textStyles.kTextbuttonTitle,
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                      const Sizer(),
                    ],
                  )),
              Sizer.vertical32(),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: sizes.extraLargePadding),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              loginModel.clearController();
                              loginModel.clearError();
                              context.read(userProvider).sessionLogout(context);
                            },
                            child: Container(
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text("LOGOUT"),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    }));
  }
}
