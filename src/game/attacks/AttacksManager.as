/**
 * Created by Drygu on 2018-03-03.
 */
package game.attacks {
import game.objects.Hero;
import game.objects.HeroView;

public class AttacksManager {

    private var _attack:Vector.<Attack>;
    private static var _instance:AttacksManager;

    public function AttacksManager() {
        _attack = new Vector.<Attack>();
    }

    public static function instance():AttacksManager {
        if (_instance==null)
            _instance = new AttacksManager();
        return _instance;
    }

    public function newKick(hero:HeroView):void {

    }

    public static function getAttack(h:Hero, type:int):Attack {
        switch(type){
            case AttackType.KICK:
                return new Kick(h);
            case AttackType.UPPERCUT:
                return new Uppercut(h);
            case AttackType.DROP:
                return new Drop(h);
            default:
                return null;
        }
    }
}
}
