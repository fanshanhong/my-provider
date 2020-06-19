import 'package:flutter/material.dart';
import 'package:my_provider/provider/FirstPage.dart';

import 'inherited/test_inherited_page.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text('InheritedWidget演示demo'),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                return new TestInheritedPage();
              }));
            },
          ),

          RaisedButton(
            child: Text('Provider演示demo'),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                return new FirstPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
