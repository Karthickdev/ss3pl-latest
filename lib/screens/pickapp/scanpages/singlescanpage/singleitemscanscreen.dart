import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/singlescanpage/pickorderscanitems.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/singlescanpage/singleitemviewmodel.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/menu_alert%20_pickpage.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

// class Singleitemscanscreen extends ConsumerWidget {
//   const Singleitemscanscreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
class Singleitemscanscreen extends StatefulWidget {
  const Singleitemscanscreen({Key? key}) : super(key: key);

  @override
  State<Singleitemscanscreen> createState() => _SingleitemscanscreenState();
}

class _SingleitemscanscreenState extends State<Singleitemscanscreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  final poController = TextEditingController();
  // void getPoDetails(String) async {
  //   if (singleitemmodel.poController.text.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(errorSnackBar("PO number cannot be empty or null "));
  //   } else {
  //     context.read(singleviewprovider).submitpackdetails(
  //           context,
  //         );
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final singleitemmodel = watch(singleviewprovider);
      // FocusScope.of(context).requestFocus(singleitemmodel.poFocusNode);
      final poNo = TextFormField(
        obscureText: false,
        style: style,
        autofocus: true,
        // focusNode: singleitemmodel.poFocusNode,
        controller: singleitemmodel.poController,
        onFieldSubmitted: (_) {
          if (singleitemmodel.poController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                errorSnackBar("PO number cannot be empty or null "));
          } else {
            // FocusScope.of(context).requestFocus(singleitemmodel.upcFocusNode);
            context.read(singleviewprovider).submitpackdetails(
                  context,
                );
          }
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "PO #",
            labelText: 'PO #',
            suffixIcon: IconButton(
              onPressed: () => {
                if (singleitemmodel.poController.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        errorSnackBar("PO number cannot be empty or null "))
                  }
                else
                  {
                    // FocusScope.of(context)
                    //     .requestFocus(singleitemmodel.upcFocusNode),
                    context.read(singleviewprovider).submitpackdetails(
                          context,
                        )
                  }
              },
              icon: Icon(Icons.search),
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      );
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
                    "SINGLE ITEM SCAN",
                    style: textStyles.kResetpassword
                        .copyWith(color: colors.kColorBlack),
                  ),
                ],
              ),
              leading: SvgIconButton(
                  assetLink: assets.homeicon,
                  height: 40,
                  onPress: () {
                    if (singleitemmodel.loading == false) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                title: const AlertDialogHeaderpickapp(),
                                content: const AlertDialogBodypickapp(
                                  logoutMessage:
                                      'Are you sure, Do you want to clear data and go home?',
                                ),
                              ));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(errorSnackBar("PLEASE WAIT...."));
                    }
                  }),
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
                      const Sizer(),
                      poNo,
                      Sizer.vertical48(),
                      Padding(
                          padding: EdgeInsets.all(sizes.smallPadding),
                          child: const POItemListHeader()),
                      const POItemsList(),
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
  const POItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final singleitemModel = watch(singleviewprovider);
    return Expanded(
        child: singleitemModel.getpickdetailsData == null ||
                singleitemModel.getpickdetailsData!.orderItemList == null ||
                singleitemModel.getpickdetailsData!.orderItemList.isEmpty
            ? Container(
                height: sizes.height,
              )
            : SizedBox(
                height: sizes.height,
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 1,
                        height: 1,
                      );
                    },
                    itemCount: singleitemModel
                            .getpickdetailsData!.orderItemList.length +
                        1,
                    itemBuilder: (context, index) {
                      return index ==
                              singleitemModel
                                  .getpickdetailsData!.orderItemList.length
                          ? Container()
                          : Singleitemscanitem(
                              data: singleitemModel
                                  .getpickdetailsData!.orderItemList[index],
                              dataitem: singleitemModel
                                  .getpickdetailsData!.itemList[index],
                              index: index);
                    }),
              ));
  }
}

class POItemListHeader extends ConsumerWidget {
  const POItemListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final singleitemModel = watch(singleviewprovider);
    return singleitemModel.getpickdetailsData == null ||
            singleitemModel.getpickdetailsData!.itemList == null ||
            singleitemModel.getpickdetailsData!.itemList.isEmpty
        //  ||
        // singleitemModel.getpickdetailsData!.itemList!.length > 1
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
              Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item Name',
                                      style: textStyles.kTextTitle,
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Upc',
                                      style: textStyles.kTextTitle,
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Qty',
                                            style: textStyles.kTextTitle,
                                          ),
                                          Text(
                                            ' Picked /',
                                            style: textStyles.kTextTitle,
                                          ),
                                          Text(
                                            'Unpicked',
                                            style: textStyles.kTextTitle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'UPC Number',
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
              const Divider(
                thickness: 1,
                height: 1,
              )
            ],
          );
  }
}

class Singleitemscantext extends ConsumerWidget {
  const Singleitemscantext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final singleitemModel = watch(singleviewprovider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("PO ", style: textStyles.kTextAppBarActionText),
            Sizer.halfHorizontal(),
            Text(
              (singleitemModel.getpickdetailsData == null ||
                      singleitemModel.getpickdetailsData == null ||
                      singleitemModel.getpickdetailsData!.purchaseOrderNumber
                          .toString()
                          .isEmpty
                  ? '--'
                  : "${singleitemModel.getpickdetailsData!.purchaseOrderNumber}"),
              style: textStyles.kTextlogin1.copyWith(color: colors.kColorgrey),
            ),
            Sizer.horizontal24(),
            Text("ORDER DATE", style: textStyles.kTextAppBarActionText),
            Sizer.halfHorizontal(),
            Text(
              (singleitemModel.getpickdetailsData == null ||
                      singleitemModel.getpickdetailsData == null ||
                      singleitemModel.getpickdetailsData!.orderCreatedDateString
                          .toString()
                          .isEmpty
                  ? '--'
                  : "${singleitemModel.getpickdetailsData!.orderCreatedDateString}"),
              style: textStyles.kTextlogin1.copyWith(color: colors.kColorgrey),
            ),
          ],
        ),
        Sizer.vertical20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("SHIPPING CARRIER AND METHOD",
                style: textStyles.kTextAppBarActionText),
            Sizer.horizontal48(),
            Text(
              (singleitemModel.getpickdetailsData == null ||
                      singleitemModel.getpickdetailsData == null ||
                      singleitemModel.getpickdetailsData!.shipMethodEnumValue
                          .toString()
                          .isEmpty
                  ? '--'
                  : "${singleitemModel.getpickdetailsData!.orderId}"),
              style: textStyles.kTextlogin1.copyWith(color: colors.kColorgrey),
            ),
          ],
        ),
        Sizer.vertical24(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("SHIPPING ADDRESS", style: textStyles.kTextAppBarActionText),
            Sizer.horizontal(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (singleitemModel.getpickdetailsData == null ||
                          singleitemModel.getpickdetailsData == null ||
                          singleitemModel.getpickdetailsData!.shipToAddress
                              .toString()
                              .isEmpty
                      ? '--'
                      : "${singleitemModel.getpickdetailsData!.shipToAddress}"),
                  style:
                      textStyles.kTextlogin1.copyWith(color: colors.kColorgrey),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
