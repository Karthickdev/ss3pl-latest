import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'singleitemapi.dart';

class SingleItemScanPage extends StatefulWidget {
  @override
  _SingleItemScanPageState createState() => _SingleItemScanPageState();
}

class _SingleItemScanPageState extends State<SingleItemScanPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final PickappSingleItemScanApiService pickappService =
      PickappSingleItemScanApiService();
  final poController = TextEditingController();
  final poDateController = TextEditingController();
  final vendorController = TextEditingController();
  final serialNoController = TextEditingController();
  final itemNameCtrl = TextEditingController();
  final eventLogController = TextEditingController();
  final storage = LocalStorage('casprUserId');
  List filteredItems = [];
  List filteredItemList = [];
  List checkScannedItems = [];
  bool _isLoading = false;
  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.centerDocked;

  var poDetails = {};
  var poItems = [];
  bool enabled = false;
  bool _isInAsyncCall = false;
  bool _visibleSave = false;
  bool _serialFocus = false;
  bool _poFocus = true;
  bool proceedToSave = true;
  bool keyboardOpen = false;
  bool proceedToSerialSave = false;
  bool _itemFocus = false;
  bool showItemField = false;
  bool serialReadOnly = true;
  var itemList = [];
  var serialNumbers = [];
  FocusNode poFocusNode = new FocusNode();
  FocusNode serialFocus = new FocusNode();
  FocusNode itemNameFocus = new FocusNode();

  List<String> scannedserials = [];
  var itemId;
  @override
  void initState() {
    super.initState();
  }

  void getPoDetails(String) async {
    try {
      var url = pickappService.baseUrl + pickappService.pickOrderDetails;
      var data = {"poBarCode": poController.text};
      var res = await pickappService.GetPickOrderDetail(Uri.parse(url), data);
      setState(() {
        poDetails = json.decode(res.body);
        poItems = poDetails['orderItemList'];
        for (var i in poItems) {
          i.unpicked = 0;
          i.scanUpc = 0;
          i.isScanned = false;
        }
      });
    } catch (e) {}
  }

  void verifyserialNumber(String) async {}

  void verifyserialwithItem(String) async {}

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final poNo = TextFormField(
      obscureText: false,
      style: style,
      focusNode: poFocusNode,
      autofocus: _poFocus,
      controller: poController,
      readOnly: enabled,
      onFieldSubmitted: getPoDetails,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "PO #",
          labelText: 'PO #',
          suffixIcon: IconButton(
            onPressed: () => {getPoDetails(String)},
            icon: Icon(Icons.search),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final poDate = TextField(
      obscureText: false,
      style: style,
      controller: poDateController,
    );

    final vendor = TextField(
      obscureText: false,
      style: style,
      controller: vendorController,
    );

    final loader = LoadingOverlay(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
        ),
      ),
      isLoading: _isLoading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
    );

    final serialNo = TextFormField(
      obscureText: false,
      style: style,
      focusNode: serialFocus,
      autofocus: _serialFocus,
      controller: serialNoController,
      readOnly: serialReadOnly,
      onFieldSubmitted: verifyserialNumber,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Serial #",
          labelText: 'Serial #',
          suffixIcon: IconButton(
            onPressed: () => {verifyserialNumber(String)},
            icon: Icon(Icons.search),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    final itemName = TextFormField(
      obscureText: false,
      style: style,
      focusNode: itemNameFocus,
      autofocus: _itemFocus,
      controller: itemNameCtrl,
      onFieldSubmitted: verifyserialwithItem,
      keyboardType: TextInputType.text,
      //textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Item Name",
          labelText: 'Item Name',
          suffixIcon: IconButton(
            onPressed: () => {verifyserialwithItem(String)},
            icon: Icon(Icons.search),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
    );

    return WillPopScope(
      onWillPop: () async => !(Navigator.of(context).userGestureInProgress),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          backgroundColor: Colors.blueAccent[100],
          toolbarHeight: 80,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_outlined),
                iconSize: 60,
                onPressed: () {},
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(33, 0, 33, 0),
                  child: Text(
                    'SINGLE ITEM SCAN',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ))
            ],
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: (Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: FormField(builder: (FormFieldState<String> state) {
                return poNo;
              }),
            ),

            Padding(
              padding: EdgeInsets.all(5.0),
              child: FormField(builder: (FormFieldState<String> state) {
                return serialNo;
              }),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: Table(
                //defaultColumnWidth: FixedColumnWidth(120.0),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Container(
                              color: Colors.blueAccent[100],
                              child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    Text(
                                      "ITEM",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.left,
                                    ),
                                  ])))),
                      TableCell(
                          child: Container(
                              color: Colors.blueAccent[100],
                              child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    Text(
                                      "UPC",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ])))),
                      TableCell(
                          child: Container(
                              color: Colors.blueAccent[100],
                              child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    Text(
                                      "QTY PICKED/UNPICKED",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ])))),
                      TableCell(
                          child: Container(
                              color: Colors.blueAccent[100],
                              child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(children: [
                                    Text(
                                      "UPC NUMBER",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ]))))
                    ],
                  ),
                  for (var item in poItems)
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['itemName'],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child:
                            FormField(builder: (FormFieldState<String> state) {
                          return serialNo;
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(children: [
                          Text(
                            '${item['unpicked']}' + '/' + '${item['quantity']}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),
                      Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Column(children: [
                            Text('${item['upc']}',
                                style: TextStyle(
                                  fontSize: 18,
                                ))
                          ])),
                    ])
                ],
              ),
            ),
            // poDetails != null
            //     ? Container(
            //         child: Column(
            //         children: [
            //           SizedBox(
            //             height: 60,
            //           ),
            //           Padding(
            //               padding: EdgeInsets.only(bottom: bottom),
            //               child: TextField(
            //                 maxLines: 4,
            //                 readOnly: true,
            //                 controller: eventLogController,
            //                 decoration: InputDecoration(
            //                     labelText: "Event Log",
            //                     contentPadding: EdgeInsets.fromLTRB(
            //                         20.0, 15.0, 20.0, 15.0),
            //                     border: OutlineInputBorder(
            //                         borderRadius:
            //                             BorderRadius.circular(12.0))),
            //               )),
            //         ],
            //       ))
            //     : Container(),
          ]),
        )),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                maxLines: 6,
                readOnly: true,
                controller: eventLogController,
                decoration: InputDecoration(
                    labelText: "Event Log",
                    hintText: "Event Log",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0))),
              )),
        ),
      ),
    );
  }
}
