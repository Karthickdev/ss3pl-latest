import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/singlescanpage/singleitemviewmodel.dart';
import 'package:southshore3pl/screens/tracking_scan_screen/tracking_orderitem.dart';
import 'package:southshore3pl/util/sizer.dart';

class Trackingnumberscanscreen extends StatefulWidget {
  final GetPickOrderitemDetails data;
  const Trackingnumberscanscreen({Key? key, required this.data})
      : super(key: key);

  @override
  State<Trackingnumberscanscreen> createState() =>
      _TrackingnumberscanscreenState();
}

class _TrackingnumberscanscreenState extends State<Trackingnumberscanscreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final singleitemmodel = watch(singleviewprovider);
      return SafeArea(
        child: Scaffold(
          backgroundColor: colors.kColorWhite,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              centerTitle: true,
              backgroundColor: colors.KColorblue,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TRACKING NUMBER SCAN",
                    style: textStyles.kResetpassword
                        .copyWith(color: colors.kColorBlack),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: sizes.mediumPadding),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizes.mediumPadding,
                            vertical: sizes.largerPadding),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "PO # :",
                                  style: textStyles.kTextAppBarTitle,
                                ),
                                Sizer.horizontal32(),
                                Text(widget.data.purchaseOrderNumber!),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Sizer(),
                      Padding(
                          padding: EdgeInsets.all(sizes.smallPadding),
                          child: POItemListHeader(
                            data: widget.data,
                          )),
                      POItemsList(
                        data: widget.data,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  maxLines: 6,
                  readOnly: true,
                  controller: singleitemmodel.eventLogController,
                  decoration: InputDecoration(
                      labelText: "Event Log",
                      hintText: "Event Log",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                )),
          ),
        ),
      );
    });
  }
}

class POItemsList extends ConsumerWidget {
  final GetPickOrderitemDetails data;
  const POItemsList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Expanded(
      child: data.orderItemList.isEmpty
          ? Container(
              height: sizes.height,
            )
          : SizedBox(
              height: sizes.height / 1.2,
              width: sizes.width / 1.04,
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1,
                      height: 1,
                    );
                  },
                  itemCount: data.orderItemList.length + 1,
                  itemBuilder: (context, index) {
                    return index == data.orderItemList.length
                        ? Container()
                        : Trackingscanitem(
                            data: data.orderPackageList[index],
                            dataitem: data.itemList[index],
                            index: index);
                  }),
            ),
    );
  }
}

class POItemListHeader extends ConsumerWidget {
  final GetPickOrderitemDetails data;
  const POItemListHeader({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    log(data.itemList[0].itemName.toString());
    return data.itemList.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              const Divider(
                thickness: 1,
                height: 1,
              ),
              const VerticalDivider(
                thickness: 2,
              ),
              SizedBox(
                height: sizes.height / 25,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: sizes.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tracking Number String',
                                        style: textStyles.kTextTitle,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Tracking number',
                                style: textStyles.kTextTitle,
                              )
                            ],
                          )),
                          Expanded(
                            child: SizedBox(
                              width: sizes.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Status',
                                        style: textStyles.kTextTitle,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                height: 1,
              )
            ],
          );
  }
}
