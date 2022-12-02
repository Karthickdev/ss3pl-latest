import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/screens/packapp/scanpages/multiscanpage/multi_item_view_model.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

class Multiitemscanitem extends ConsumerWidget {
  final OrderItemList data;
  final int index;
  final ItemList itemdata;
  const Multiitemscanitem(
      {Key? key,
      required this.data,
      required this.index,
      required this.itemdata})
      : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
    final packappmultiitemmodel = watch(packappmultiviewprovider);
    final upcScan = TextFormField(
      obscureText: false,
      style: style,
      autofocus: true,
      controller: packappmultiitemmodel.controller[index],
      onFieldSubmitted: (_) {
        if (packappmultiitemmodel.controller[index].text.isNotEmpty) {
          packappmultiitemmodel.checkIsValidUpcNumber(
              context: context, index: index);
          packappmultiitemmodel.validateAllITEM();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              errorSnackBar("Upc number cannot be empty or null "));
        }
        if (packappmultiitemmodel.validateequal == true) {
          context.read(packappmultiviewprovider).updateitem(
                context,
              );
        }
        if (packappmultiitemmodel.validatemultiitem == true) {}
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          suffixIcon: IconButton(
            onPressed: () => {
              if (packappmultiitemmodel.controller[index].text.isNotEmpty)
                {
                  packappmultiitemmodel.checkIsValidUpcNumber(
                      context: context, index: index),
                  packappmultiitemmodel.validateAllITEM()
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      errorSnackBar("Upc number cannot be empty or null "))
                },
              if (packappmultiitemmodel.validateequal == true)
                {
                  context.read(packappmultiviewprovider).updateitem(
                        context,
                      )
                },
              if (packappmultiitemmodel.validatemultiitem == true) {}
            },
            icon: Icon(Icons.search),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );
    return Padding(
      padding: EdgeInsets.all(sizes.smallPadding),
      child: Row(
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
                        '${itemdata.itemName}',
                        style: textStyles.kTextTitle.copyWith(
                            color:
                                // data.quantityorder == "0"
                                //     ? colors.kColorGreenButton
                                //     :
                                colors.kColorBlack),
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
                      //   controller: packappmultiitemmodel.controller[index],
                      //   errorText: packappmultiitemmodel.upcError,
                      //   isUpperCase: true,
                      //   contentPadding: 4,
                      //   submitField: (_) {},
                      //   suffix: SvgIconButton(
                      //       assetLink: assets.search,
                      //       onPress: () {
                      //         if (packappmultiitemmodel
                      //             .controller[index].text.isNotEmpty) {
                      //           packappmultiitemmodel.checkIsValidUpcNumber(
                      //               context: context, index: index);
                      //           packappmultiitemmodel.validateAllITEM();
                      //         } else {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //               errorSnackBar(
                      //                   "Upc number cannot be empty or null "));
                      //         }
                      //         if (packappmultiitemmodel.validateequal == true) {
                      //           context.read(packappmultiviewprovider).updateitem(
                      //                 context,
                      //               );
                      //         }
                      //         if (packappmultiitemmodel.validatemultiitem ==
                      //             true) {}
                      //       }),
                      // ),
                      upcScan,
                ),
                Sizer.horizontal(),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    children: [
                      Text(
                        data.scannedquantity.toString(),
                        style: textStyles.kTextTitle.copyWith(
                            color:
                                // data.quantityorder == "0"
                                //     ? colors.kColorGreenButton
                                //     :
                                colors.kColorBlack),
                      ),
                      Text(
                        " /",
                        style: textStyles.kTextTitle,
                      ),
                      Text(
                        data.quantityorder.toString(),
                        style: textStyles.kTextTitle.copyWith(
                            color:
                                // data.quantityorder == "0"
                                //     ? colors.kColorGreenButton
                                //     :
                                colors.kColorBlack),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      packappmultiitemmodel
                          .getpackdetailsData!.orderItemList[index].upc
                          .toString(),
                      style: textStyles.kTextTitle
                          .copyWith(color: colors.kColorBlack),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
