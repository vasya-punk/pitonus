package utils 
{

	public function toBoolean( str:String ):Boolean {
		return ( String(str).toLowerCase() == "true") ? true : false;
	}


}