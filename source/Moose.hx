package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.particles.FlxEmitterExt;
import flixel.system.FlxSound;
import flixel.text.FlxText;
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

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);

    screenCenter();
    loadGraphic("assets/images/moose_run.png", true, 60, 64);
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

  private function rage():Void
  {
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
