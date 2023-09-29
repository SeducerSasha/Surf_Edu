// ignore_for_file: public_member_api_docs, sort_constructors_first
enum DistanceSprint { short, average, long }

enum DistanceMounting { up, updown }

class Sportsman {
  String name;

  Sportsman({
    required this.name,
  });
}

class Marathon {
  int distanceMeters = 42195;
  int yearLastParticipation;
  Marathon({
    required this.distanceMeters,
    required this.yearLastParticipation,
  });
}

class Sprint {
  List<DistanceSprint> distance;
  Sprint({
    required this.distance,
  });
}

class MountainRunning {
  DistanceMounting typeDistance;
  MountainRunning({
    required this.typeDistance,
  });
}

void main() {}
