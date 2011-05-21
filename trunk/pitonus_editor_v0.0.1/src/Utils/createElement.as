package Utils
{
	import Managers.DataNode;

	public function createElement(  runtimeClassRef:Class, node:DataNode  ):*{
		var element:* = new runtimeClassRef( node );
		return element;
	}
}
