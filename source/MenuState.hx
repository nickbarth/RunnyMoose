package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.particles.FlxEmitterExt;
import flixel.text.FlxText;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  private var _background:FlxBackdrop;
  private var _title:FlxSprite;
  private var _moose:FlxSprite;
  private var _leafTrail:FlxEmitterExt;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {
    FlxG.sound.playMusic("music/music.mp3", 1, true);

    _background = new FlxBackdrop("images/grass.png");
    _background.velocity.set(-100, 0);
    add(_background);

    _title = new FlxSprite();
    _title.loadGraphic("images/title.png", true, 820, 101);
    _title.x = FlxG.width / 2 - _title.width / 2;
    _title.scale.x = 0.6;
    _title.scale.y = 0.6;
    FlxTween.tween(_title.scale, { x: 0.5 }, 0.2, { type:FlxTween.PINGPONG });
    FlxTween.tween(_title.scale, { y: 0.5 }, 0.4, { type:FlxTween.PINGPONG });
    add(_title);

    _moose = new FlxSprite(200, 100);
    _moose.loadGraphic("images/moose_run.png", true, 60, 64);
    _moose.animation.add("run", [0, 1], 20, true);
    _moose.x = FlxG.width / 2 - _moose.width / 2;
    FlxTween.tween(_moose, { y: 200 }, 0.5, { type:FlxTween.PINGPONG });
    add(_moose);
    _moose.animation.play("run");

    _leafTrail = new FlxEmitterExt(200, 153);
    _leafTrail.setRotation(0, 0);
    _leafTrail.makeParticles("images/leaf.png", 1200, 0, true, 0);
    _leafTrail.setAlpha(1, 1, 0, 0);
    _leafTrail.setMotion(170, 100, 0.2, 20, 200, 0.3);
    _leafTrail.x = _moose.x + 3;
    FlxTween.tween(_leafTrail, { y: 252 }, 0.5, { type:FlxTween.PINGPONG });
    add(_leafTrail);
    _leafTrail.start(false, 1, 0.01);

    var _link = new FlxText(0, 0, 500, "Press Space to Start");
    _link.size = 40;
    _link.y = FlxG.height - 100;
    _link.x = FlxG.width / 2 - 250;
    FlxTween.angle(_link, -5, 5, 0.2, { type:FlxTween.PINGPONG });
    add(_link);

    super.create();
  }

  /**
   * Function that is called when this state is destroyed - you might want to
   * consider setting all objects this state uses to null to help garbage collection.
   */
  override public function destroy():Void
  {
    super.destroy();
  }

  /**
   * Function that is called once every frame.
   */
  override public function update():Void
  {
    if (FlxG.keys.pressed.SPACE) {
      FlxG.switchState(new PlayState());
    }

    super.update();
  }
}
