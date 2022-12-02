import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/screens/packapp/scanpages/multiscanpage/multi_item_view_model.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/menu_alert%20_packpage%20c.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

import 'packorder_scan_items.dart';

class Packmultiitemscanscreen extends StatefulWidget {
  const Packmultiitemscanscreen({Key? key}) : super(key: key);

  @override
  State<Packmultiitemscanscreen> createState() =>
      _PackmultiitemscanscreenState();
}

class _PackmultiitemscanscreenState extends State<Packmultiitemscanscreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final multieitemmodel = watch(packappmultiviewprovider);
      final poNo = TextFormField(
        obscureText: false,
        style: style,
        autofocus: true,
        // focusNode: multieitemmodel.poFocusNode,
        controller: multieitemmodel.poController,
        onFieldSubmitted: (_) {
          if (multieitemmodel.poController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                errorSnackBar("PO number cannot be empty or null"));
          } else {
            context.read(packappmultiviewprovider).submitpackdetails(
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
                if (multieitemmodel.poController.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        errorSnackBar("PO number cannot be empty or null"))
                  }
                else
                  {
                    context.read(packappmultiviewprovider).submitpackdetails(
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
              backgroundColor: colors.kColorgrey,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "MULTI ITEM SCAN",
                    style: textStyles.kResetpassword
                        .copyWith(color: colors.kColorBlack),
                  ),
                ],
              ),
              leading: SvgIconButton(
                  assetLink: assets.homeicon,
                  height: 40,
                  onPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              title: const AlertDialogHeaderpackapp(),
                              content: const AlertDialogBodypackapp(
                                logoutMessage:
                                    'Are you sure, Do you want to clear data and go home?',
                              ),
                            ));
                  }),
              //   if (multieitemmodel.validateequal == true) {
              //       context.read(packappsingleviewprovider).updateitemfinal(
              //         context,
              //       );
              //       }showDialog(
              //       context: context,
              //       builder: (BuildContext context) => AlertDialog(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //             title: const AlertDialogHeaderpackapp(),
              //             content: const AlertDialogBodypackapp(
              //               logoutMessage:
              //                   'Are you sure, Do you want to clear data and go home?',
              //             ),
              //           )),
              //
              // ),
              actions: const [
                Svgbutton(),
              ],
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizes.smallPadding),
                      child: Column(
                        children: [
                          const Sizer(),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: const [Text("PO#")],
                          // ),
                          // const Sizer(),
                          // CustomTextFormField(
                          //     hintText: 'PO NUMBER',
                          //     isAutofocus: true,
                          //     maxCount: 24,
                          //     textInputFormatter: [
                          //       FilteringTextInputFormatter.allow(
                          //           RegExp("[a-zA-Z0-9 !@#%^&*_+-=)]"))
                          //     ],
                          //     hintStyle: textStyles.kTextTitle
                          //         .copyWith(color: colors.kColorBlack),
                          //     controller: multieitemmodel.poController,
                          //     errorText: multieitemmodel.upcError,
                          //     isUpperCase: false,
                          //     submitField: (_) {},
                          //     suffix: SvgIconButton(
                          //         loading: multieitemmodel.loading,
                          //         assetLink: assets.search,
                          //         onPress: () {
                          //           if (multieitemmodel
                          //               .poController.text.isEmpty) {
                          //             ScaffoldMessenger.of(context)
                          //                 .showSnackBar(errorSnackBar(
                          //                     "PO number cannot be empty or null"));
                          //           } else {
                          //             context
                          //                 .read(packappmultiviewprovider)
                          //                 .submitpackdetails(
                          //                   context,
                          //                 );
                          //           }
                          //         })),
                          poNo,
                          Sizer.vertical20(),
                          const Multiitemscantext(),
                          Sizer.vertical20(),
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
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  maxLines: 6,
                  readOnly: true,
                  controller: multieitemmodel.eventLogController,
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
    final multiitemModel = watch(packappmultiviewprovider);
    return Expanded(
        child: multiitemModel.getpackdetailsData == null ||
                multiitemModel.getpackdetailsData!.itemList.isEmpty
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
                    itemCount:
                        multiitemModel.getpackdetailsData!.itemList.length + 1,
                    itemBuilder: (context, index) {
                      return index ==
                              multiitemModel.getpackdetailsData!.itemList.length
                          ? Container()
                          : Multiitemscanitem(
                              data: multiitemModel
                                  .getpackdetailsData!.orderItemList[index],
                              index: index,
                              itemdata: multiitemModel
                                  .getpackdetailsData!.itemList[index],
                            );
                    }),
              ));
  }
}

