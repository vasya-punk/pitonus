package managers 
{
	import com.senocular.display.Layout;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class DisplayLayoutManager extends Sprite 
	{
		private var stageLayout:Layout;
		private var fullscreenLayouts:Array = new Array();
		
		public function DisplayLayoutManager():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point


			// don't scale flash player contents and
			// keep the SWF at the top left of the player
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;

			// when using the stage as a layout target
			// the layout will automatically fit to
			// stage.stageWidth and stage.stageHeight and
			// draw its children when the stage resizes
			
			stageLayout = new Layout(stage);

			


			// draw the stage layout now
			// to update children layouts
			// when the SWF first loads.
			// other updates will be handled 
			// when the stage resizes
			stageLayout.draw();
			
			dispatchEvent( new Event( Event.ADDED_TO_STAGE ) );
		}

		public function addToLayout( trg:*, position:String, marginX:uint = 0, marginY:uint = 0 ):void {
			
			
			for (var i:int = 0; i < fullscreenLayouts.length; i++) {
				stageLayout.removeChild(fullscreenLayouts[i]);
				fullscreenLayouts = new Array();
			}
			
			// reference to store newly created layouts
			// each layout created will relate to a different
			// object on the screen
			var layout:Layout;

			// using addChild() with the new layouts you 
			// can createa  layout hierarchy relations without
			// relying on a LayoutManager instance. Alternatively
			// you can set the parent property of a layout to
			// identify a parent layout

			// the default change handler is used to fit
			// the box movie clips to the stage's layout
			

			layout = new Layout(trg, true);
			
			switch (position) {
				case Config.ALIGN_TOP_LEFT	: 
				default:
					layout.top = marginY;
					layout.left = marginX;
				break;
				
				case Config.ALIGN_TOP_CENTER: 
					layout.horizontalCenter = marginX;
					layout.top = marginY;
				break;
				
				case Config.ALIGN_TOP_RIGHT: 
					layout.right = marginX;
					layout.top = marginY;
				break;
				
				case Config.ALIGN_BOTTOM_LEFT: 
					layout.bottom = marginY;
					layout.left = marginX;
				break;
				
				case Config.ALIGN_BOTTOM_CENTER: 
					layout.horizontalCenter = marginX;
					layout.bottom = marginY;
				break;
				
				case Config.ALIGN_BOTTOM_RIGHT: 
					layout.right = marginX;
					layout.bottom = marginY;
				break;
				
				case Config.ALIGN_LEFT_CENTER: 
					layout.verticalCenter = marginY;
					layout.left = marginX;
				break;
				
				case Config.ALIGN_RIGHT_CENTER: 
					layout.verticalCenter = marginY;
					layout.right = marginX;
				break;
				
				case Config.ALIGN_CENTER: 
					layout.horizontalCenter = marginX;
					layout.verticalCenter = marginY;
				break;
				
				case Config.ALIGN_FULLSCREEN: 
					layout.horizontalCenter = 0;
					layout.verticalCenter = 0;
					layout.percentHeight = 1.0;
					layout.percentWidth = 1.0;
					fullscreenLayouts.push(layout);
				break;


			}
			stageLayout.addChild(layout);
			stageLayout.draw();
		}
	}
}