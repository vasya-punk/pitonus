package  managers
{
	import com.senocular.display.*;
	import elements.canvas.Canvas;
	import elements.Element;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import utils.*;
	import events.*;
	
	public class TransformToolManager extends Sprite {
		
		private var _activeElements:Array;
		private var _selectedElement:*;
		
		private var mouseTarget:Object;
		private var mouseOffset:Point;
		private var layout:Layout;
		private var border:Sprite;
		
		private var boxDragger:Sprite;
		private var _canvas:Canvas;
		
		public function TransformToolManager() {

			if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }
		
		public function set selectedElement(element:*):void { 
			_selectedElement = element;
		}
		
		public function get canvas():Canvas { 
			return _canvas;
		}
		
		public function get selectedElement():* { 
			return _selectedElement;
		}

		public function get activeElements():Array { 
			return _activeElements;
		}
		
		public function set activeElements(elements:Array):void{ 
			_activeElements = elements;
			registerElements();
			trace("[i][m] TransformToolManager - update/activeElements(), elements count: " + (elements as Array).length);
		}

        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
			
			//============================= TransformTool ===================================

			selectedElement = null;// _activeElements[0];

			LayoutManager.initializeAutoUpdate(stage);

			layout = new Layout(selectedElement, true);

			boxDragger = new dragger();
			
			
			// references to mouse properties
			// for dragging operations
			mouseOffset= new Point();
			border = new Sprite();
			addChild(border);
			//addChild(boxDragger);

			boxDragger.addEventListener(MouseEvent.MOUSE_DOWN, startMouseAction);

			//dispatchEvent(new TransformToolEvent(TransformToolEvent.UPDATE_ELEMENT, selectedElement));
							
		}
		
		// starting drag operation
		// while dragging during mouse move event
		private	function whileMouseAction(event:MouseEvent = null):void {
				
			var boxLayout:Layout = layout;// new Layout(cbox, true);// 
			
			// move or resize layout based on
			// which instance was being dragged
			var snap:uint = Config.GRID_SNAP;
			
			switch(mouseTarget) {
				default:
					var dx:Number = mouseX + mouseOffset.x;
					var dy:Number = mouseY + mouseOffset.y;
					boxLayout.x = dx - dx%snap;
					boxLayout.y = dy - dy % snap;
					break;
				case boxDragger:
					selectedElement.w = mouseX - selectedElement.x;
					selectedElement.h = mouseY - selectedElement.y;
					boxLayout.width = mouseX - selectedElement.x;
					boxLayout.height = mouseY - selectedElement.y;
					break;
			}
			
			// update the layout
			boxLayout.draw();
			
			// update the location ofthe dragger clip
			var boxRect:Rectangle = boxLayout.rect;
			
			selectionBorder(boxRect);
			boxDragger.x = boxRect.right;
			boxDragger.y = boxRect.bottom;

			if (selectedElement) {
				//trace("TransformToolManager.UPDATE_ELEMENT : whileMouseAction()");
				dispatchEvent(new TransformToolEvent(TransformToolEvent.UPDATE_ELEMENT, selectedElement));
			}
					
		}

		private function selectionBorder(rect:Rectangle):void {
				//this.setChildIndex(border, 0)
				//setChildIndex(border,0);
				drawBorder(border, rect);	
		}
		
		private function stopMouseAction(event:MouseEvent):void {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, whileMouseAction);
				stage.removeEventListener(MouseEvent.MOUSE_UP, stopMouseAction);
		}
		
		public function updateSelectionBox():void { 
			if (selectedElement){
				var boxRect:Rectangle = new Rectangle(layout.x, layout.y, selectedElement.w, selectedElement.h);
				boxDragger.x = boxRect.right;
				boxDragger.y = boxRect.bottom;
				selectionBorder(boxRect);
			}
		}

		
		public function registerElements( ):void { 
			
			if(activeElements){
				for (var i:int = 0; i < activeElements.length; i++) {
					activeElements[i].addEventListener(MouseEvent.MOUSE_DOWN, startMouseAction);
					if ( (activeElements[i] as Element).elementType == "TextBlock" ) {
						activeElements[i].mouseChildren = false;
						activeElements[i].doubleClickEnabled = true;
						activeElements[i].addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
					}
				}
			}
		}
		
		private function onDoubleClick( e:MouseEvent):void { 
			//trace("TransformToolManager.DOUBLE_CLICK : onDoubleClick()");
			dispatchEvent(new TransformToolEvent(TransformToolEvent.DOUBLE_CLICK, selectedElement));	
		}
		
		public function update(elements:Array):void { 
			unRegisterElements();
			activeElements = elements;
		}
		
		
		public function unRegisterElements():void { 
			//if(activeElements){
				for (var i:int = 0; i < activeElements.length; i++) {
					activeElements[i].removeEventListener(MouseEvent.MOUSE_DOWN, startMouseAction);	
				}
				_activeElements = [];
			//}
		}
		
		public function deselect():void { 
			selectedElement = null;
			if (boxDragger.stage)
				removeChild(boxDragger);
			border.graphics.clear();
			
		}
		
		private function startMouseAction(event:MouseEvent):void {

			stage.addEventListener(MouseEvent.MOUSE_MOVE, whileMouseAction);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopMouseAction);
			
			// remember which instance was clicked
			mouseTarget = event.currentTarget;
			
			var elementTypeNum : int =  activeElements.indexOf( mouseTarget );
			if ( elementTypeNum != - 1 ){
				selectedElement = activeElements[elementTypeNum];
				//updatePropertiesWindow(selectedElement);
				//trace("TransformToolManager.SELECT_ELEMENT : startMouseAction()");
				dispatchEvent(new TransformToolEvent(TransformToolEvent.SELECT_ELEMENT, selectedElement));
			}
			
			//cbox = selectedElement;

			//trace("startMouseAction: " + selectedElement.name);
			layout = new Layout(selectedElement,true);

			// Update selection handle
			if (!boxDragger.stage){
				addChild(boxDragger);
			}
			
			var boxRect:Rectangle = layout.rect;	
			boxDragger.x = boxRect.right;
			boxDragger.y = boxRect.bottom;
			
			selectionBorder(boxRect);
			
			// find the click location in reference
			// to the origin of the instance clicked
			mouseOffset.x = mouseTarget.x - mouseX;
			mouseOffset.y = mouseTarget.y - mouseY;

		}
		
	}

}