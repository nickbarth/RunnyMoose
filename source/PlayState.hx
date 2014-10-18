package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.particles.FlxEmitterExt;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxStringUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
  private var _background:FlxBackdrop;
  private var _moose:Moose;
  private var _grpTrees:FlxTypedGroup<Tree>;
  private var _grpAnimals:FlxTypedGroup<Animal>;
  private var _grpEnemies:FlxTypedGroup<Enemy>;
  private var _grpEmitters:FlxTypedGroup<FlxEmitterExt>;
  private var _leafTrail:FlxEmitterExt;
  private var _scoreText:FlxText;
  private var _score:Int;

  /**
   * Function that is called up when to state is created to set it up.
   */
  override public function create():Void
  {
    var n:Int;

    _background = new FlxBackdrop("assets/images/grass.png");
    _background.velocity.set(-300, 0);
    add(_background);

    _moose = new Moose();
    add(_moose);

    _grpEmitters = new FlxTypedGroup<FlxEmitterExt>();
    add(_grpEmitters);

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
    for (n in 0...5) {
      var enemyExploder:FlxEmitterExt = new FlxEmitterExt();
      _grpEmitters.add(enemyExploder);
      _grpEnemies.add(new Enemy(enemyExploder));
    }

    _score = 0;
    _scoreText = new FlxText(0, 0, 460, "Score: 0")
    _scoreText.size = 10;
    _scoreText.y = 10;
    _scoreText.x = 10;
    add(_scoreText);

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
   * Moose hits a tree.
   */
  private function mooseHitTree(P:Moose, T:Tree):Void
  {
    if (P.alive && P.exists && T.alive && T.exists)
    {
      _score += 5;
      T.fall();
    }
  }

  /**
   * Moose hits an animal.
   */
  private function mooseHitAnimal(P:Moose, A:Animal):Void
  {
    if (P.alive && P.exists && A.alive && A.exists)
    {
      _score += 10;
      A.fall();
    }
  }

  /**
   * Moose hits an enemy.
   */
  private function mooseHitEnemy(P:Moose, E:Enemy):Void
  {
    if (P.alive && P.exists && E.alive && E.exists)
    {
      _score += 20;
      E.fall();
    }
  }

  /**
   * Function that is called once every frame.
   */
  override public function update():Void
  {
    _leafTrail.x = _moose.x + 3;
    _leafTrail.y = _moose.y + 55;
    _scoreText.text = "Score: " + FlxStringUtil.formatMoney(_score).split(".")[0];

    FlxG.overlap(_moose, _grpTrees, mooseHitTree);
    FlxG.overlap(_moose, _grpAnimals, mooseHitAnimal);
    FlxG.overlap(_moose, _grpEnemies, mooseHitEnemy);

    super.update();
  }
}
