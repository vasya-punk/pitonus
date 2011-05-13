package Elements 
{
	import flash.display.DisplayObject;
	import Elements.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import Utils.*;
	
	public class StaticText extends ActiveElement implements IElement
	{
		private var fulltext:TextField;
		private var label:TextField;		
										
		public function StaticText(obj:Object = null) {
			if(obj != null){
				super(obj);
				this.init(obj);
			}	
		}
		
		private function init(obj:Object):void {
			// essential properties
			var properties:Array =  new Array(
										"briefText",
										"fullText",
										"w",
										"h",
										"x",
										"y"
										);
										
			if(this.validateProperties(properties)){	
				fulltext = new TextField();
				fulltext.autoSize = TextFieldAutoSize.LEFT;
				fulltext.width = 500;
				fulltext.wordWrap = true;
				fulltext.border = false;
				fulltext.multiline = true;
				fulltext.height = 250;
				fulltext.y += 20;
				//var format:TextFormat = new TextFormat("Verdana");
				//fulltext.defaultTextformat(format);
				
				fulltext.text = obj['fullText'];
				addChild(fulltext);
			
				label = new TextField();
				label.width = 500;
				label.wordWrap = false;
				label.selectable = false;
				label.border = false;
				label.multiline = false;
				label.height = 25;
				label.text = obj['briefText'];
				addChild(label);
				
				var rectangle:Shape = new Shape; // initializing the variable named rectangle
				rectangle.graphics.beginFill(0xDBDBDB, 0.1); // choosing the colour for the fill, here it is red
				rectangle.graphics.drawRect(0, 0, int(this.getProperty("w")), int(this.getProperty("h"))); // (x spacing, y spacing, width, height)
				rectangle.graphics.endFill(); // not always needed but I like to put it in to end the fill
				
				
				var trg:Sprite = new Sprite();
				trg.addChild(rectangle);
				addChild(trg);
				
				clickTarget = trg;
				
				//obj['initialized'] = true;
			}
		}
		
		override public function update(obj:Object):void {
			for(var item:String in obj){
				this.setProperty(item, obj[item]);
			}
			this.setPosition();

			label.text = this.getProperty('briefText');
			fulltext.text = this.getProperty('fullText');
		}
	}

}