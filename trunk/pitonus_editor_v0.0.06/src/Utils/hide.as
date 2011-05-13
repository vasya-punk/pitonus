package Utils
{
	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;

	import flash.display.DisplayObject;
	
	public function hide( mc:*):void {		
		TweenLite.to( mc, Config.ANIMATION_DELAY, { autoAlpha:0 } );
	}
	
}