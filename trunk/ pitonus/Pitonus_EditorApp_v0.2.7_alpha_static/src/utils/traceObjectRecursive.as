package  utils
{

		public function traceObjectRecursive( obj:*, d:uint = 0):void {
			if(!d)
				trace("_________________________________");
				
			
			for ( var item:String in obj) {
				if( !(obj[item] is String))
					traceObjectRecursive(obj[item],++d)
				else{
					
					if (item == "elementType") { trace( item + " ::: " + obj[item]); }
					else{ trace( item + " : " + obj[item]); }
				}
			}
		
			
			if(!d)
				trace("_________________________________");
		}


}