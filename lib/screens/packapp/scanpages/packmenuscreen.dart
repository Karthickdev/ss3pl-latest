import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/util/sizer.dart';

class PackmenuScreen extends StatefulWidget {
  const PackmenuScreen({Key? key}) : super(key: key);

  @override
  State<PackmenuScreen> createState() => _PackmenuScreenState();
}

class _PackmenuScreenState extends State<PackmenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return SafeArea(
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
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: sizes.semiLargePadding),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizes.extraLargePadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Sizer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: SvgPicture.asset(
                                    assets.scanlogo,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colors.kcolorappbarSingleitemscan),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: colors.KColorblue,
                                ),
                              ),
                              Sizer.halfHorizontal(),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.singleitempackscanscreen),
                                child: Container(
                                    height: 150,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: colors.KColorblue,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "SINGLE ITEM ORDER SCAN",
                                          style: textStyles.kTextButton,
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                          Sizer.vertical20(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10, left: 10),
                                  child: SvgPicture.asset(
                                    assets.scanlogo,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: colors.kColorgrey),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: colors.kColorgrey,
                                ),
                              ),
                              Sizer.halfHorizontal(),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, Routes.packmultiitemscanscreen),
                                child: Container(
                                    height: 150,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: colors.kColorgrey,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "MULTI ITEM ORDER SCAN",
                                          style: textStyles.kTextButton,
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                          Sizer.vertical48(),
                          Padding(
                            padding: const EdgeInsets.only(right: 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("BACK"),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
