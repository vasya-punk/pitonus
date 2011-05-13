package Utils
{

	public function prefix(depth : uint) : String {
						if (depth == 0)
							return "[pages] ";
                        var prefix : String = "";
                        for (var i : uint = 0; i < depth; i++) 
							prefix += ".";
                        return prefix;
        }
}