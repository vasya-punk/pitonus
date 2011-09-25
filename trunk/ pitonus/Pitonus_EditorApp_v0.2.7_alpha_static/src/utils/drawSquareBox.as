package utils 
{
		import flash.display.Shape;
		import flash.display.Sprite;
		import flash.display.Graphics;
		
		public class drawSquareBox extends Sprite {
			
			public function drawSquareBox(w:uint, h:uint, color:uint,  alpha:Number, borderColor:uint = 0, borderWidth:uint = 0) {   
				var background:Shape = new Shape();
				background.graphics.beginFill(color, alpha);
				if(borderColor && borderWidth)
					background.graphics.lineStyle(borderWidth, borderColor);
				background.graphics.drawRect( 0, 0, w, h);
				addChild(background);
			}
		}


}