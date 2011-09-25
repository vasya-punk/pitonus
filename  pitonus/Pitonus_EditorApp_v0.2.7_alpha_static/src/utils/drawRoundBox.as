package utils 
{
		import flash.display.Shape;
		import flash.display.Sprite;

		public class drawRoundBox extends Sprite {
			
			public function drawRoundBox(w:uint, h:uint, color:uint,  alpha:Number = 1, borderColor:uint = 0, borderWidth:uint = 0) {   
				var background:Shape = new Shape();
				background.graphics.beginFill(color, alpha);
				if(borderColor && borderWidth)
					background.graphics.lineStyle(borderWidth, borderColor);
				background.graphics.drawRoundRect(0, 0, w, h, Config.ROUND_CORNERS);
				addChild(background);
			}
		}


}