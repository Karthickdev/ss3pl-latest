import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/multiscanpage/multi_itemviewmodel.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

class Multiitemscanitem extends ConsumerWidget {
  final OrderItemList data;
  final ItemList dataitem;
  final int index;
  const Multiitemscanitem(
      {Key? key,
      required this.data,
      required this.dataitem,
      required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
    final multiitemmodel = watch(multiviewprovider);
    //FocusScope.of(context).requestFocus(multiitemmodel.upcFocusNode);
    final upcScan = TextFormField(
      obscureText: false,
      style: style,
      autofocus: true,
      //focusNode: multiitemmodel.upcFocusNode,
      controller: multiitemmodel.controller[index],
      onFieldSubmitted: (_) {
        if (multiitemmodel.controller[index].text.isNotEmpty) {
          multiitemmodel.checkIsValidUpcNumber(context: context, index: index);
          multiitemmodel.validateAllITEM();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              errorSnackBar("Upc number cannot be empty or null"));
        }
        if (multiitemmodel.validateequal == true) {
          context.read(multiviewprovider).updateitem(
                context,
              );
          multiitemmodel.clearController();
          multiitemmodel.clearDto();
          //Navigator.pop(context);
        }
        if (multiitemmodel.validatemultiitem == true) {}
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          suffixIcon: IconButton(
            onPressed: () => {
              if (multiitemmodel.controller[index].text.isNotEmpty)
                {
                  multiitemmodel.checkIsValidUpcNumber(
                      context: context, index: index),
                  multiitemmodel.validateAllITEM(),
                }
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      errorSnackBar("Upc number cannot be empty or null"))
                },
              if (multiitemmodel.validateequal == true)
                {
                  context.read(multiviewprovider).updateitem(
                        context,
                      ),
                  multiitemmodel.clearController(),
                  multiitemmodel.clearDto()
                  //Navigator.pop(context);
                },
              if (multiitemmodel.validatemultiitem == true) {}
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
                        '${dataitem.itemName}',
                        style: textStyles.kTextTitle,
                      ),
                    ],
                  ),
                ),
                Sizer.horizontal(),
                SizedBox(
                  width: 200,
                  child: upcScan,
                  // CustomTextFormField(
                  //   maxCount: 24,
                  //   isAutofocus: true,
                  //   hintStyle: textStyles.kTextTitle
                  //       .copyWith(color: colors.kColorBlack),
                  //   controller: multiitemmodel.controller[index],
                  //   errorText: multiitemmodel.upcError,
                  //   isUpperCase: true,
                  //   contentPadding: 4,
                  //   submitField: (_) {},
                  //   suffix: SvgIconButton(
                  //       assetLink: assets.search,
                  //       onPress: () {
                  //         if (multiitemmodel
                  //             .controller[index].text.isNotEmpty) {
                  //           multiitemmodel.checkIsValidUpcNumber(
                  //               context: context, index: index);
                  //           multiitemmodel.validateAllITEM();
                  //         } else {
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //               errorSnackBar(
                  //                   "Upc number cannot be empty or null"));
                  //         }
                  //         if (multiitemmodel.validateequal == true) {
                  //           context.read(multiviewprovider).updateitem(
                  //                 context,
                  //               );
                  //           multiitemmodel.clearController();
                  //           multiitemmodel.clearDto();
                  //           //Navigator.pop(context);
                  //         }
                  //         if (multiitemmodel.validatemultiitem == true) {}
                  //       }),
                  // ),
                ),
                Sizer.horizontal(),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    children: [
                      Text(
                        data.scannedquantity.toString(),
                        style: textStyles.kTextTitle,
                      ),
                      Text(
                        " /",
                        style: textStyles.kTextTitle,
                      ),
                      Text(
                        data.quantityorder.toString(),
                        style: textStyles.kTextTitle,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      multiitemmodel
                          .getpackdetailsData!.orderItemList[index].upc
                          .toString(),
                      style: textStyles.kTextTitle,
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