// class Svgbutton extends ConsumerWidget {
//   const Svgbutton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final multiitemModel = watch(packappmultiviewprovider);
//     return Center(
//       child: multiitemModel.loading || multiitemModel.getupdatescanData == null
//           ? const SizedBox(
//               height: 10,
//               width: 1,
//             )
//           : SvgIconButton(
//               onPress: () {},
//               // onPress: () => showDialog(
//               //     context: context,
//               //     builder: (BuildContext context) => AlertDialog(
//               //           shape: RoundedRectangleBorder(
//               //             borderRadius: BorderRadius.circular(20.0),
//               //           ),
//               //           title: const AlertDialogHeaderpackapp(),
//               //           content: const AlertDialogBodypackapp(
//               //             logoutMessage:
//               //                 'Are you sure, Do you want to clear data and go home?',
//               //           ),
//               //         )),

//               assetLink: assets.printer,
//               height: 40,
//             ),
//     );
//   }
// }
class Svgbutton extends ConsumerWidget {
  const Svgbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final multiitemModel = watch(packappmultiviewprovider);
    return Center(
      child: multiitemModel.isavailable == false
          ? const SizedBox(
              height: 10,
              width: 1,
            )
          : SvgIconButton(
              onPress: () {
                multiitemModel.validateapi = true;
                Navigator.pushNamed(context, Routes.multiitemprinter);
              },
              assetLink: assets.printer,
              height: 40,
            ),
    );
  }
}

class POItemListHeader extends ConsumerWidget {
  const POItemListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: unused_local_variable
    final multiitemModel = watch(packappmultiviewprovider);
    return multiitemModel.getpackdetailsData == null ||
            multiitemModel.getpackdetailsData!.itemList.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              const Divider(
                thickness: 1,
                height: 1,
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
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                          ' Packed /',
                                          style: textStyles.kTextTitle,
                                        ),
                                        Text(
                                          'Unpacked',
                                          style: textStyles.kTextTitle,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'UPC Number',
                                          style: textStyles.kTextTitle,
                                        ),
                                      ],
                                    ),
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

class Multiitemscantext extends ConsumerWidget {
  const Multiitemscantext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final multiitemModel = watch(packappmultiviewprovider);
    return Column(
      children: [
        multiitemModel.getpackdetailsData == null ||
                multiitemModel.getpackdetailsData!.itemList.isEmpty
            ? Container()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("PO #",
                                    style: textStyles.kTextAppBarActionText),
                                Sizer.horizontal(),
                                Text(
                                  (multiitemModel.getpackdetailsData == null ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .purchaseOrderNumber
                                              .toString()
                                              .isEmpty
                                      ? '--'
                                      : "${multiitemModel.getpackdetailsData!.purchaseOrderNumber}"),
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                                Sizer.horizontal64(),
                                Text("ORDER DATE",
                                    style: textStyles.kTextAppBarActionText),
                                Sizer.horizontal(),
                                Text(
                                  (multiitemModel.getpackdetailsData == null ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .orderCreatedDateString
                                              .toString()
                                              .isEmpty
                                      ? '--'
                                      : multiitemModel.getpackdetailsData!
                                          .orderCreatedDateString!),
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Sizer.vertical20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("CARRIER / METHOD",
                          style: textStyles.kTextAppBarActionText),
                      Sizer.horizontal32(),
                      Text(
                        (multiitemModel.getpackdetailsData == null ||
                                multiitemModel
                                    .getpackdetailsData!.shippingCarrier
                                    .toString()
                                    .isEmpty
                            ? "--"
                            : " ${multiitemModel.getpackdetailsData!.shippingCarrier} / ${multiitemModel.getpackdetailsData!.shippingMethodString}"),
                        style: textStyles.kTextlogin1
                            .copyWith(color: colors.kColorgrey),
                      ),
                    ],
                  ),
                  Sizer.vertical20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("SHIP TO ADDRESS",
                              style: textStyles.kTextAppBarActionText),
                        ],
                      ),
                      Sizer.horizontal48(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  multiitemModel.getpackdetailsData == null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.name1
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : "${multiitemModel.getpackdetailsData!.shipToAddress.name1} / ${multiitemModel.getpackdetailsData!.shippingMethodString}",
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                                Sizer.halfHorizontal(),
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.name2
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.name2!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.address1
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.address1!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.city
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.city!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                                Sizer.halfHorizontal(),
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.stateText
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.stateText!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                                Sizer.halfHorizontal(),
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.postalCode
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.postalCode!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.phone
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.phone!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  multiitemModel.loading ||
                                          multiitemModel.getpackdetailsData ==
                                              null ||
                                          multiitemModel.getpackdetailsData!
                                              .shipToAddress.email
                                              .toString()
                                              .isEmpty
                                      ? ""
                                      : multiitemModel.getpackdetailsData!
                                          .shipToAddress.email!,
                                  style: textStyles.kTextlogin1
                                      .copyWith(color: colors.kColorgrey),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ],
    );
  }
}
