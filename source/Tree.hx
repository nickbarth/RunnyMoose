package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;

using flixel.util.FlxSpriteUtil;

class Tree extends FlxSprite
{
  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);

    screenCenter();
    loadGraphic("assets/images/tree.png", true, 34, 57);
    x = FlxG.width;
  }

  private function movement():Void
  {
    x -= 5;
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
