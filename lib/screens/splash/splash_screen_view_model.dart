
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:southshore3pl/providers/core/default_change_notifier.dart';

// final splashScreenViewProvider =
//     ChangeNotifierProvider.autoDispose((ref) => SplashScreenViewModel(ref.read));

// class SplashScreenViewModel extends DefaultChangeNotifier {
//   final Reader ref;
//   SplashScreenViewModel(this.ref);
//   bool isReconnect = false;
//   BuildContext context;
//   BuildContext get getContext => context;
//   setContext({ BuildContext com}){
//     context = ctxt;
//     notifyListeners();
//   }
//   void changeConnectionStatus(){
//     isReconnect = !isReconnect;
//     notifyListeners();
//   }
// }