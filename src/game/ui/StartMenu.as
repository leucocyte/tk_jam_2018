/**
 * Created by Drygu on 2018-03-02.
 */
package game.ui {
import feathers.controls.Button;
import feathers.controls.Label;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.filters.DropShadowFilter;

import flash.text.TextFormat;

import flashx.textLayout.formats.TextAlign;

import game.Game;

import game.utils.Settings;

import starling.display.Sprite;
import starling.events.Event;

public class StartMenu extends Sprite{
    public function StartMenu() {
        build();
    }

    private function build():void {
        var name:Label= new Label();
        name.text = "Yo";
        addChild(name);



        var join:Button = new Button();
        join.label = "Join";
        addChild(join);

        name.x = 100;
        join.x= 0;


    /*    var textFormat:TextFormat = new TextFormat();
        textFormat.font = "Verdana";
        textFormat.size = 16;
        textFormat.color = 0xffffff;

        var textFormat2:TextFormat = new TextFormat();
        textFormat2.font = "Verdana";
        textFormat2.size = 16;
        textFormat2.color = 0x00dd00;
*/
        var textFormat:TextFormat = new TextFormat();
        textFormat.font = Settings.FONT;
        textFormat.size = 40;
        textFormat.color = 0xFF0000;
        textFormat.align = TextAlign.CENTER;

        var textFormat2:TextFormat = new TextFormat();
        textFormat2.font = Settings.FONT;
        textFormat2.size = 40;
        textFormat2.color = 0xFF0055;
        textFormat2.align = TextAlign.CENTER;



        name.textRendererFactory =function():ITextRenderer
        {
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.textFormat = textFormat;
            textRenderer.nativeFilters = [new DropShadowFilter()];
            return textRenderer;
        };

        join.labelFactory =function():ITextRenderer
        {

            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.textFormat = textFormat;
            textRenderer.nativeFilters = [new DropShadowFilter()];

//            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
//            textRenderer.textFormat = textFormat;
            return textRenderer;
        };

        join.defaultLabelProperties.textFormat = textFormat;
        join.hoverLabelProperties.textFormat = textFormat2;

        join.addEventListener(Event.TRIGGERED,onJoinHandler);
    }

    private function onJoinHandler(event:Event):void {
        Game.instance.startGame();
    }
}
}
