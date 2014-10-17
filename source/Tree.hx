package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxRandom;

using flixel.util.FlxSpriteUtil;

class Tree extends FlxSprite
{
  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);

    loadGraphic("assets/images/tree.png", true, 34, 57);
    y = FlxRandom.intRanged(0, FlxG.height);
    x = FlxRandom.intRanged(100, FlxG.width);
  }

  private function movement():Void
  {
    x -= 5;

    if (x <= 0)
    {
      x = FlxG.width;
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
