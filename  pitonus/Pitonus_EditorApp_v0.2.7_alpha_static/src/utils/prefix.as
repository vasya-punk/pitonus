package utils
{

	public function prefix(depth : uint) : String {

                        var prefix : String = "";
                        for (var i : uint = 0; i < depth; i++) 
							prefix += ".";
                        return prefix;
        }
}