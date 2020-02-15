/*
 * Copyright 2020 Idan Ayalon. All rights reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Home(),
      ),
    );
  }
}

class Routes {
  static final home = "/home";
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  navigation() {
    navigateTo(route: MaterialPageRoute(builder: (c) => Login()));
    navigateByRouteName(Routes.home, );
    navigateBack();
  }

  @override
  Widget build(BuildContext context) {

    /// For example purpose only

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
            )   .withRoundCorners(backgroundColor: Colors.grey)
                .withShadow()
                .alignAtCenter()
                .toCenter()
                .paddingOnly(left: 10)
                .paddingAll(20)
                .onTap(() => print('tap'))
                .onLongPress(() => print('long press'))
          ],
        ),
      ),
    );
  }
}
