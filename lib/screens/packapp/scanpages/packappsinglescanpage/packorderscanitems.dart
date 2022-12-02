import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packappsinglescanpage/packappsingle_itemscanscreen.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packappsinglescanpage/packappsingle_itemviewmodel.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

class Singleitempackscanitem extends ConsumerWidget {
  final OrderItemList data;
  final int index;
  final ItemList dataitem;
  const Singleitempackscanitem(
      {Key? key,
      required this.data,
      required this.index,
      required this.dataitem})
      : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final singleitemmodel = watch(packappsingleviewprovider);
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
    // FocusScope.of(context).requestFocus(singleitemmodel.upcFocusNode);
    singleitemmodel.upcFocusNode.requestFocus();
    final upcScan = TextFormField(
      obscureText: false,
      style: style,
      autofocus: true,
      focusNode: singleitemmodel.upcFocusNode,
      controller: singleitemmodel.controller[index],
      onFieldSubmitted: (_) {
        if (data.quantityorder != "0") {
          if (singleitemmodel.controller[index].text.isNotEmpty) {
            singleitemmodel.checkIsValidUpcNumber(
                context: context, index: index);
            singleitemmodel.validateAllITEM();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                errorSnackBar("Upc number cannot be empty or null"));
          }
          if (singleitemmodel.validateequal == true) {
            context.read(packappsingleviewprovider).updateitem(
                  context,
                );
          }
        }
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          suffixIcon: IconButton(
            onPressed: () => {
              if (data.quantityorder != "0")
                {
                  if (singleitemmodel.controller[index].text.isNotEmpty)
                    {
                      singleitemmodel.checkIsValidUpcNumber(
                          context: context, index: index),
                      singleitemmodel.validateAllITEM()
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                          errorSnackBar("Upc number cannot be empty or null"))
                    },
                  if (singleitemmodel.validateequal == true)
                    {
                      context.read(packappsingleviewprovider).updateitem(
                            context,
                          )
                    }
                }
            },
            icon: Icon(Icons.search),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );
    bool isvalid = false;
    return Padding(
      padding: EdgeInsets.all(sizes.smallPadding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${dataitem.itemName}',
                            style: textStyles.kTextTitle.copyWith(
                                color: data.quantityorder == "0"
                                    ? colors.kColorGreenButton
                                    : colors.kColorBlack),
                          ),
                        ],
                      ),
                    ),
                    Sizer.horizontal(),
                    SizedBox(
                      width: 200,
                      child:
                          // CustomTextFormField(
                          //   maxCount: 24,
                          //   isAutofocus: true,
                          //   hintStyle: textStyles.kTextTitle
                          //       .copyWith(color: colors.kColorBlack),
                          //   controller: singleitemmodel.controller[index],
                          //   errorText: singleitemmodel.upcError,
                          //   isUpperCase: true,
                          //   isBorder: true,
                          //   submitField: (_) {
                          //     if (data.quantityorder != "0") {
                          //       if (singleitemmodel.controller[index].text.isNotEmpty) {
                          //         singleitemmodel.checkIsValidUpcNumber(
                          //             context: context, index: index);
                          //         singleitemmodel.validateAllITEM();
                          //       } else {
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //             errorSnackBar(
                          //                 "Upc number cannot be empty or null"));
                          //       }
                          //       if (singleitemmodel.validateequal == true) {
                          //         context.read(packappsingleviewprovider).updateitem(
                          //               context,
                          //             );
                          //       }
                          //     }
                          //   },
                          //   focusColor: data.quantityorder == "0"
                          //       ? colors.kColorgrey.withOpacity(0.5)
                          //       : colors.KColorblue,
                          //   // !orderWindowModel.sell ? colors.kColorGreen : colors.kColorRed,
                          //   contentPadding: 4,
                          //   // isAliveBorder: true,
                          //   isReadOnly: data.quantityorder == "0" ? true : false,
                          //   suffix: SvgIconButton(
                          //       assetLink: assets.search,
                          //       color: data.quantityorder == "0"
                          //           ? colors.kColorgrey.withOpacity(0.5)
                          //           : colors.kColorBlack,
                          //       onPress: () {
                          //         if (data.quantityorder != "0") {
                          //           if (singleitemmodel
                          //               .controller[index].text.isNotEmpty) {
                          //             singleitemmodel.checkIsValidUpcNumber(
                          //                 context: context, index: index);
                          //             singleitemmodel.validateAllITEM();
                          //           } else {
                          //             ScaffoldMessenger.of(context).showSnackBar(
                          //                 errorSnackBar(
                          //                     "Upc number cannot be empty or null"));
                          //           }
                          //           if (singleitemmodel.validateequal == true) {
                          //             context
                          //                 .read(packappsingleviewprovider)
                          //                 .updateitem(
                          //                   context,
                          //                 );
                          //           }
                          //         }
                          //       }),
                          // ),
                          upcScan,
                    ),
                    Sizer.horizontal(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        children: [
                          Text(
                            data.scannedquantity.toString(),
                            style: textStyles.kTextTitle.copyWith(
                                color: data.quantityorder == "0"
                                    ? colors.kColorGreenButton
                                    : colors.kColorBlack),
                          ),
                          Text(
                            " /",
                            style: textStyles.kTextTitle.copyWith(
                                color: data.quantityorder == "0"
                                    ? colors.kColorGreenButton
                                    : colors.kColorBlack),
                          ),
                          Text(
                            data.quantityorder.toString(),
                            style: textStyles.kTextTitle.copyWith(
                                color: data.quantityorder == "0"
                                    ? colors.kColorGreenButton
                                    : colors.kColorBlack),
                          ),
                        ],
                      ),
                    ),
                    Column(children: [
                      Row(
                        children: [
                          Text(
                            singleitemmodel
                                .getpackdetailsData!.orderItemList[index].upc
                                .toString(),
                            style: textStyles.kTextTitle.copyWith(
                                color: data.quantityorder == "0"
                                    ? colors.kColorGreenButton
                                    : colors.kColorBlack),
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
              )),
            ],
          ),

          //   )
          // ],
          // )
        ],
      ),
    );
  }
}
