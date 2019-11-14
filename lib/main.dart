import 'package:flutter/material.dart';

import './widgets/Advertisement/Advertisement.dart';

// import 'routes/application.dart';
// import 'routes/routes.dart';
import 'routes/navigatorUtil.dart';
import 'package:provider/provider.dart';
import './model/model.dart';


void main() {
  Histroy();
  runApp(MyAppState());
}

class MyAppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CounterNotifier(),
      child: MaterialApp(
        title: 'Fluter bottomnavagiter',
        theme: ThemeData.light(),
        home: AdvertisementScreen(),
      ),
    );
  }
}
