import 'package:bonfire/bonfire.dart';
import 'package:escape_game/characters/player.dart';

class SpawnSensor extends GameComponent with Sensor<MainPlayer> {
  SpawnSensor({
    required Vector2 position,
    required Vector2 size,
    required this.linkToLevel,
    this.handleOnContact,
  }) : super() {
    this.position = position;
    this.size = size;
    width = size.x;
    height = size.y;
  }

  final String linkToLevel;
  bool isInside = false;
  Function(String link)? handleOnContact;

  factory SpawnSensor.fromTiledObjectProperties(
      TiledObjectProperties properties) {
    return SpawnSensor(
      position: properties.position,
      size: properties.size,
      linkToLevel: properties.others['link'] as String,
    );
  }

  @override
  void onContact(MainPlayer component) {
    if (!isInside) {
      handleOnContact?.call(linkToLevel);
    }
    isInside = true;
  }

  @override
  onContactExit(MainPlayer component) {
    isInside = false;
  }
}
