package Utils
{
	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	import flash.display.DisplayObject;
	
	public function show( mc:*):void {
		mc.alpha = 0;
		TweenLite.to( mc, Config.ANIMATION_DELAY, { autoAlpha:1 } );
	}
	
}