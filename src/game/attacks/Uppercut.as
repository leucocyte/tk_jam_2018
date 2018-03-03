/**
 * Created by Drygu on 2018-03-03.
 */
package game.attacks {
import game.objects.Hero;

public class Uppercut extends Attack {
    public function Uppercut(h:Hero) {
        super(h);
        type = AttackType.UPPERCUT;
    }
}
}
