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
  private var _Exploded:Bool;
  private var _explode:FlxEmitterExt;

  public function new(explode)
  {
    _Exploded = false;
    _explode = explode;

    super();

    loadGraphic("assets/images/tree.png", true, 34, 57);
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxRandom.intRanged(100, FlxG.width);
  }

  private function movement():Void
  {
    x -= 5;

    if (x <= -20)
    {
      x = FlxG.width;
    }
  }

  private function grow(tween:FlxTween):Void
  {
    _Exploded = false;
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxG.width;
    angle = 0;
    alpha = 1;
  }

  public function fall():Void
  {
    if (!_Exploded) {
      _Exploded = true;
      _explode.y = y + 57;
      _explode.x = x - 30;
      _explode.start(true, 1, 0.01);

      FlxTween.angle(this, 0, 120, 0.2, { type:FlxTween.ONESHOT });
      FlxTween.tween(this, { alpha: 0 }, 0.33, { type:FlxTween.ONESHOT, ease:FlxEase.circOut, complete:grow });
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
