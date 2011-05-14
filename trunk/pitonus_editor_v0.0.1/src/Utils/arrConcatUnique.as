package Utils
{

	public function arrConcatUnique(...args):Array
	{
		var retArr:Array = new Array();
		for each (var arg:* in args)
		{
			if (arg is Array)
			{
				for each (var value:* in arg)
				{
					if (retArr.indexOf(value) == -1)
						retArr.push(value);
				}
			}
		}
		return retArr;
	}
}
