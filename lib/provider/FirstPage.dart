import 'package:flutter/material.dart';
import 'package:my_provider/provider/CountModel.dart';
import 'package:my_provider/provider/SecondPage.dart';
import 'package:provider/provider.dart';

import 'GoodsListScreen.dart';


///
/// 第一个页面
/// 展示一个Count值, Count值来自于Provider中的CountModel
///
class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FirstState();
  }
}

class FirstState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {

    // 拿到Provider中维护的CountModel
    final _counter = Provider.of<CountModel>(context);

    final textSize = Provider.of<int>(context).toDouble();

    print('FirstPage all rebuild');

    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Text('跳转到SecondPage'),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder: (context){
            return new GoodsListScreen();
//            return new SecondPage();
          }));
        },
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 100,),
          // 使用Provider 中的CountModel
          Text('${_counter.count}', style: TextStyle(fontSize: textSize),)
        ],
      ),
    );
  }

}