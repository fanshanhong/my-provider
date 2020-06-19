import 'package:flutter/material.dart';
import 'package:my_provider/inherited/child_widget.dart';

import 'share_date_widget.dart';

///
/// 测试页面
///
class TestInheritedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InheritedWidgetTestState();
  }
}

class _InheritedWidgetTestState extends State<TestInheritedPage> {
  int count = 0;

  @override
  void initState() {
    print('TestInheritedPage initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('TestInheritedPage build');
    return Column(
      //使用InheritedWidget, 其子组件就可以使用InheritedWidget内部维护的数据了
      children: <Widget>[
        ShareDataWidget(
          data: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ChildWidget(), //子widget中依赖ShareDataWidget(InheritedWidget)
              ),
              RaisedButton(
                child: Text("计数增加"),
                onPressed: () {
                  setState(() {
                    ++count;
                  });
                },
              )
            ],
          ),
        ),
        MyButton(),

      ],
    );
  }
}


class MyButton extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MyButtonState();
  }
}
class MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    print('MyButton build');
    return new Container(width: 100, height: 20, color: Colors.amber,);
  }

}