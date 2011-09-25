package elements {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import com.senocular.display.Layout;
	import com.senocular.display.LayoutManager;
	
	/**
	 * Base class for a MovieClip using
	 * a Layout. To fit to a layout, the bottom most
	 * child display object is resized to match
	 * the layout's size.
	 */
	public class LayoutObject extends Sprite {
		
		/**
		 * Layout object assocaitated with this
		 * instance [read-only].
		 */
		private var _layout:Layout;
		public function get layout():Layout {
			return _layout;
		}
		
		/**
		 * Constructor.
		 */
		public function LayoutObject(){
			super();
			
			// register and create a layout for this
			// instance that is assocaitated with the 
			// LayoutManager class (singleton)
			_layout = LayoutManager.registerNewLayout(this);
			_layout.addEventListener(Event.CHANGE, updateLayout);
		}
		
		/*
		 * Layout CHANGE event handler. Resizes the background
		 * (bottom-most) display object to fit the bounds
		 * of the instance's layout 
		 */
		private function updateLayout(event:Event):void {
			
			// get the rect from the Layout instance
			// that dispatched the CHANGE event (_layout)
			var bounds:Rectangle = Layout(event.target).rect;
			
			// position instance to location
			// specified in the layout rect
			x = bounds.x;
			y = bounds.y;
			
			// resize the bottom-most display object
			// (if there) to fit the size of the layout rect
			if (!numChildren) return;
			var bg:DisplayObject = getChildAt(0);
			bg.width = Math.max(0, bounds.width);
			bg.height = Math.max(0, bounds.height);
		}
	}
}