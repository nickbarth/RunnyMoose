package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitterExt;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

class Tree extends FlxSprite
{
  private var _exploded:Bool;
  private var _exploder:FlxEmitterExt;

  public function new(exploder:FlxEmitterExt)
  {
    _exploded = false;
    _exploder = exploder;
    _exploder.makeParticles("assets/images/tree_bits.png", 10, 0, true, 0);
    _exploder.setMotion(170, 100, 0.2, 20, 200, 0.3);

    super();

    loadGraphic("assets/images/tree.png", true, 34, 57);
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxRandom.intRanged(0, FlxG.width);
  }

  private function movement():Void
  {
    x -= 5;

    if (x <= -20)
    {
      x = FlxG.width + 20;
      y = FlxRandom.intRanged(0, FlxG.height);
    }
  }

  private function grow(tween:FlxTween):Void
  {
    alive = true;
    _exploded = false;
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxG.width;
    angle = 0;
    alpha = 1;
  }

  public function fall():Void
  {
    if (!_exploded) {
      alive = false;
      _exploded = true;
      _exploder.y = y + 57;
      _exploder.x = x - 30;
      _exploder.start(true, 1, 0.01);

      FlxG.camera.shake(0.01, 0.1);
      FlxTween.angle(this, 0, 180, 0.5, { type:FlxTween.ONESHOT });
      FlxTween.tween(this, { alpha: 0 }, 2.0, { type:FlxTween.ONESHOT, ease:FlxEase.circOut, complete:grow });
    }
  }

  override public function update():Void
  {
    movement();
    super.update();
  }

  override public function destroy():Void
  {
    super.destroy();
  }
}
