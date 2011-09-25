package utils
{
	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	import flash.display.DisplayObject;
	
	TweenPlugin.activate([ TintPlugin, ColorTransformPlugin]);

	public function tint( mc:*,  on:Boolean = true, color:uint = 0xE4E4E4):void {
		var ta:Number = (on) ? 0.85 : 0.0;
		TweenLite.to( mc, 0.05, {colorTransform:{tint:color, tintAmount:ta}} );
	}
	
}