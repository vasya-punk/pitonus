package ui.dialogs.selection


{

	import controls.*;
	import data.*;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import ui.dialogs.Dialog;
	import ui.panels.Panel;
	import utils.*;
	import events.*;
	import data.utils.*;
	import flash.events.Event;
	import flash.text.TextField;
	import managers.*;
	import flash.display.Sprite;
	import controls.*;
	import flash.events.MouseEvent;
	import managers.utils.TraceNode;
	import com.adobe.serialization.json.*;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;	

	public class ChooseFromDialog extends Dialog
	{
		
		public function ChooseFromDialog(type:String = "Image") {
			
		}
		override protected function drawPanel():void {
			
			var node:DataNode = getElementsList( DataManager.jsBridge.getMediaList("Image") );
			_control = new ControlWrapper(node, DataManager.getCommands(), this, this);
			_control.addEventListener( ControlEvent.CONTROL_READY, setSize );
			_control.y = 10;
			addChild(_control);
			addChild(dashHorizontal(0,0,350));
			DataManager.jsBridge.traceToJs("CreateImageDialog...");
			//DataManager.jsBridge.traceToJs(node.childNodes.length, node.childNodes[0].properties['src']);
		}
		


		public  function getElementsList(str:*):DataNode { 

			var obj:Object;
			if ( !(str is String) ) { 
				DataManager.jsBridge.traceToJs("[info] Recieved MediaList is Object.");
				obj = str;
			}else{
			//var str:String = e.data;
			
				
				try {				
					obj = JSON.decode( str );
				}catch (e:JSONParseError)  {
					DataManager.jsBridge.traceToJs("Error Decoding JSON. file invalid...\nmessage: " 
								+ e.message + "\nlocation: " + e.location);	
					trace("Error Decoding JSON. file invalid...\nmessage: " 
								+ e.message + "\nlocation: " + e.location);			
					obj = new Object();		
				}
			}
			
			var fo:Object = 
				{
					"name": "ImageList",
					"elementType": "Canvas",
					"layout": "absolute"
				};
				
			fo['pages'] = new Array();
			
			var perPage:uint = 4;
			var curPage:int = -1;
			var numElements:uint = 0;
			var maxElements:uint = objectLength(obj['images']);
			
			var multiPage:Boolean = (maxElements / perPage > 1) ? true : false;
			var reminder:uint = maxElements % perPage ;
			var totalPages:uint = (multiPage && reminder) ?  maxElements / perPage + 1 : int(maxElements/perPage);
			
			
						
			for (var item:String in obj['images']) {
				
				obj['images'][item]['elementType'] = "Image";
				//obj['images'][item]['action'] = "Select";
				
				//trace("[i][d] " + obj['images'][item]['thumb_src'] + " "  + item);
				
										if ( int(numElements / perPage) > curPage) {

											
												
											curPage =  int(numElements / perPage); 	
											
		
											// corrent buttons next/prev
											if (  curPage == 0 ) {
												var btnNext:Object; 
												if (multiPage) {
														btnNext = { 
										
															"btnNext": {
															  "elementType": "TextButton",
															  "label": "NextPage >",
															  "marginY": "5",
															  "w": "125", "h": "30",
															  "action": "NextPage"
															}
														};	
												}else {
													btnNext	= new Object();
												}
												fo['pages'][curPage] = { 
													"elementType": "Canvas",
													"w": "300",
													"layout": "inlineH",
													"marginX": "25",
													"elements": btnNext
												};
												
											}else {
												if( curPage == totalPages - 1){
													fo['pages'][curPage] = { 
														"elementType": "Canvas",
														"w": "350",
														"layout": "inlineH",
														"marginX": "25",
														"elements": { 
										
															"btnPrevious": 
															{
															  "elementType": "TextButton",
															  "label": "< PreviousPage",
															  "w": "125",  "h": "30",
															  "marginY": "5",
															  "action": "PreviousPage"
															}
														}
													};
												}else {
													fo['pages'][curPage] = { 
														"elementType": "Canvas",
														"w": "350",
														"layout": "inlineH",
														"marginX": "25",
														"elements": { 
										
															"0btnPrevious": 
															{
															  "elementType": "TextButton",
															  "label": "< PreviousPage",
															  "w": "125",  "h": "30",
															  "marginY": "5",
															  "action": "PreviousPage"
															},
															"1btnNext": {
															  "elementType": "TextButton",
															  "label": "NextPage >",
															  "w": "125", "h": "30",
															  "marginY": "5",
															  "action": "NextPage"
															}
														}
													};	
												}
											}
											

										}
				

				trace("id: " + item + " | " +  maxElements + " | Page: " + curPage + " | PagePos:" 
					+ numElements % perPage + " total pages: " + objectLength(fo['pages']));	
				
				//obj['images'][item]['thumb_src']
				
				var pic:Object = 
					{
					  "w": "150", "h": "100",
					  "elementType": "Image",
					  "src":obj['images'][item]['thumb_src'],
					  "action" : "Select",
					  "actionParam" : Config.IMAGES_PATH + obj['images'][item]['file_name']
					};
				
				
				fo['pages'][curPage]['elements'][item] = pic;
				
				
				numElements++;
			}
			
				
			
			var node:DataNode = parseTreeRecursive(fo, "CreateImageDialog" , 0);
			
			
			
			return node;
		}
		
		
		override public function select(param:String) : void {
			trace(">>> select:ChooseFrom " + param);
			if(param == CANCEL){
				cleanUp();
			}else {
				dispatchEvent( new UiEvent(UiEvent.SELECTION,
					{  "elementType": "Image",
					  "w": "200",
					  "h": "150",
					  "src": param
					}
				));
				cleanUp();
				dispatchEvent(new ControlEvent(ControlEvent.REMOVE,this));
			}
		}
		
		public function nextPage():void {
			_control.nextPage();
		}
		
		public function previousPage ():void { 
			_control.previousPage();
		}
	
		override public function get w():uint{
			return 350;
		}
		
		override public function get h():uint{
			return 285;
		}
		
		override protected function setSize( e : ControlEvent = null ) : void 	{
			dispatchEvent(new Event(Event.COMPLETE, true));
        }
	}

}
		