/**
 * Created by Drygu on 2018-03-03.
 */
package game.ui {
public class FontSettings {

    [Embed(source="../../../embed/fonts/BADABB__.TTF",
            fontName="BadaBoom BB",
            mimeType="application/x-font",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    public static const font:Class;
/*
    [Embed(source="../../../embed/fonts/KronaOne-Regular.ttf",
            fontName="Krona",
            mimeType="application/x-font",
            advancedAntiAliasing="true",
            embedAsCFF="false")]
    public static const font2:Class;*/

    public function FontSettings() {
    }


    public static function init():void {

    }
}
}
