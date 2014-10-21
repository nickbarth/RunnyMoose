package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.particles.FlxEmitterExt;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxSave;
import flixel.util.FlxStringUtil;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  private var _btnPlay:FlxButton;
  private var _gameOver:FlxSprite;
  private var _background:FlxBackdrop;
  private var _moose:Moose;
  private var _grpTrees:FlxTypedGroup<Tree>;
  private var _grpAnimals:FlxTypedGroup<Animal>;
  private var _grpEnemies:FlxTypedGroup<Enemy>;
  private var _grpEmitters:FlxTypedGroup<FlxEmitterExt>;
  private var _leafTrail:FlxEmitterExt;
  private var _scoreText:FlxText;
  private var _gameSave:FlxSave;
  private var _score:Int;
  private var _topScoreText:FlxText;
  private var _topScore:Int;
  private var _enemyTimer:haxe.Timer;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {
    var n:Int;

    _gameSave = new FlxSave();
    _gameSave.bind("GameSave");

    _background = new FlxBackdrop("assets/images/grass.png");
    _background.velocity.set(-300, 0);
    add(_background);

    _grpEmitters = new FlxTypedGroup<FlxEmitterExt>();
    add(_grpEmitters);

    var mooseExploder:FlxEmitterExt = new FlxEmitterExt();
    _grpEmitters.add(mooseExploder);
    _moose = new Moose(mooseExploder);
    add(_moose);

    _leafTrail = new FlxEmitterExt(200, 153);
    _leafTrail.setRotation(0, 0);
    _leafTrail.makeParticles("assets/images/leaf.png", 1200, 0, true, 0);
    _leafTrail.setAlpha(1, 1, 0, 0);
    _leafTrail.setMotion(170, 100, 0.2, 20, 200, 0.3);
    add(_leafTrail);
    _leafTrail.start(false, 1, 0.01);

    _grpTrees = new FlxTypedGroup<Tree>();
    add(_grpTrees);

    for (n in 0...40) {
      var treeExploder:FlxEmitterExt = new FlxEmitterExt();
      _grpEmitters.add(treeExploder);
      _grpTrees.add(new Tree(treeExploder));
    }

    _grpAnimals = new FlxTypedGroup<Animal>();
    add(_grpAnimals);
    for (n in 0...20) {
      var animalExploder:FlxEmitterExt = new FlxEmitterExt();
      _grpEmitters.add(animalExploder);
      _grpAnimals.add(new Animal(animalExploder));
    }

    _grpEnemies = new FlxTypedGroup<Enemy>();
    add(_grpEnemies);

    _enemyTimer = new haxe.Timer(2000);
    _enemyTimer.run = spawnEnemy;

    _score = 0;
    _scoreText = new FlxText(0, 0, 460, "Score: 0");
    _scoreText.size = 10;
    _scoreText.y = 10;
    _scoreText.x = 10;
    add(_scoreText);

    _topScore = _gameSave.data.topScore;
    _topScoreText = new FlxText(0, 0, FlxG.width - 10, "Top: " + FlxStringUtil.formatMoney(_topScore).split(".")[0]);
    _topScoreText.size = 10;
    _topScoreText.x = 0;
    _topScoreText.y = 10;
    _topScoreText.alignment = "right";
    add(_topScoreText);

    super.create();
  }

  private function spawnEnemy()
  {
    var enemyExploder:FlxEmitterExt = new FlxEmitterExt();
    _grpEmitters.add(enemyExploder);
    _grpEnemies.add(new Enemy(enemyExploder));
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
   * Moose hits a tree.
   */
  private function mooseHitTree(M:Moose, T:Tree):Void
  {
    if (M.alive && M.exists && T.alive && T.exists)
    {
      _score += 5;
      T.fall();
    }
  }

  /**
   * Moose hits an animal.
   */
  private function mooseHitAnimal(M:Moose, A:Animal):Void
  {
    if (M.alive && M.exists && A.alive && A.exists)
    {
      _score += 10;
      A.fall();
    }
  }

  /**
   * Moose hits an enemy.
   */
  private function mooseHitEnemy(M:Moose, E:Enemy):Void
  {
    if (M.alive && M.exists && E.alive && E.exists)
    {
      _score += 20;
      M.fall();
      E.fall();
      _leafTrail.kill();
      haxe.Timer.delay(gameover, 500);
    }
  }

  private function clickPlay():Void
  {
    var best = _score;

    if (_topScore > best)
    {
      best = _topScore;
    }

    _gameSave.data.topScore = best;
    _gameSave.flush();

    FlxG.switchState(new PlayState());
  }

  private function gameover():Void
  {
    _gameOver = new FlxSprite();
    _gameOver.loadGraphic("assets/images/game_over.png", true, 449, 50);
    _gameOver.screenCenter();
    _gameOver.y = 100;
    FlxTween.tween(_gameOver.scale, { x: 1.1 }, 0.2, { type:FlxTween.PINGPONG });
    FlxTween.tween(_gameOver.scale, { y: 0.7 }, 0.4, { type:FlxTween.PINGPONG });
    add(_gameOver);

    _btnPlay = new FlxButton(0, 0, "", clickPlay);
    _btnPlay.loadGraphic("assets/images/start_button.png", false, 98, 49);
    _btnPlay.screenCenter();
    _btnPlay.y = 300;
    add(_btnPlay);

    var _link = new FlxText(0, 0, 460, "RUNNYMOOSE.COM");
    _link.size = 40;
    _link.y = FlxG.height - 100;
    _link.x = FlxG.width / 2 - 220;
    FlxTween.angle(_link, -5, 5, 0.2, { type:FlxTween.PINGPONG });
    add(_link);
  }

  /**
   * Function that is called once every frame.
   */
  override public function update():Void
  {
    _leafTrail.x = _moose.x + 3;
    _leafTrail.y = _moose.y + 55;
    _scoreText.text = "Score: " + FlxStringUtil.formatMoney(_score).split(".")[0];

    if (_score > _topScore) {
      _topScoreText.text = "Top: " + FlxStringUtil.formatMoney(_score).split(".")[0];
    }

    FlxG.overlap(_moose, _grpTrees, mooseHitTree);
    FlxG.overlap(_moose, _grpAnimals, mooseHitAnimal);
    FlxG.overlap(_moose, _grpEnemies, mooseHitEnemy);

    super.update();
  }
}
