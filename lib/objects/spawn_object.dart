import 'package:bonfire/bonfire.dart';

class PlayerSpawnObject {
  PlayerSpawnObject({
    required this.position,
    required this.size,
    required this.isForAppearing,
    required this.linkToLevel,
    required this.direction,
  });
  Vector2 position;
  Vector2 size;
  bool isForAppearing;
  String linkToLevel;
  Direction direction;

  factory PlayerSpawnObject.fromTileLayerPoint(
    Map<String, dynamic> json,
    Direction? direction,
  ) {
    // Retrieve property list. It is a list where each element is a dictionary with these 3 keys: name, type, value
    final properties = (json['properties'] as List<Map<String, dynamic>>);

    return PlayerSpawnObject(
      position: Vector2(json['x'], json['y']),
      size: Vector2(json['width'], json['height']),
      isForAppearing:
          properties.firstWhere((element) => element['name'] == 'in')['value'],
      linkToLevel: properties
          .firstWhere((element) => element['name'] == 'link')['value'],
      direction: _readDirectionFromSpawnSensor(
        value: properties.firstWhere(
          (element) => element['name'] == 'direction',
          orElse: () => {'value': null},
        )['value'],
        preferedDirection: direction,
      ),
    );
  }
}

Direction _readDirectionFromSpawnSensor({
  String? value,
  Direction? preferedDirection,
}) {
  switch (value) {
    case 'up':
      return Direction.up;
    case 'down':
      return Direction.down;
    case 'left':
      return Direction.left;
    case 'right':
      return Direction.right;
    default:
      return preferedDirection ?? Direction.down;
  }
}
