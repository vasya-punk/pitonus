package utils{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public function dashHorizontal(x : int, y : int, width : int) : Sprite {

				var r1 : Rectangle= new Rectangle(0, 0, 2, 1);
				var r2 : Rectangle = new Rectangle(2, 0, 2, 1);
				
				var separator:Sprite = new Sprite();
				var horizontalTile : BitmapData = new BitmapData(4, 1, true);
				horizontalTile.fillRect(r1, (0xFF << 24) + 0xCCCCCC);
				horizontalTile.fillRect(r2, 0x00000000);
	
				with (separator.graphics) {
					lineStyle();
					beginBitmapFill(horizontalTile, null, true);
					drawRect(x, y, width, 1);
					endFill();
				}
				return separator;
			}
}