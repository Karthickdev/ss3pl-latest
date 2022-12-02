// import 'package:flutter/material.dart';
// import 'package:flutter_zebra_sdk/flutter_zebra_sdk.dart';
// import 'package:SouthShore3PL/screens/printing/pick_Printer_page.dart';

// class ZebraPrinterPage extends StatefulWidget {
//   @override
//   _ZebraPrinterPageState createState() => _ZebraPrinterPageState();
// }

// class _ZebraPrinterPageState extends State<ZebraPrinterPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> onTestTCP() async {
//     //try {
//       eventLogController.text =
//           'Connecting zebra printer. \n' + eventLogController.text;
//       String data;

//       data = '''
//     ''
//         ^XA
//     ^FO100, 200
//     ^AD,50,25
//     ^FH_^FD Hello world _7E ^FS
//     ^XZ
//     ''';
//      final rep = ZebraSdk.printZPLOverTCPIP(ipAddressController.text, data: data);
     
//     print(rep);
//   }

//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//   final ipAddressController = TextEditingController(text: '192.168.1.245');
//   final portController = TextEditingController(text: '9100');
//   final eventLogController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final ipAdress = TextField(
//       obscureText: false,
//       style: style,
//       controller: ipAddressController,
//       readOnly: false,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           labelText: "IP Address",
//           labelStyle:
//               style.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//           filled: true,
//           fillColor: Colors.white60),
//     );
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blue[100],
//           toolbarHeight: 80,
//           elevation: 0,
//           title: Text('TEST ZEBRA PRINTER',
//               textAlign: TextAlign.center,
//               style: style.copyWith(color: Colors.black)),
//           centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => PickPrinterPage()));
//             },
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: Colors.white,
//               size: 60,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Center(
//             child: Column(
//               children: [
//                 ipAdress,
//                 SizedBox(height: 10),
//                 FlatButton(
//                   onPressed: onTestTCP,
//                   child: Text('TEST PRINT'),
//                   color: Colors.blueGrey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Container(
//             height: 165,
//             child: Column(
//               children: <Widget>[
//                 Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Expanded(
//                           child: TextField(
//                         maxLines: 6,
//                         readOnly: true,
//                         controller: eventLogController,
//                         decoration: InputDecoration(
//                             hintText: "Event Log",
//                             contentPadding:
//                                 EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12.0))),
//                       ))
//                     ]),
//                 Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Text(
//                         'Version: UAT(0.0.1) 08-09-2021',
//                         textAlign: TextAlign.center,
//                       ),
//                     ]),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }