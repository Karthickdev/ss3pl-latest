import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:southshore3pl/res/res.dart';
import 'package:southshore3pl/screens/packapp/scanpages/multiscanpage/multi_item_view_model.dart';
import 'package:southshore3pl/router/route_names.dart';
import 'package:southshore3pl/util/sizer.dart';

class Multiitemprinter extends StatefulWidget {
  const Multiitemprinter({Key? key}) : super(key: key);

  @override
  State<Multiitemprinter> createState() => _MultiitemprinterState();
}

class _MultiitemprinterState extends State<Multiitemprinter> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      // final printermmodel = watch(printerViewProvider);
      // final singleitemmodel = watch(packappsingleviewprovider);
      final multiitemModel = watch(packappmultiviewprovider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.kColorgrey,
          title: const Text("Printing"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colors.kColorgrey2,
                  ),
                  child: const Text(
                    'Create & Print PDF',
                  ),
                  onPressed: () {
                    context.read(packappmultiviewprovider).createPdf(
                          context,
                        );
                  }),
              Sizer.vertical20(),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: colors.kColorgrey2,
              //     ),
              //     child: const Text(
              //       'SKIP',
              //     ),
              //     onPressed: () {
              //       context.read(packappmultiviewprovider).skipPrinting(
              //             context,
              //           );
              //     }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
