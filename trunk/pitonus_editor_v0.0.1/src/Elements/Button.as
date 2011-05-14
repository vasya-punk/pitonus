package Elements 
{

	import flash.display.Sprite;
	import Utils.*;
	import Configuration.*;
	import flash.display.*;

	public class Button extends ActiveElement implements IElement
	{

		public function Button() {

		}
		override public function init( obj:Object ):void {
			
			_properties = obj;

			var properties:Object =  new Object();
			properties["caption"] 	= Attributes.INPUT
			properties["action"]	= Attributes.LIST;

			if (this.validateProperties(properties)) {					
				clickTarget = new TextButton(this.getProperty("caption"));

				addChild(clickTarget);
				
				setPosition();

			}
		}
		
		public function set setLabel(value:String):void {
			this.setProperty("caption", value);
			var trg:TextButton = clickTarget as TextButton;
			trg.changeLabel(this.getProperty("caption"));
		}
		
		public function get getLabel():String {
			return this.getProperty("caption");
		}
		
		override public function update( obj:Object ):void {
			
			for(var item:String in obj){
				this.setProperty(item, obj[item]);
			}
			this.setPosition();
			this.setLabel = this.getProperty('caption')  ;
		}
	}

}

