package utils
{
	public function objectLength(myObject:Object):int {
					var cnt:int=0;
					for (var s:String in myObject) {
						//trace("    !");
						cnt++;
					}
					return cnt;
	}
}