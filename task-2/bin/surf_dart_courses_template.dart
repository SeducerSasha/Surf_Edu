//Опеределим тип: товар и услуга
enum ProductType { goods, services }

//Класс "Товар". Содержит: код, наименование, тип. Также может быть назначена цена при создании
class Product {
  final String id;
  String name;
  double? price;
  final ProductType type;

  Product(
      {required this.id, required this.name, required this.type, this.price});

  //Метод позволяет назначить цену уже существующему товару
  void setPrice(double newPrice) {
    if (newPrice != null) {
      price = newPrice;
    } else
      price = 0;
  }
}

//Класс строки списка товаров заказа. Сордержит: объект товара, количество, цену.
//Сумма при создании не назначается, а вычисляется отдельным методом.
class RowTable {
  Product product;
  int count;
  double price;
  double? _sum;

  double? get sum => _sum;

  RowTable({required this.product, required this.count, required this.price});

  //Метод вычисления суммы строки.
  void rowSum() {
    _sum = count * price;
  }
}

//Класс заказа. Содержит: номер и дата заказа
//Список товаров необязателен при создании
//Сумма заказа не назначается, а вычисляется отдельным методом
class Order {
  final String number;
  DateTime date;
  double _sum = 0;
  List<RowTable>? productList;

  Order({required this.number, required this.date, this.productList});

  double get sum => _sum;

  //Метод пердоставляет возможность добавления новой строки в заказ
  void addRow(newRow) {
    if (newRow != null) {
      productList?.add(newRow);
    }
    ;
  }

  //Метод вычисляет общую сумму заказа. При обходе списка сначала вычисляется сумма строки
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
  //Сначала создадим список товаров и услуг, при этом не везде установим цену
  Map<String, Product> products = {
    '1': Product(id: '1', name: 'Чайник', type: ProductType.goods, price: 1000),
    '2': Product(
        id: '2', name: '{Холодильник', type: ProductType.goods, price: 35000),
    '3': Product(id: '3', name: 'Утюг', type: ProductType.goods),
    '4': Product(id: '4', name: 'Ноутбук', type: ProductType.goods),
    '5': Product(id: '5', name: 'Доставка', type: ProductType.services),
    '6': Product(id: '6', name: 'Установка', type: ProductType.services)
  };

  //Установим цены на ряд товаров отдельно
  products['3']?.setPrice(1500);
  products['4']?.setPrice(75000);

  //Создаем новый заказ
  Order newOrder = Order(number: '0001', date: DateTime.now(), productList: []);

  newOrder.addRow(RowTable(
      product: products["2"]!, count: 1, price: products["2"]!.price ?? 0.00));
  newOrder.addRow(RowTable(product: products["5"]!, count: 1, price: 100));
  newOrder.sumDoc();

  print('Сумма заказа: ${newOrder.sum}');
}
