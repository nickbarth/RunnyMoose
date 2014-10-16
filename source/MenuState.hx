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
  private var _btnPlay:FlxButton;
  private var _background:FlxBackdrop;
  private var _title:FlxSprite;
  private var _moose:FlxSprite;
  private var _leafTrail:FlxEmitterExt;

  /**
   * Function called by the Play button to start the game.
   */
  private function clickPlay():Void
  {
    FlxG.switchState(new PlayState());
  }

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {
    _background = new FlxBackdrop("assets/images/grass.png");
    _background.velocity.set(-100, 0);
    add(_background);

    _title = new FlxSprite();
    _title.loadGraphic("assets/images/title.png", true, 820, 101);
    add(_title);

    _moose = new FlxSprite();
    _moose.x = 200;
    _moose.y = 0;
    _moose.loadGraphic("assets/images/moose_run.png", true, 60, 64);
    _moose.animation.add("run", [0, 1], 5, true);
    var tween1 = FlxTween.tween(_moose, { x:200, y:200 }, 0.5, { type:FlxTween.PINGPONG });
    add(_moose);
    _moose.animation.play("run");

    _leafTrail = new FlxEmitterExt();
    _leafTrail.x = 202;
    _leafTrail.y = 52;
    _leafTrail.setRotation(0, 0);
    _leafTrail.makeParticles("assets/images/leaf.png", 1200, 0, true, 0);
    _leafTrail.setAlpha(1, 1, 0, 0);
    _leafTrail.setMotion(170, 100, 0.2, 20, 200, 0.3);
    var tween2 = FlxTween.tween(_leafTrail, { x:202, y:252 }, 0.5, { type:FlxTween.PINGPONG });
    add(_leafTrail);
    _leafTrail.start(false, 1, 0.01);

    _btnPlay = new FlxButton(0, 0, "", clickPlay);
    _btnPlay.loadGraphic("assets/images/start_button.png", false, 98, 49);
    _btnPlay.screenCenter();
    add(_btnPlay);

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
    super.update();
  }
}
