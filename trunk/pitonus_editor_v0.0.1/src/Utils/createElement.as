package Utils
{

	public function createElement(  runtimeClassRef:Class, node:Node  ):*{
		var element:* = new runtimeClassRef( node );
		return element;
	}
}
