/**
 * Created by Drygu on 2015-04-08.
 */
package game.utils {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;

public class CursorManager {

    [Embed(source="../../../embed/cursors/axe_normal.png")]
    public static const Cursor:Class;

    [Embed(source="../../../embed/cursors/axe_red.png")]
    public static const CursorDown:Class;

    /*[Embed(source="../../../../embed/hand_cursor.png")]
    public static const HandCursor:Class;

    [Embed(source="../../../../embed/ibeam_cursor.png")]
    public static const IBeamCursor:Class;

    [Embed(source="../../../../embed/door_cursor.png")]
    public static const DoorCursor:Class;
*/

    public static const AUTO:String = "auto";
    public static const CHOP:String = "chop";



    public function CursorManager() {

    }

    public static function init():void
    {
        /*        var cursorBitmaps:Vector.<BitmapData> = new Vector.<BitmapData>();
        cursorBitmaps.push((new Cursor() as Bitmap).bitmapData);

        var mouseCursorData:MouseCursorData = new MouseCursorData();
        mouseCursorData.data        = cursorBitmaps;
        mouseCursorData.frameRate   = 60;
        mouseCursorData.hotSpot     = new Point(0, 0);


        var cursorBitmapsDown:Vector.<BitmapData> = new Vector.<BitmapData>();
        cursorBitmapsDown.push((new CursorDown() as Bitmap).bitmapData);
        var mouseCursorDataDown:MouseCursorData = new MouseCursorData();
        mouseCursorDataDown.data        = cursorBitmapsDown;
        mouseCursorDataDown.frameRate   = 60;
        mouseCursorDataDown.hotSpot     = new Point(0, 0);


        Mouse.registerCursor(MouseCursor.AUTO, mouseCursorData);
        Mouse.registerCursor(MouseCursor.ARROW, mouseCursorData);
//        Mouse.registerCursor(CHOP, mouseCursorDataDown);
//        Mouse.registerCursor(MouseCursor.BUTTON, mouseCursorDataHand);
//        Mouse.registerCursor(MouseCursor.IBEAM,mouseCursorDataIBeam);
//        Mouse.registerCursor(DOOR,mouseCursorDataDoor);
        Mouse.cursor = MouseCursor.ARROW; /* THIS */
        Mouse.cursor = MouseCursor.AUTO;
    }




}
}
