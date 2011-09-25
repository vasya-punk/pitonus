package elements.utils
{
	import data.*;
	import data.utils.*;

	public function createElement(  runtimeClassRef:Class, node:DataNode  ):*{
		var element:* = new runtimeClassRef( node );
		return element;
	}
}
