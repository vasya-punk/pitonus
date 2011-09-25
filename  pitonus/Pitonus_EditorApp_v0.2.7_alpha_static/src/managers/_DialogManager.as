package managers
{
    import flash.display.Sprite;
    import flash.events.Event;
    import events. * ;
    import ui. * ;
	import ui.panels.elements.ElementsPanel;
    import ui.pinbar. * ;
    import com.sibirjak.asdpcbeta.window.core.WindowPosition;
    import com.sibirjak.asdpcbeta.window.Window;
    import com.sibirjak.asdpc.core.constants.Position;
    import ui.windows. * ;
    import com.greensock. * ;
    import com.greensock.easing. * ;
    import ui.windows.NavigationWindow;
	import ui.panels.project.*;
	import ui.panels.*;
	import ui.dialogs.create.*;

    public class DialogManager extends Sprite
    {

		// Editor Components

		private var dialogOverlay:Sprite;
		private var dialogs:Array;
		private var _rec:*;
		
        public function DialogManager( rec : * ) {
        
			_rec = rec;
			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }
		
		public function update():void {
			trace("[Error] Dialog Update");
		}
		
        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
			dialogs = new Array();
			dialogOverlay = new Sprite();
			addChild(dialogOverlay);
	
        }
		public function addDialog(dialog:*):void {
			cleanUp();
			dialogOverlay.addChild(dialog);
			dialogs.push(dialog);
		}
					
		public function cleanUp():void {
			var i:int = 0;
			for ( i = 0; i < dialogs.length; i++) {
				dialogs[i].cleanUp();
			}
			dialogs = null;
			dialogs = new Array();
			for ( i = 0; i < dialogOverlay.numChildren; i++) {
				//trace("--------------------> " + i);
				dialogOverlay.removeChildAt(i)
			}
		
		}

      
    }

}