import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/screens/pickapp/scanpages/singlescanpage/singleitemviewmodel.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

class Singleitemscanitem extends ConsumerWidget {
  final OrderItemList data;
  final int index;
  final ItemList dataitem;
  const Singleitemscanitem({
    Key? key,
    required this.data,
    required this.index,
    required this.dataitem,
  }) : super(key: key);
// TestSingleItemPO1

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    log(data.quantityorder.toString());
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
    final singleitemModel = watch(singleviewprovider);
    // FocusScope.of(context).requestFocus(singleitemModel.upcFocusNode);
    final upcController = TextEditingController();
    bool isvalid = false;
    final upcScan = TextFormField(
      obscureText: false,
      style: style,
      autofocus: true,
      // focusNode: singleitemModel.upcFocusNode,
      controller: singleitemModel.controller[index],
      onFieldSubmitted: (_) {
        singleitemModel.controller[index].text.isNotEmpty
            ? singleitemModel.checkIsValidUpcNumber(
                    context: context, index: index) &
                singleitemModel.validateAllITEM()
            : null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          suffixIcon: IconButton(
            onPressed: () => {
              singleitemModel.controller[index].text.isNotEmpty
                  ? singleitemModel.checkIsValidUpcNumber(
                          context: context, index: index) &
                      singleitemModel.validateAllITEM()
                  : null
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
                  children: [
                    Text(
                      singleitemModel
                          .getpickdetailsData!.orderItemList[index].upc
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
