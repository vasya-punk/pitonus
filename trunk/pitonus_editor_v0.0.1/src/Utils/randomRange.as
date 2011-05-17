package Utils 
{
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */

		public function randomRange( minSize : uint = 0, maxSize : uint = 100) : Number
		{
			return Math.round(Math.random() * (maxSize - minSize)) + minSize;
		}
		


}



