import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  Selector的类定义如下
//  class Selector<A, S> extends Selector0<S> {
//  Selector({
//    Key key,
//    @required ValueWidgetBuilder<S> builder,
//    @required S Function(BuildContext, A) selector,
//    ShouldRebuild<S> shouldRebuild,
//    Widget child,
//  })  : assert(selector != null),
//        super(
//          key: key,
//          shouldRebuild: shouldRebuild,
//          builder: builder,
//          selector: (context) => selector(context, Provider.of(context)),
//          child: child,
//        );
//}

///
/// 演示Selector的使用
///
class GoodsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListenableProvider listenableProvider;
    ChangeNotifierProvider changeNotifierProvider;
    ValueListenableProvider valueListenableProvider;

    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: GoodsListProvider(),
        //create: (_) => GoodsListProvider(),  // Provider 4.0 用这个.  Provider 3.0 用value 方法
        child: Selector<GoodsListProvider, GoodsListProvider>(
          // A S
          //  A 是我们从顶层获取的 Provider 的类型, 这里GoodsListProvider
          //  S 是我们关心的具体类型，也即是获取到的 Provider 中真正对我们有用的类型，需要在 selector 方法中返回该类型。这个 Selector 的刷新范围也从整个 Provider 变成了 S
          //  shouldRebuild: (pre, next) => false,

          // selector方法, 第一个参数是 BuildContext, 第二个参数就是Selector<A,S> 中的A, 也就是那个顶层Provider
          // 这里的这个selector 只是想要实现 shouldRebuild: (pre, next) => false, 所以把顶层Provider 直接返回了
          selector: (BuildContext context, GoodsListProvider provider) => provider,

          // builder(BuildContext context, T value, Widget child) 其中, T是上面Selector<A,S>中的S类型
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.total,
              itemBuilder: (context, index) {
                // Goods 是我们关心的具体类型，也即是顶层 Provider 中真正对我们有用的类型，需要在 selector 方法中返回该类型。
                // 这个 Selector 的刷新范围也从整个 Provider 变成了 Goods
                // 这里我们返回了一个Goods 对象. 比如 goodsList[0]. 那么只有当goodsList[0] 变化的时候, 才需要重新构建, 可以实现更准确的控制.
                return Selector<GoodsListProvider, Goods>(
                  selector: (BuildContext context, GoodsListProvider provider) => provider.goodsList[index],
                  builder: (BuildContext context, Goods value, Widget child) {
                    // 这个child 跟Consumer 一样, 没传就是null
                    print(('No.${index + 1} rebuild'));

                    return ListTile(
                      title: Text(value.goodsName),
                      trailing: GestureDetector(
                        // Provider 不止保存数据,  还提供了操作数据的方法
                        onTap: () => provider.collect(index),
                        child: Icon(value.isCollection ? Icons.star : Icons.star_border),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class GoodsListProvider with ChangeNotifier {
  List<Goods> _goodsList = List.generate(10, (index) => Goods(false, 'Goods No. $index'));

  get goodsList => _goodsList;

  get total => _goodsList.length;

  collect(int index) {
    var good = _goodsList[index];

    // 这里修改某一个Goods, 然后notify
    // 这里是new 了一个新的.
    // 不new 能行么??    不new 就不行....
    //_goodsList[index].isCollection = !good.isCollection;
    _goodsList[index] = Goods(!good.isCollection, good.goodsName);
    notifyListeners();
  }
}

class Goods {
  bool isCollection;
  String goodsName;

  Goods(this.isCollection, this.goodsName);
}
