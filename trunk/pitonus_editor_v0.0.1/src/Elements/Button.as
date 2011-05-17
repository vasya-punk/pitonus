package Elements 
{

	import flash.display.Sprite;
	import Utils.*;
	import Configuration.*;
	import flash.display.*;

	public class Button extends ActiveElement implements IElement
	{

		public function Button( node:Node) {	
			super( node );
		}
		
		override public function init( ):void {
		

			var editableProperties:Object =  new Object();
			editableProperties["caption"] 	= Attributes.INPUT
			editableProperties["action"]	= Attributes.LIST;

			if (this.validateProperties( editableProperties )) {
				
				clickTarget = new TextButton(this.getProperty("caption"));

				addChild(clickTarget);
				
				setPosition();

			}else {
				
					trace( "Found button without action");
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

