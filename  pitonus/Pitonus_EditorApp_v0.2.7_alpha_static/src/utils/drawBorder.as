package utils
{

	import flash.geom.Rectangle;

	public function drawBorder(parentMc:*, rect : Rectangle) : void {
				
		/*if (rect.width) {
			rect.inflate(10, 10);
		}*/
		if (parentMc) {
			with (parentMc.graphics) {
				clear();
				lineStyle(3, Config.COLOR_DEEP_CALM_BLUE);
				//beginFill( Config.COLOR_DEFAULT_BACKGROUND, 0.1 );
				drawRect( rect.x, rect.y, rect.width, rect.height);
				
			/*	trace(rect.x);
				moveTo(rect.x, rect.y);
				lineTo(rect.width, rect.y);
				lineTo(rect.width, rect.height);
				lineTo(rect.x, rect.height);
				lineTo(rect.x, rect.y);*/
			}
		}
		
		
	
		
		
	}
		

}
