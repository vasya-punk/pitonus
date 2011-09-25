


package ui.panels
{
	import events.*;
	public interface IPanel
	{
        //function init( e : Event = null ) : void;
		function drawPanel():void;
		function setSize( e : ControlEvent = null ) : void;
		function cleanUp():void;
	}

}


