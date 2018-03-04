/**
 * Created by Drygu on 2018-03-03.
 */
package game.objects {
import game.Game;
import game.GameController;
import game.attacks.Attack;
import game.attacks.AttacksManager;
import game.server.ActionServer;

public class ObjectController {

    private var _heroes:Vector.<Hero>;
    private var _pumps:Vector.<Pump>;
    private static var _instance:ObjectController;
    private var _myHeroId:int=-1;


    public function ObjectController() {
        _heroes = new Vector.<Hero>();
        _pumps = new Vector.<Pump>();
    }

    public static function instance():ObjectController {
        if (_instance==null)
            _instance = new ObjectController();
        return _instance;
    }

    public function onInitPack(heroes:String,obstacles:String,myId:String):void {

        _myHeroId = parseInt(myId);

        var arr:Array = heroes.split("[--]");
        for (var i:int = 0; i < arr.length-1; i++) {
//            var string:String = ;
            onNewHero(arr[i]);
        }

        arr = obstacles.split("[--]");
        for (var i:int = 0; i < arr.length-1; i++) {
            onNewPump(arr[i]);
        }

        findHero(_myHeroId);

    }

    public function demoData():void {

        _myHeroId = 0;

        var hero:Hero = new Hero("2,Burak,1,1,1,0");
        hero.x = 500;
        hero.updateView();
        _heroes.push(hero);

    }

    public function onNewHero(msg:String):void {
        var hero:Hero = new Hero(msg);
        _heroes.push(hero);
    }

    public function onHeroRemoved(msg:String):void {
        var h:Hero = findHero(parseInt(msg));
        if (h!=null) {
            h.destroy();
            _heroes.splice(_heroes.indexOf(h),1);
        }
    }



    public function onFramePack(heroes:String):void {
        var arr:Array = heroes.split("[--]");
        for (var i:int = 0; i < arr.length-1; i++) {
            var heroUpdate:String = arr[i];
            var id:int = parseInt(heroUpdate.split(",")[0]);
            if (id!=_myHeroId) {
                var hero:Hero = findHero(id);
                hero.updateHero(heroUpdate);
            }
        }
    }

    public function findHero(id:int):Hero {
        for (var i:int = 0; i < _heroes.length; i++) {
            var hero:Hero = _heroes[i];
            if (hero.id==id)
                return hero;
        }
        return null;
    }

    public function onAttack(myHero:Hero,t:int):void {
        var a:Attack = AttacksManager.getAttack(myHero,t);
        for (var i:int = 0; i < _heroes.length; i++) {
            var hero:Hero = _heroes[i];
            trace("on atttack: "+hero.id+" vs my id:  "+myHero.id);
            if (hero.id != myHero.id){
                if (a.hit(hero)){
                    trace("HIT: ",myHero.id,hero.id,a.type,myHero.direction);
                    ActionServer.hit(myHero.id,hero.id,a.type,myHero.direction);
//                    GameController.getInstance().onHit(a.type,h.direction);
                }
            }
        }
    }


    public function onEnterFrame():void {
        for (var i:int = 0; i < _pumps.length; i++) {
            var pump:Pump = _pumps[i];
            if (GameController.getInstance().isAlive() && pump.hit(GameController.getInstance().hero))
            {
                trace("KILLED BY PUMP!");
                GameController.getInstance().onKilledByPump();
                ActionServer.killedPump();
            }
        }
    }

    public function onNewPump(msg:String):void {
        var ob:Pump = new Pump(msg);
        ob.completedSignal.add(onPumpRemoved);
        _pumps.push(ob);
    }

    public function onNewPumpKey():void {
        trace("new pump!");
        var p:Pump = new Pump("1,2000,0,1");
        p.completedSignal.add(onPumpRemoved);
        _pumps.push(p);
    }

    public function onHitEffect(idHero:int):void {
        var hero:Hero = findHero(idHero);
    }

    public function onKillEffectPump(idHero:int):void {
        var hero:Hero = findHero(idHero);

    }

    private function onPumpRemoved(pump:Pump):void {
        _pumps.splice(_pumps.indexOf(pump),1);
    }



    public function get myHeroId():int {
        return _myHeroId;
    }
}
}
