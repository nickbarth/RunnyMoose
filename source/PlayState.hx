package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  private var _background:FlxBackdrop;
  private var _player:Player;
  private var _grpTrees:FlxTypedGroup<Tree>;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {
    _background = new FlxBackdrop("assets/images/grass.png");
    _background.velocity.set(-100, 0);
    add(_background);

    _player = new Player();
    add(_player);

    _grpTrees = new FlxTypedGroup<Tree>();
    add(_grpTrees);

    var n:Int;
    for (n in 0...10)
    {
      _grpTrees.add(new Tree());
    }

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
