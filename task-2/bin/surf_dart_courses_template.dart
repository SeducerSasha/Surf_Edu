import 'package:meta/meta.dart';

/// Определим тип: товар и услуга.
enum ProductType { goods, services }

/// Класс "Товар". Неизменяемый.
@immutable
class Product {
  /// Код товара.
  final String id;

  /// Наименование товара.
  final String name;

  /// Цена товара.
  final double? price;

  /// Тип товара
  final ProductType type;

  /// Цена не является обязательной при создании, но может быть назначена.
  Product(
      {required this.id, required this.name, required this.type, this.price});

  /// При изменении создаем копию объекта и возвращаем ее.
  Product copyWith({
    String? id,
    String? name,
    double? price,
    ProductType? type,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      type: type ?? this.type,
    );
  }

  /// Метод позволяет назначить или изменить цену существующему товару.
  Product withNewPrice(double price) {
    return copyWith(price: price);
  }

  //   void setPrice(double newPrice) {
  //   if (newPrice != null) {
  //     price = newPrice;
  //   } else
  //     price = 0;
  // }
}

/// Класс строки списка товаров заказа.
class RowTable {
  /// Товар.
  Product product;

  /// Количество товара.
  int count;

  /// Цена товара.
  double price;

  /// Сумма товара.
  double? _sum;

  double? get sum => _sum;

  /// Сумма при создании не назначается, а вычисляется отдельным методом.
  RowTable({required this.product, required this.count, required this.price});

  /// Метод вычисления суммы строки.
  void rowSum() {
    _sum = count * price;
  }
}

// Класс заказа.
class Order {
  /// Номер заказа.
  final String number;

  /// Дата заказа.
  DateTime date;

  /// Сумма заказа.
  double _sum = 0;

  /// Список товаров с ценой и количеством.
  List<RowTable>? productList;

  /// Список товаров необязателен при создании.
  /// Сумма заказа не назначается, а вычисляется методом sumDoc.
  Order({required this.number, required this.date, this.productList});

  double get sum => _sum;

  /// Метод предоставляет возможность добавления новой строки в заказ.
  void addRow(newRow) {
    if (newRow != null) {
      productList?.add(newRow);
    }
    ;
  }

  /// Метод вычисляет общую сумму заказа. При обходе списка сначала вычисляется сумма строки.
  void sumDoc() {
    _sum = 0.00;
    if (productList != null && productList!.isNotEmpty) {
      productList?.forEach((element) {
        element.rowSum();
        _sum = _sum + element.sum!;
      });
    }
  }
}

void main() {
  /// Сначала создадим список товаров и услуг, при этом не везде будем устанавливать цену.
  Map<String, Product> products = {
    '1': Product(id: '1', name: 'Чайник', type: ProductType.goods, price: 1000),
    '2': Product(
        id: '2', name: '{Холодильник', type: ProductType.goods, price: 35000),
    '3': Product(id: '3', name: 'Утюг', type: ProductType.goods),
    '4': Product(id: '4', name: 'Ноутбук', type: ProductType.goods),
    '5': Product(id: '5', name: 'Доставка', type: ProductType.services),
    '6': Product(id: '6', name: 'Установка', type: ProductType.services)
  };

  /// Установим цены на ряд товаров отдельно.
  products['3']?.withNewPrice(1500);
  products['4']?.withNewPrice(75000);

  /// Создаем новый заказ.
  Order newOrder = Order(number: '0001', date: DateTime.now(), productList: []);

  /// Добавим строки в заказ.
  newOrder.addRow(RowTable(
      product: products["2"]!, count: 1, price: products["2"]!.price ?? 0.00));
  newOrder.addRow(RowTable(product: products["5"]!, count: 1, price: 100));

  /// Вычисялем сумму заказа.
  newOrder.sumDoc();

  /// Выведем в консоль полученную сумму заказа.
  print('Сумма заказа: ${newOrder.sum}');
}
