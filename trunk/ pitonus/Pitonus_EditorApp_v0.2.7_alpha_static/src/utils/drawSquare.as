package utils
{

	import flash.geom.Rectangle;

	public function drawSquare(parentMc:*, rect : Rectangle, alpha:Number = 0.5) : void {
				
		/*if (rect.width) {
			rect.inflate(10, 10);
		}*/
		if (parentMc) {
			with (parentMc.graphics) {
				clear();
				beginFill( Config.COLOR_DEFAULT_BACKGROUND, alpha );
				drawRect( rect.x, rect.y, rect.width, rect.height);
			}
		}
	}
		

}
