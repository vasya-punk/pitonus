package Elements 
{
	import com.sibirjak.asdpc.textfield.Label;
	import flash.display.Sprite;
	
	import Utils.*;
	import Configuration.*;
	
	public class ActiveImage extends ActiveElement implements IElement
	{
		//private var  AIClip:ActiveImageClip;
		
		

		
		override public function init( obj:Object ):void {
			
			_properties = obj;
			
			var properties:Object =  new Object();
			properties["caption"] 	= Attributes.INPUT
			properties["src"]		= Attributes.UPLOAD;
			properties["w"]			= Attributes.NUMBER;
			properties["h"]			= Attributes.NUMBER;

			if( validateProperties(properties) ){		
			
				/*this.AIClip = new ActiveImageClip();
				this.addChild(AIClip);
				var load:LoadFromURL = new LoadFromURL( this.AIClip.imageTarget, this.getProperty("src"),  "");
				this.AIClip.caption.text = this.getProperty("caption");*/
				
				var w:int = int(this.getProperty("w"));
				var h:int = int(this.getProperty("h"));
				var  AIClip:Sprite  = new drawRoundBox( w, h, 0xbcbcbc, 1, 0xb1b1b1, 2);
				
				var loadTarget:Sprite = new Sprite();
				loadTarget.x = 5; loadTarget.y = 5;
				
				
				var load:LoadFromURL = new LoadFromURL( loadTarget, this.getProperty("src"),  "", w-10, h-25);
				var caption:Label = new Label();
				caption.y = h - 20;caption.x = 10;
				caption.text = this.getProperty("caption");
				AIClip.addChild(caption);
				
				AIClip.addChild(loadTarget);
				addChild(AIClip);

				this.addClickTarget();	
				
				
			}
			
		}
		

		
	}

}