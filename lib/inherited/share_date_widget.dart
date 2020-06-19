import 'package:flutter/material.dart';

///
/// 一个 InheritedWidget 组件
/// 其中保存了用于给子组件共享的数据
///
class ShareDataWidget extends InheritedWidget {
  // 一般属性用私有的, 然后对外提供 get 和 set 方法, 这里保存了点击的次数
  int _data;

  int get data => _data;

  set data(int value) {
    _data = value;
  }

  // Constructor
  ShareDataWidget({@required int data, Widget child}) : super(child: child) {
    this._data = data;
    print('ShareDataWidget构造方法被调用了');
  }

  static ShareDataWidget of(BuildContext buildContext) {

    // 方法已经废弃, 使用 dependOnInheritedWidgetOfExactType 替换
    Widget widget  = buildContext.inheritFromWidgetOfExactType(ShareDataWidget);

    // 使用给定的类型T 获取一个最近的Widget(必须是InheritedWidget的子类)
    // 并且, 会把这个当前的这个 buildContext 注册
    // 当父组件变化的时候,  当前的  buildContext 会重新构建, 这样就能拿到那个组件里的新的值了.

    // Obtains the nearest widget of the given type [T], which must be the type of a
    // concrete [InheritedWidget] subclass, and registers this build context with
    // that widget such that when that widget changes (or a new widget of that
    // type is introduced, or the widget goes away), this build context is
    // rebuilt so that it can obtain new values from that widget.

    Widget widget1  = buildContext.dependOnInheritedWidgetOfExactType<ShareDataWidget>();

    // 方法已经废弃, 使用 findAncestorWidgetOfExactType 替换
    Widget widget2 = buildContext.ancestorInheritedElementForWidgetOfExactType(ShareDataWidget).widget;
    // 不注册
    Widget widget3 = buildContext.getElementForInheritedWidgetOfExactType<ShareDataWidget>().widget;
    return widget1;
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}
