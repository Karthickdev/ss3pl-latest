import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/models/getorderpickitemdetails_response.dart';
import 'package:southshore3pl/screens/packapp/scanpages/packappsinglescanpage/packappsingle_itemviewmodel.dart';
import 'package:southshore3pl/shared_widgets/custom_text_form_field.dart';
import 'package:southshore3pl/shared_widgets/snack_bar.dart';
import 'package:southshore3pl/shared_widgets/svg_icon_button.dart';
import 'package:southshore3pl/util/sizer.dart';

class Trackingscanitem extends ConsumerWidget {
  final OrderPackageList data;
  final int index;
  final ItemList dataitem;
  const Trackingscanitem(
      {Key? key,
      required this.data,
      required this.index,
      required this.dataitem})
      : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
    final trackingmodel = watch(packappsingleviewprovider);
    // FocusScope.of(context).requestFocus(FocusNode());
    // FocusScope.of(context).requestFocus(trackingmodel.trackingNode);
    final upcScan = TextFormField(
      obscureText: false,
      style: style,
      autofocus: true,
      readOnly: false,
      keyboardType: TextInputType.text,
      enabled: true,
      focusNode: trackingmodel.trackingNode,
      controller: trackingmodel.trackingcontroller[index],
      onFieldSubmitted: (_) {
        if (data.trackingpagescan != "Scanned") {
          if (trackingmodel.trackingcontroller[index].text.isNotEmpty) {
            trackingmodel.checkIsValidTrackingNumber(
                index: index, context: context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                errorSnackBar("Tracking number cannot be empty or null"));
          }
        }
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          suffixIcon: IconButton(
            onPressed: () => {
              if (data.trackingpagescan != "Scanned")
                {
                  if (trackingmodel.trackingcontroller[index].text.isNotEmpty)
                    {
                      trackingmodel.checkIsValidTrackingNumber(
                          index: index, context: context)
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(
                          "Tracking number cannot be empty or null"))
                    }
                }
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.trackingNumber!,
                        style: textStyles.kTextTitle.copyWith(
                            color: data.trackingpagescan == "Scanned"
                                ? colors.kColorGreenButton
                                : colors.kColorBlack),
                      ),
                    ],
                  ),
                ),
                Sizer.horizontal(),
                Expanded(
                    //width: 200,
                    child:
                        // CustomTextFormField(
                        //   maxCount: 24,
                        //   isAutofocus: true,
                        //   hintStyle: textStyles.kTextTitle
                        //       .copyWith(color: colors.kColorBlack),
                        //   controller: trackingmodel.trackingcontroller[index],
                        //   errorText: trackingmodel.trackingerror,
                        //   focusColor: data.trackingpagescan == "Scanned"
                        //       ? colors.kColorgrey
                        //       : colors.KColorblue,
                        //   // isReadOnly:
                        //   //     data.trackingpagescan == "Scanned" ? true : false,
                        //   isUpperCase: true,
                        //   contentPadding: 4,
                        //   submitField: (_) {},
                        //   suffix: SvgIconButton(
                        //       assetLink: assets.search,
                        //       color: data.trackingpagescan == "Scanned"
                        //           ? colors.kColorgrey.withOpacity(0.5)
                        //           : colors.kColorBlack,
                        //       onPress: () {
                        //         if (data.trackingpagescan != "Scanned") {
                        //           if (trackingmodel
                        //               .trackingcontroller[index].text.isNotEmpty) {
                        //             trackingmodel.checkIsValidTrackingNumber(
                        //                 index: index, context: context);
                        //           } else {
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //                 errorSnackBar(
                        //                     "Tracking number cannot be empty or null"));
                        //           }
                        //         }
                        //       }),
                        // ),
                         upcScan,
                        ),
                Sizer.horizontal(),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        data.trackingpagescan.toString(),
                        style: textStyles.kTextTitle.copyWith(
                            color: data.trackingpagescan == "Scanned"
                                ? colors.kColorGreenButton
                                : colors.kColorBlack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
