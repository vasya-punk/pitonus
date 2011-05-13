package  Elements
{
	public interface IElement
	{
		function setProperty(prop:String, value:String):Boolean;
		function getProperty(prop:String):String; 
		function isProperty(prop:String):Boolean; 
		function getProperties():Array;
		
		// Should be override in extended Classes !!!
		function init(obj:Object):void;			
		function update(obj:Object):void;			
		function cleanUp():void;	
		
		/*function get id():uint;
		function set id(value:uint):void;	*/
	}

}

