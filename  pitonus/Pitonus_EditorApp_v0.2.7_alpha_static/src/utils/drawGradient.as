package utils 
{

	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import flash.display.Shape;

	
	public function drawGradient(w:int = 200, h:int = 100):Shape{   	

			
			//var _radius:Number = 3;
			//var _margin:Number = 15;
			var _width:Number =  w;
			var _height:Number =  h;

			//Type of Gradient we will be using
			var fType:String = GradientType.LINEAR;
			//Colors of our gradient in the form of an array
			var colors:Array = [ 0x3e3e3e,  0x595959 ];
			//Store the Alpha Values in the form of an array
			var alphas:Array = [ 1, 1 ];
			//Array of color distribution ratios.  
			//The value defines percentage of the width where the color is sampled at 100%
			var ratios:Array = [ 0, 255 ];
			//Create a Matrix instance and assign the Gradient Box
			var matr:Matrix = new Matrix();
			matr.createGradientBox( 200, _height, toRad(-90) , 0, 0 );
			//SpreadMethod will define how the gradient is spread. Note!!! Flash uses CONSTANTS to represent String literals
			var sprMethod:String = SpreadMethod.REPEAT;
			//Start the Gradietn and pass our variables to it
			//var sprite:Sprite = new Sprite();
			//Save typing + increase performance through local reference to a Graphics object
			
			var shape:Shape = new Shape();
			
			var g:Graphics = shape.graphics;
			g.beginGradientFill( fType, colors, alphas, ratios, matr, sprMethod );
			g.lineStyle(1, 0x303030);
            g.drawRect( 0,  0, _width, _height);
            g.endFill();
			
		
			return shape;
			
			
		}
	


}