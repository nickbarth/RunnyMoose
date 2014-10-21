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

class Enemy extends FlxSprite
{
  private var _exploded:Bool;
  private var _exploder:FlxEmitterExt;

  public function new(exploder, randomX=false)
  {
    _exploded = false;
    _exploder = exploder;
    _exploder.makeParticles("assets/images/blood_bits.png", 10, 0, true, 0);

    super();

    loadGraphic("assets/images/forest_man.png", true, 20, 28);
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxG.width + 20;

    if (randomX)
    {
      x = FlxRandom.intRanged(200, FlxG.width);
    }

    scale.x = 2;
    scale.y = 2;

    FlxTween.tween(this.scale, { x:1.8, y:1.8 }, 0.3, { type:FlxTween.PINGPONG });
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
