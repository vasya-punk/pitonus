package 
{


	
	
	
	
	
/*	
	TODO 
	background - Element: InputProperty
	
	
	*/
	
	import com.adobe.protocols.dict.events.NoMatchEvent;
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IListIterator;
	import org.as3commons.ui.layout.HGroup;
	import org.as3commons.ui.layout.constants.Align;
	
	import com.adobe.serialization.json.*;	
	
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    
	import Elements.*;
	import Controls.*
	import Utils.*
	import Utils.Communication.*;
	import Utils.Console.*
	import Managers.*;
	
	import Editor.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

// TODU mousechildren = false > elements
	public class Main extends Sprite 
	{
		// global vars
		private var structureLoaded:			Boolean = false;
		
		// functianal classes
		private var dataBridge:					JSBridge;
		
		// application view presentation 
		private var appWorkAreaSprite:			Sprite;
		private var appOverlayAreaSprite:		Sprite;
			
			
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			// init essentials, like TweenLite plugins, etc
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			Manager.init();
			Alert.init(this);
			
			//SWFProfiler.init(stage, this);
			dataBridge = new JSBridge();
			dataBridge.addEventListener( JSBridgeEvent.STRUCTURE_RECIEVED, processData);
			
			// Application layout sprites
			appWorkAreaSprite = new Sprite();
			appOverlayAreaSprite = new Sprite();
			this.addChild(appWorkAreaSprite);
			this.addChild(appOverlayAreaSprite);
			

			dataBridge.pitLoad(Config.TEST_CONTENT_DATA_STRING);

				
		}
		private function  buildApplicationUI( appStructure:Object ):void {
			

			
			
			var defaultPageNode:Node = Manager.getDefaultPageData(Config.DEFAULT_PAGE_ID);
			if (defaultPageNode) {
				
				var editor:Editor = new Editor( defaultPageNode );
				editor.commands = Manager.getCommands();
				editor.drawUi();
				
				appWorkAreaSprite.addChild(editor);
				
			}else {
				trace("[Error] Manager.getDefaultPageData() returned empty Node");	
			}
		
		}
	
		// INTERACTION ////////////////////////////////////////////////////////////////////////
		//private function clickHandler(event : MouseEvent) : void {}
		
		// DATA MANAGMENT ////////////////////////////////////////////////////////////////////////
		private function processData(e:JSBridgeEvent):void {

			trace("\nData processed: OK\n");
			
			var str:String = e.data;
			
			if ( !structureLoaded ){
				var obj:Object;
				try {
					
					obj = JSON.decode( str );
					obj['valid'] = true;
					structureLoaded = true;
					dataBridge.callJs("console.log", "Flash > Structure is valid");
					
				}catch (e:JSONParseError)  {
					
					trace("Error Decoding JSON. file invalid...\nmessage: " + e.message + "\nlocation: " + e.location);
					obj = new Object();
					obj['valid'] = false;						
				}
			}else {
					trace("Site structure and external classes are already loaded","Reload page instead");
			}
			
			if ( Manager.setStructure(obj) ) {	
				Manager.registerCommands();
				var elementsClassesLoader:ElementsClassesLoader = new ElementsClassesLoader( Manager.getElementsTypes() );
				elementsClassesLoader.addEventListener(EventReady.READY, elementClassesLoaded);
				
				function elementClassesLoaded(e:EventReady):void {
					Manager.setAviableClasses(e.obj);	
					structureLoaded = true;
					buildApplicationUI( obj );	
				}
				
			}else {
				trace("Something goes wrong... JSON structure could not be parsed right ");
			}
		}
		
		public function save():void { 
			/*var variables:String =  JSON.encode( _structure );
			dataBridge.callJs("JsPitSave", variables);*/
		}
	}
	
}

