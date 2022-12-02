import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/multiscanpage/multi_itemviewmodel.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/multiscanpage/pickorder_scan_items.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/menu_alert%20_pickpage.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

class Multiitemscanscreen extends StatefulWidget {
  const Multiitemscanscreen({Key? key}) : super(key: key);

  @override
  State<Multiitemscanscreen> createState() => _MultiitemscanscreenState();
}

class _MultiitemscanscreenState extends State<Multiitemscanscreen> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final multieitemmodel = watch(multiviewprovider);
      final poNo = TextFormField(
        obscureText: false,
        style: style,
        autofocus: true,
        // focusNode: multieitemmodel.poFocusNode,
        controller: multieitemmodel.poController,
        onFieldSubmitted: (_) {
          if (multieitemmodel.poController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                errorSnackBar("PO number cannot be empty or null "));
          } else {
            //FocusScope.of(context).requestFocus(multieitemmodel.upcFocusNode);
            context.read(multiviewprovider).submitpackdetails(
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
                        errorSnackBar("PO number cannot be empty or null "))
                  }
                else
                  {
                    // FocusScope.of(context)
                    //     .requestFocus(multieitemmodel.upcFocusNode),
                    context.read(multiviewprovider).submitpackdetails(
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
                      {
                        if (multieitemmodel.loading == false) {
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
                      }
                    })),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: const [Text("PO #")],
                      // ),
                      // const Sizer(),
                      // CustomTextFormField(
                      //     hintText: 'PO NUMBER',
                      //     isAutofocus: true,
                      //     maxCount: 24,
                      //     textInputFormatter: [
                      //       FilteringTextInputFormatter.allow(
                      //           RegExp("[a-zA-Z0-9 !@#%^&*-_+=)]"))
                      //     ],
                      //     hintStyle: textStyles.kTextTitle
                      //         .copyWith(color: colors.kColorBlack),
                      //     controller: multieitemmodel.poController,
                      //     errorText: multieitemmodel.poError,
                      //     isUpperCase: false,
                      //     submitField: (_) {},
                      //     suffix: SvgIconButton(
                      //         loading: multieitemmodel.loading,
                      //         assetLink: assets.search,
                      //         onPress: () {
                      //           if (multieitemmodel.poController.text.isEmpty) {
                      //             ScaffoldMessenger.of(context).showSnackBar(
                      //                 errorSnackBar(
                      //                     "PO number cannot be empty or null "));
                      //           } else {
                      //             context
                      //                 .read(multiviewprovider)
                      //                 .submitpackdetails(
                      //                   context,
                      //                 );
                      //           }
                      //         })),
                      poNo,
                      Sizer.vertical20(),
                      // const Multiitemscantext(),
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
    final multiitemModel = watch(multiviewprovider);
    return Expanded(
        child: multiitemModel.getpackdetailsData == null ||
                multiitemModel.getpackdetailsData!.itemList == null ||
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
                    itemCount: multiitemModel
                            .getpackdetailsData!.orderItemList.length +
                        1,
                    itemBuilder: (context, index) {
                      return index ==
                              multiitemModel
                                  .getpackdetailsData!.orderItemList.length
                          ? Container()
                          : Multiitemscanitem(
                              data: multiitemModel
                                  .getpackdetailsData!.orderItemList[index],
                              dataitem: multiitemModel
                                  .getpackdetailsData!.itemList[index],
                              index: index,
                            );
                    }),
              ));
  }
}
// class POItemsList extends ConsumerWidget {
//   const POItemsList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {

//     final SingleitemModel = watch(Singleviewprovider);
//     return Expanded(
//         child: SingleitemModel.loading ||
//                 SingleitemModel.poreceiveItem == null ||
//                 SingleitemModel.poreceiveItem!.data == null ||
//                 SingleitemModel.poreceiveItem!.data!.purchaseOrderItems ==
//                     null ||
//                 SingleitemModel
//                     .poreceiveItem!.data!.purchaseOrderItems!.isEmpty
//             ? Container(
//                 height: sizes.height,
//               )
//             :
//              Container(
//                 height: sizes.height,
//                 child: ListView.separated(
//                     separatorBuilder: (context, index) {
//                       return Divider(
//                         thickness: 1,
//                         height: 1,
//                       );
//                     },
//                     itemCount: poReceiveProvide
//                             .poreceiveItem!.data!.purchaseOrderItems!.length +
//                         1,
//                     itemBuilder: (context, index) {
//                       return index ==
//                               poReceiveProvide.poreceiveItem!.data!
//                                   .purchaseOrderItems!.length
//                           ? Container()
//                           : POReceiveItem(
//                               data: poReceiveProvide.poreceiveItem!.data!
//                                   .purchaseOrderItems![index],
//                             );
//                     }),
//               ));
//   }
// }

class POItemListHeader extends ConsumerWidget {
  const POItemListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ignore: unused_local_variable
    final multiitemModel = watch(multiviewprovider);
    return multiitemModel.getpackdetailsData == null ||
            multiitemModel.getpackdetailsData!.itemList == null ||
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
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: sizes.smallPadding),
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
    final multiitemModel = watch(multiviewprovider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("PO ", style: textStyles.kTextAppBarActionText),
            Sizer.halfHorizontal(),
            Text(
              (multiitemModel.getpackdetailsData == null ||
                      multiitemModel.getpackdetailsData == null ||
                      multiitemModel.getpackdetailsData!.purchaseOrderNumber
                          .toString()
                          .isEmpty
                  ? '--'
                  : "${multiitemModel.getpackdetailsData!.purchaseOrderNumber}"),
              style: textStyles.kTextlogin1.copyWith(color: colors.kColorgrey),
            ),
            Sizer.horizontal24(),
            Text("ORDER DATE", style: textStyles.kTextAppBarActionText),
            Sizer.halfHorizontal(),
            Text(
              (multiitemModel.getpackdetailsData == null ||
                      multiitemModel.getpackdetailsData == null ||
                      multiitemModel.getpackdetailsData!.orderCreatedDateString
                          .toString()
                          .isEmpty
                  ? '--'
                  : "${multiitemModel.getpackdetailsData!.orderCreatedDateString}"),
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
              (multiitemModel.getpackdetailsData == null ||
                      multiitemModel.getpackdetailsData == null ||
                      multiitemModel.getpackdetailsData!.shipMethodEnumValue
                          .toString()
                          .isEmpty
                  ? '--'
                  : "${multiitemModel.getpackdetailsData!.orderId}"),
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
                  (multiitemModel.getpackdetailsData == null ||
                          multiitemModel.getpackdetailsData == null ||
                          multiitemModel.getpackdetailsData!.shipToAddress
                              .toString()
                              .isEmpty
                      ? '--'
                      : "${multiitemModel.getpackdetailsData!.shipToAddress}"),
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
