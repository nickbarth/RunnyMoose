package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import motion.Actuate;
import motion.MotionPath;
import motion.easing.Linear;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  /**
   * Function called by the Play button to start the game.
   */
  private function clickPlay():Void
  {
    FlxG.switchState(new PlayState());
  }

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {
    var path = new MotionPath().bezier(0, 100, 0, 0);

    _background = new FlxBackdrop("assets/images/grass.png");
    _background.velocity.set(-100, 0);
    add(_background);

    _title = new FlxSprite();
    _title.loadGraphic("assets/images/title.png", true, 820, 101);
    add(_title);

    _moose = new FlxSprite();
    _moose.loadGraphic("assets/images/moose_run.png", true, 60, 64);
    _moose.animation.add("run", [0, 1], 5, true);
    _moose.animation.play("run");
    Actuate.motionPath(_moose, 1, { x: path.x, y: path.y }).repeat().reflect().ease(Linear.easeNone);
    add(_moose);

    _btnPlay = new FlxButton(0, 0, "", clickPlay);
    _btnPlay.loadGraphic("assets/images/start_button.png", false, 98, 49);
    _btnPlay.screenCenter();
    add(_btnPlay);

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
