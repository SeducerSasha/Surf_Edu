enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  /// Список для хранения уникальных машин и их возраста.
  final Map<String, int> mapAgeMachinery = {};

  /// Пробежимся циклом по первому map, чтобы получить уникальные машины и вычислить их возраст.
  for (final country in mapBefore2010.values) {
    for (final territory in country) {
      for (final machinery in territory.machineries) {
        /// Проверяем, если уже в нашем map такая машина. Если нет, то добавляем вместе с возрастом.
        if (!(mapAgeMachinery.containsKey(machinery.id))) {
          mapAgeMachinery[machinery.id] =
              DateTime.now().year - machinery.releaseDate.year;
        }
      }
    }
  }

  /// Пробежимся циклом по второму map, чтобы получить уникальные машины и вычислить их возраст.
  for (final country in mapAfter2010.values) {
    for (final territory in country) {
      for (final machinery in territory.machineries) {
        /// Проверяем, если уже в нашем map такая машина. Если нет, то добавляем вместе с возврастом.
        if (!(mapAgeMachinery.containsKey(machinery.id))) {
          mapAgeMachinery[machinery.id] =
              DateTime.now().year - machinery.releaseDate.year;
        }
      }
    }
  }

  /// Общий возраст всех машин.
  int ageAll = 0;

  /// Количество машин - половина от списка всех машин.
  int halfMachinery = 0;

  /// Список машин для последующего получения половины от списка машин.
  List ageMachinery = [];

  /// Теперь нужно посчитать общий возвраст машин в нашем map.
  for (final age in mapAgeMachinery.values) {
    ageAll = ageAll + age;
    ageMachinery.add(age);
  }

  /// Вычисляем средний возраст машины от общего возраста всех машин.
  double ageAverage = ageAll / ageMachinery.length;

  /// Для наглядности выводим на экран возраста всех машин.
  print(ageMachinery);

  /// Выводим средний возвраст.
  print(ageAverage);

  /// Для получения 50% самых старых машин сначала отсортируем возраст.
  ageMachinery.sort();

  /// Так как нужны самые старые машины, сортируем по убыванию возраста.
  ageMachinery = ageMachinery.reversed.toList();

  /// Получим 50% машин (по правилам округления).
  halfMachinery = (ageMachinery.length / 2).round();

  /// Выделяем из общего массива 50% машин.
  ageMachinery = ageMachinery.sublist(0, halfMachinery - 1);

  /// Получаем общий возраст 50% машин.
  ageAll = ageMachinery.reduce((a, b) => a + b);

  /// Вычисляем средний возраст этой половины машин.
  ageAverage = ageAll / ageMachinery.length;

  /// Для наглядности выводим на экран возраста получившихся машин.
  print(ageMachinery);

  /// Выводим средний возвраст.
  print(ageAverage);
}
