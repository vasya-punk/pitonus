package Elements 
{
	import flash.display.Sprite;
	
	import Utils.*;
	
	public class Icon extends ActiveElement implements IElement
	{
		public function Icon(obj:Object = null) 
		{
			if(obj != null){
				super(obj);
				this.init(obj);
			}
			

		}
		private function init(obj:Object):void {
			
			var ico:Sprite = new Icon_AddPage();
			ico.scaleX = ico.scaleY = Config.ICONS_SCALE_RATIO;

			ico.addChild(createTextField("Add", 36, true, 21, 128));
			this.addChild(ico);

			clickTarget = ico;

		}

		
	}

}