package Elements 
{
	import com.sibirjak.asdpc.textfield.Label;
	import flash.display.Sprite;
	
	import Utils.*;
	import Managers.*;
	import Configuration.*;
	
	public class ActiveImage extends ActiveElement implements IElement
	{
		//private var  AIClip:ActiveImageClip;
		
		
		public function ActiveImage( node:DataNode) {	
			super( node );
		}
		
		override public function init():void {
			

			var editableProperties:Object =  new Object();
			editableProperties["caption"] 	= Attributes.INPUT
			editableProperties["src"]		= Attributes.UPLOAD;
			editableProperties["w"]			= Attributes.NUMBER;
			editableProperties["h"]			= Attributes.NUMBER;

			if( validateProperties(editableProperties) ){		
			
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