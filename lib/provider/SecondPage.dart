import 'package:flutter/material.dart';
import 'package:my_provider/provider/CountModel.dart';
import 'package:provider/provider.dart';


///
/// 第二个页面
/// 点击 floatingActionButton, 修改 Provider中的CountModel值
/// 演示Provider.of 的使用和  Consumer的使用
///
class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondState();
  }
}

class SecondState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    print('SecondPage all rebuild');
    // Provider.of<CountModel>(context); // 可以把这个注释打开看看效果
    // Provider.of<T>(context) 将会把调用了该方法的 context 作为听众，并在 T notifyListeners 的时候通知其刷新。

    // 在这个例子中,
    // 如果在这里 Provider.of<CountModel>(context) , 就相当于整个页面都在监听, 当Provider中的CountModel数据变化,并调用了notifyListeners之后,整个页面都刷新
    // 那么, SecondPage 的 build 会调用, NoProviderWidget的build 会调用, 所有的Consumer 都会被调用(不论是否在监听T)
    return Scaffold(
      body: Column(
        children: <Widget>[
          Consumer2(
            // 将Consumer2的builder 中的 context作为听众, 同时监听 CountModel类型和 int类型的值
            // 只要有任意一个变化, 就会走builder方法
            // 注意, 这个context 是Consumer2自己的context, 跟上面build的context 不一样
            builder: (BuildContext context, CountModel countModel, int textSize, Widget child) {
              print('Consumer2 build');
              // 这个Consumer2由于没写child, 所以child 是null
              if (child == null) {
                print('child is null');
              }

              return Center(
                child: Text(
                  'Value: ${countModel.count}',
                  style: TextStyle(
                    fontSize: textSize.toDouble(),
                  ),
                ),
              );
            },
          ),
          NoProviderWidget(),

          // 这个Consumer 只监听一个int 值, 所以当CountModel 变化的时候, 这个Consumer的build 不会重新执行
          Consumer(
            builder: (BuildContext context, int textSize, Widget child) {
              print('textSize is ${textSize}');
              return Text('111:${textSize}');
            },
          ),
        ],
      ),
      floatingActionButton: Consumer(
        builder: (context, CountModel countModel, child) {
          print('Consumer build');
          return FloatingActionButton(
            onPressed: () {
              countModel.increment();
            },
            child: child,
          );
        },
        child: Icon(Icons.adb),
      ),
      // 成功抽离出 Consumer 中不变的部分，也就是浮动按钮中心的 Icon 并将其作为 child 参数传入 builder 方法中。
      // 如果child 不写,  则传入 Consumer 的 build 中的child 就是 null
    );
  }
}

class NoProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('NoProviderWidget build');

    // 将当前Context 整个页面作为听众，并在 CountModel notifyListeners 的时候通知其刷新。
    // Provider.of<CountModel>(context);

    // 如果不调用 Provider.of 方法, 那么 当前页面就不是听众, notifyListeners的时候就不需要刷新
    return Container(
      width: 100,
      height: 100,
      color: Colors.amberAccent,
    );
  }
}
