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

    public class PanelsManager extends Sprite
    {

		// Editor Components
		private var panelElements:ElementsPanel;
		private var panelProject:ProjectPanel ;

		private var _rec:*;
		
        public function PanelsManager( rec : * ) {
        
			_rec = rec;
			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }
		
		public function updatePanels():void {
			trace("[i][m] PanelsManager - UpdatePanels() : panelProject.update()" );
			panelProject.update();
		}
		
        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
			panelElements  = new ElementsPanel(_rec);
			addChild(panelElements);
			
			panelProject  = new ProjectPanel (_rec);
			addChild(panelProject);

			

        }
	
		

      
    }

}