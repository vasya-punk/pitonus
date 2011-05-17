package  
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Utils.SimpleEvent;
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class test  extends Sprite
	{
		
		public function test() 
		{
			
			
			
			var element:Sprite = new Sprite();
			var element1:Sprite = new Sprite();
			var element2:Sprite = new Sprite();
			
			element.name = "element";
			element1.name = "element1";
			element2.name = "element2";
			
			with (element.graphics) {
				beginFill( 0xDDDDDD , 0.5 );
				drawRect( 10, 10, 80, 80);
			}
			
			with (element1.graphics) {
				beginFill( 0xD3DDDD , 0.5 );
				drawRect( 50, 50, 120, 120);
			}
			
			with (element2.graphics) {
				beginFill( 0xD31DDD , 0.5 );
				drawRect( 100, 100, 180, 180);
			}
			
			element1.addChild(element2);
			element.addChild(element1);
			addChild(element);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,func2)
			//element.addEventListener(SimpleEvent.SIMPLE_EVENT,oo)
			function func1(e:SimpleEvent):void {
							trace(">>> " + e);
			}
			function func2(e:MouseEvent):void {
							trace(">>> " + e.currentTarget.name + " : " + e.target.name);
			}
			
			deepTrace(this);
			
		}
		
		public function deepTrace(d:DisplayObjectContainer, indent:String = ''):void{
			var i:int = 0;
			var o:*;
			while(i < d.numChildren){
				o = d.getChildAt(i);
				if(o is DisplayObjectContainer){
					//trace(o);
					trace(indent + o.name);
					deepTrace(DisplayObjectContainer(o), indent + '\t');
				} else {
					//trace(o);
					trace(indent + o.name);
				}
				i++;
			}
		}
	}

}