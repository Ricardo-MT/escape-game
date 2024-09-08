import 'package:bonfire/bonfire.dart';

class CharactersConfig {
  static Vector2 textureSize = Vector2(32, 64);
  static Vector2 hitboxSize = Vector2(32, 44);
  static Vector2 hitboxPosition = Vector2(0, 20);
  static String spritesPath = 'characters';

  static Vector2 getSpriteOffset(int row, int col) {
    return Vector2(col * textureSize.x, row * textureSize.y);
  }
}
