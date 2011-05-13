package  Utils
{

		public function isIn( what:*, inTrg:Object ):Boolean{
			for ( var item:String in inTrg) {
				
					if ( inTrg[item] == what)
						return true;
					else
						return false;
			}
		}


}