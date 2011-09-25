package ui.panels
{
	import data.DataNode;
	import controls.*;
	import events.ControlEvent;
	import managers.*
	import data.utils.*;
	import utils.*;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	
	public class Panel extends Sprite implements IPanel
	{
		protected var _control:ControlWrapper;
		protected var _rec:*;
		protected var _background:BackgroundSkin;
		protected var tabLayout : ILayout;
		
		public function Panel(rec:*) {
			
			_rec = rec;
			
            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        public function init( e : Event = null ) : void 	{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point

			drawPanel();	
			
		}
		
		public function drawPanel():void {}
	
		public function setSize( e : ControlEvent = null ) : void 	{

            if ( ! _background ) {

                tabLayout = vgroup(
                "offsetX", 0,
                "offsetY", 0,
                "hGap", 8,
                "vGap", 4,

                _control
                );

                tabLayout.layout( this );

                _background = new BackgroundSkin();
                _background.setSize( tabLayout.visibleRect.width, tabLayout.visibleRect.height );
                addChildAt( _background, 0 );
                //DataManager.layout.addToLayout( this, Config.ALIGN_TOP_RIGHT );
            }
            else {
                tabLayout.layout( this );
                _background.setSize( tabLayout.visibleRect.width, tabLayout.visibleRect.height);
            }

        }
		
		public function get control():* {
			return _control;
		}
		
		public function cleanUp():void {
			if(_control){
				_control.destroy();
				cleanDisplayObject(_control, this);
			}
			cleanDisplayObject(_background, this);
			
		}
	}

}