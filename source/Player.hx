package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;

using flixel.util.FlxSpriteUtil;

class Player extends FlxSprite
{

  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);

    screenCenter();
    loadGraphic("assets/images/moose_run.png", true, 60, 64);
    animation.add("run", [0, 1], 20, true);
    animation.play("run");
    x = 0;
  }

  private function movement():Void
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
