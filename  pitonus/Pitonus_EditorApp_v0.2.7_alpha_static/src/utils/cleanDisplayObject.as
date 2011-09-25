package utils
{

	import flash.geom.Rectangle;

	public function cleanDisplayObject(parentMc:*, mc:*) : void {
				
		if (parentMc){
			if (parentMc.stage) {
				if (mc) {
					if (mc.stage) {
						parentMc.removeChild(mc);
						mc = null;
					}
				}
			}
		}
	}
		

}
