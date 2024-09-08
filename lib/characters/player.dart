import 'package:bonfire/bonfire.dart';
import 'package:escape_game/characters/characters_config.dart';

String playerSpriteSheet = "${CharactersConfig.spritesPath}/player_32x32.png";

class MainPlayer extends SimplePlayer with BlockMovementCollision {
  MainPlayer(
    Vector2 position, {
    Direction? initDirection,
  }) : super(
          position: position,
          size: CharactersConfig.textureSize,
          animation: PlayerSpriteSheet.simpleDirectionAnimation,
          initDirection: initDirection ?? Direction.down,
          speed: 140,
        );

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(
      size: CharactersConfig.hitboxSize,
      position: CharactersConfig.hitboxPosition,
    ));
    return super.onLoad();
  }
}

class PlayerSpriteSheet {
  static Future<SpriteAnimation> get idleRight => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(1, 0),
        ),
      );

  static Future<SpriteAnimation> get idleUp => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(1, 6),
        ),
      );

  static Future<SpriteAnimation> get idleLeft => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(1, 12),
        ),
      );

  static Future<SpriteAnimation> get idleDown => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(1, 18),
        ),
      );

  static Future<SpriteAnimation> get runRight => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(2, 0),
        ),
      );

  static Future<SpriteAnimation> get runUp => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(2, 6),
        ),
      );

  static Future<SpriteAnimation> get runLeft => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(2, 12),
        ),
      );

  static Future<SpriteAnimation> get runDown => SpriteAnimation.load(
        playerSpriteSheet,
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: CharactersConfig.textureSize,
          texturePosition: CharactersConfig.getSpriteOffset(2, 18),
        ),
      );

  static SimpleDirectionAnimation get simpleDirectionAnimation =>
      SimpleDirectionAnimation(
        idleRight: idleRight,
        idleUp: idleUp,
        idleLeft: idleLeft,
        idleDown: idleDown,
        runRight: runRight,
        runUp: runUp,
        runLeft: runLeft,
        runDown: runDown,
      );
}
