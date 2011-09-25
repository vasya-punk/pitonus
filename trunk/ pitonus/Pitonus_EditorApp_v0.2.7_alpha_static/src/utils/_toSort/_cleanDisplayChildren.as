package Utils 
{
	import flash.display.Sprite;

			public function cleanDisplayChildren( mc:* ):void {
				
				for (var i:uint = 0; i < (mc as Sprite).numChildren; i++  ) {
					(mc as Sprite).removeChildAt(i);
				}
			}
	


}