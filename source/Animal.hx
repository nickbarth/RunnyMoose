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

class Animal extends FlxSprite
{
  private var _exploded:Bool;
  private var _exploder:FlxEmitterExt;

  public function new(exploder)
  {
    _exploded = false;
    _exploder = exploder;
    _exploder.makeParticles("assets/images/blood_bits.png", 10, 0, true, 0);

    super();

    loadGraphic("assets/images/forest_animals.png", true, 23, 9);
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxRandom.intRanged(100, FlxG.width);
    animation.frameIndex = FlxRandom.intRanged(0, 8);
    scale.x = 2.0;
    scale.y = 2.0;
    FlxTween.angle(this, -5, 5, 0.2, { type:FlxTween.PINGPONG });
  }

  private function movement():Void
  {
    x -= 5;

    if (x <= 0)
    {
      x = FlxG.width;
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
      _exploder.y = y;
      _exploder.x = x;
      _exploder.start(true, 1, 0.01);
      FlxTween.tween(this, { alpha: 0 }, 0.1, { type:FlxTween.ONESHOT, ease:FlxEase.circOut, complete:grow });
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
