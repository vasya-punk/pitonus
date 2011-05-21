package Elements 
{

	import flash.display.Sprite;
	import Managers.DataNode;
	import Utils.*;
	import Configuration.*;
	import flash.display.*;

	public class Button extends ActiveElement implements IElement
	{

		public function Button( node:DataNode) {	
			super( node );
		}
		
		override public function init( ):void {
		

			var editableProperties:Object =  new Object();
			editableProperties["caption"] 	= Attributes.INPUT
			editableProperties["action"]	= Attributes.LIST;

			if (this.validateProperties( editableProperties )) {
				
				var w:uint = ( this.isProperty("w") )? int(this.getProperty("w")) : 152;
				var h:uint = ( this.isProperty("h") )? int(this.getProperty("h")) : 25;
				clickTarget = new TextButton(this.getProperty("caption"), w, h);

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

