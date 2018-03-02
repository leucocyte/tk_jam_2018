/**
 * Created by Drygu on 2016-02-27.
 */
package game.utils {
import flash.utils.getTimer;

public class TimeUtils {

    private static const dateTime:Number = new Date().time;
    private static const dateTimestamp:uint = getTimer();

    public function TimeUtils() {
    }

    public static function getCurrentTime():Number
    {
        return dateTime + (getTimer() - dateTimestamp);
    }
}
}
