package  elements
{
	public interface IElement
	{
		/*function setProperty(prop:String, value:String):Boolean;
		function getProperty(prop:String):String; 
		function isProperty(prop:String):Boolean; 
		function getProperties():Array;*/
		
		// Should be override in extended Classes !!!
		function init( )				:void;			
		function update( )				:void;	
		function draw( )				:void;	
		//function cleanUp()					:void;	

	}

}

