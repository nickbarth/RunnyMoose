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

class Moose extends FlxSprite
{
  private var _exploded:Bool;
  private var _exploder:FlxEmitterExt;

  public function new(exploder)
  {
    _exploded = false;
    _exploder = exploder;
    _exploder.makeParticles("images/tree_bits.png", 50, 0, true, 0);

    super();

    screenCenter();
    loadGraphic("images/moose_run.png", true, 60, 64);
    animation.add("run", [0, 1], 20, true);
    animation.play("run");
    FlxTween.angle(this, -3, 3, 0.2, { type:FlxTween.PINGPONG });
    FlxTween.tween(this.scale, { x:1.1, y:1.1 }, 0.3, { type:FlxTween.PINGPONG });
    x = 50;
  }

  private function movement():Void
  {
    if (FlxG.mouse.y < (FlxG.height / 2)) {
      y -= 5;
    } else {
      y += 5;
    }

    if (y < 0) {
      y = FlxG.height - 5;
    } else if (y > FlxG.height) {
      y = 5;
    }
  }

  public function fall():Void
  {
    if (!_exploded) {
      alive = false;
      _exploded = true;
      _exploder.y = y;
      _exploder.x = x;
      _exploder.start(true, 1, 0.01);
      FlxTween.tween(this, { alpha: 0 }, 0.1, { type:FlxTween.ONESHOT, ease:FlxEase.circOut });
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
