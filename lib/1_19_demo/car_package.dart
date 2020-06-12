/// 购物车

class Meta {
  double price;
  String name;
  // 成员变量初始化语法糖
  Meta(this.name, this.price);
}

// 定义商品Item类
class Item extends Meta {
  int num;
  double get totalPrice => price * num;
  Item(name, price, this.num): super(name, price);
  // 重载了+运算符，合并商品为套餐商品
  Item operator+(Item item) => Item(name + item.name, totalPrice + item.totalPrice, 1);
}

abstract class PrintHelper {
  printInfo() => print(getInfo());
  getInfo();
}

// 定义和购物车类
// with表示以非继承的方式复用了另一个类的成员变量及函数
class ShoppingCart extends Meta with PrintHelper {
  DateTime date;
  String code;
  List<Item> bookings;
  // 以归纳合并方式求和
  double get price => bookings.reduce((value, element) => value + element).price;
  // 默认初始化函数，转发至withCode函数
  ShoppingCart({name}) : this.withCode(name:name, code: null);
  // withCode初始化方法，使用语法糖和初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart.withCode({name, this.code}) : date = DateTime.now(), super(name, 0);

  // ??运算符表示为code不为null，则用原值，否则使用默认值"没有"
  @override
  String getInfo() {
    String bookingDetail = '';
    bookings.forEach((item) => bookingDetail += '''商品名称:${item.name} 单价:${item.price} 数量:${item.num} 总价:${item.totalPrice} | ''');
    return '''
      购物车信息:
      -----------------------------
        用户名: $name
        优惠码: ${code ?? "没有"}
        商品明细:
          $bookingDetail
        总价: $price
        日期: $date
      -----------------------------
    ''';
  }
}

void main() {
  ShoppingCart.withCode(name: '张三', code: '123456')
  ..bookings = [Item('苹果',10.0,2), Item('鸭梨',20.0,3)]
  ..printInfo();

  ShoppingCart(name: '李四')
  ..bookings = [Item('香蕉',15.0,5), Item('西瓜',40.0,1)]
  ..printInfo();
}
