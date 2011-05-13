package Utils.Console
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import Utils.*;

	internal class _Alert extends Sprite 

	{
		private var popup:Sprite;
		private var closeBtn:Sprite;
		
		private var _ready:Boolean = false;
		
		public function _Alert():void { }
		
		public function out( str:*,  ...additionalLines):void {
			
			
			hideTrace();
			init();

			var txt:String = String(str);
			var tf:TextField = createTextField(txt);

			for (var i:uint = 0; i < additionalLines.length; i++) {
   				tf.appendText("\n......................\n" + additionalLines[i]);
			}
			
			var background:Sprite = new Sprite();

			background.graphics.lineStyle(2,0xB5B5B5);
			background.graphics.beginFill(0xD7D7D7);
			background.graphics.drawRoundRect(0, 0, tf.width + 50, tf.height + 50, 9, 9);
			background.graphics.endFill();
			
			closeBtn = new Sprite();
			closeBtn.name = "closeBtn";
			closeBtn.graphics.beginFill(0x7B3104);
			closeBtn.graphics.drawRoundRect( background.width - 25, 5, 16, 16, 6, 6);
			closeBtn.graphics.endFill();
			
			closeBtn.addEventListener(MouseEvent.CLICK, hideTrace, false, 0, true );		
			
			popup.addChild(background);		
			show(background);
			popup.addChild(tf);
			popup.addChild(closeBtn);
			
			_ready = true;
			
			popup.x = 500; //this.stage.width / 2 - popup.width / 2;
			popup.y =  250;// this.stage.height / 2 - popup.height / 2;	
			
		}
		
		public function init( parentMc:DisplayObjectContainer = null):void {
			popup = new Sprite();
			this.addChild(popup);
			
			if(parentMc != null)
				parentMc.addChild(this);
		}
		
		public function hideTrace(e:MouseEvent = null):void {
			if (_ready) {

				this.closeBtn.removeEventListener(MouseEvent.CLICK, hideTrace);
				for (var i:uint = 0; i < popup.numChildren ; i++ ) {
					popup.removeChildAt(i);
				}
			
				this.removeChild(popup);
				popup = null;
			
			}
			_ready = false;

		}
	}
	
}
			
