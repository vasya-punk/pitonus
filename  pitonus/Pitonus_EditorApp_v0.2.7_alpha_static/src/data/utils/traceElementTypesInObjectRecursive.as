package data.utils
{
	import utils.*;

		public function traceElementTypesInObjectRecursive( obj:*, d:uint = 0):void {
			if(!d)
				trace("_________________________________");
				
			
			for ( var item:String in obj) {
				if( !(obj[item] is String)){
					traceObjectTreeRecursive(obj[item],++d);
				}else {
					if(item == "elementType"){
						trace( prefix(d) + " '" + item + "' : " + obj[item] );
					}
				}
			}

			if(d==1)
				trace("_________________________________");
		}


}