package Utils
{

	import flash.geom.Rectangle;

	public function drawSquare(parentMc:*, rect : Rectangle) : void {
				
		if (rect.width) {
			rect.inflate(10, 10);
		}
		if (parentMc) {
			with (parentMc.graphics) {
				clear();
				beginFill( 0x969696 , 0.5 );
				drawRect( rect.x, rect.y, rect.width, rect.height);
			}
		}
	}
		

}
