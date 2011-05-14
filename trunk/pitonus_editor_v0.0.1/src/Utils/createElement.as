package Utils
{

	public function createElement(  runtimeClassRef:Class, obj:Object ):*{
		var element:* = new runtimeClassRef();
		element.init(obj);
		return element;
	}
}
