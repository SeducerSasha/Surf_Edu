// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Виды спорта: плавание, велогонка, бег.
enum SportsStage { swimming, cycling, running }

/// Класс "Спортсмен".
abstract class Sportsman {
  /// Имя спортсмена.
  String name;

  Sportsman({
    required this.name,
  });
}

/// Класс "Плавание"
abstract class Swimming {
  /// Дистанция в метрах
  int distanceMetersSwimming;

  Swimming({
    required this.distanceMetersSwimming,
  });
}

/// Класс "Велогонка"
abstract class Cycling {
  /// Дистанция в метрах
  int distanceMetersCycling;

  Cycling({
    required this.distanceMetersCycling,
  });
}

/// Класс "Бег"
abstract class Running {
  /// Дистанция в метрах
  int distanceMetersRunning;

  Running({
    required this.distanceMetersRunning,
  });
}

class SprtsmenSwimming implements Sportsman, Swimming {
  @override
  int distanceMetersSwimming;

  @override
  String name;
  SprtsmenSwimming({
    required this.name,
    required this.distanceMetersSwimming,
  });
  @override
  String toString() {
    return '$name. Дистанция плавания: $distanceMetersSwimming м.';
  }
}

class SprtsmenTriathlon implements Sportsman, Swimming, Cycling, Running {
  @override
  int distanceMetersCycling = 180200;

  @override
  int distanceMetersRunning = 42200;

  @override
  int distanceMetersSwimming = 3860;

  @override
  String name;
  SprtsmenTriathlon({
    required this.name,
  });

  @override
  String toString() {
    return '$name. Дистанции триатлона:\n Плавание: $distanceMetersSwimming м.\n Велогонка: $distanceMetersCycling м.\n Бег: $distanceMetersRunning м.';
  }
}

void main() {
  final sportsmen1 = SprtsmenTriathlon(name: 'Вася Скороходов');
  print(sportsmen1);

  final sportsmen2 =
      SprtsmenSwimming(name: 'Виктор Петров', distanceMetersSwimming: 50);
  print(sportsmen2);
}
