import 'package:flutter/material.dart';
import 'package:my_provider/inherited/share_date_widget.dart';

///
/// 作为 ShareDataWidget 的子组件, 使用 ShareDataWidget 中维护的数据
///
class ChildWidget extends StatefulWidget {
  // Constructor
  ChildWidget() {
    print('ChildWidget构造方法被调用了');
  }

  @override
  State<StatefulWidget> createState() {
    return _ChildWidgetState();
  }
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  Widget build(BuildContext context) {
    print('ChildWidget build');

    //使用 InheritedWidget 中的共享数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("ChildWidget Dependencies change");
  }
}
