package utils
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	public function getClass(obj:Object):Class {
		return Class( getDefinitionByName( getQualifiedClassName(obj) ) );
	}
}
