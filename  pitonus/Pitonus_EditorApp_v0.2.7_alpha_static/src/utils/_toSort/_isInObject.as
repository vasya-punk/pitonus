package  Utils
{

		public function isInObject( what:*, inTrg:Object ):Boolean{
			for ( var item:String in inTrg) {
				
					if ( inTrg[item] == what)
						return true;
					else
						return false;
			}
		}


}