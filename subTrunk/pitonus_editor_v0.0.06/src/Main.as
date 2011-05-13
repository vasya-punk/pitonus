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
			

			

			// ****** Should be removed from here ******************************************
			

			var s:String = '{"name":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","x":"5","y":"5","w":"650","h":"300","name":"Homepage","elementType":"Canvas","name":"homepage","elements":[{"name":"ElementProperties","elements":[{"elementType":"ActiveImage","caption":"InsideCanvas1","src":"stamPic.jpg","name":"ActiveImage Name","action":"DefaultCommand","actionParam":"Hi","w":"50","h":"150"},{"elementType":"ActiveImage","caption":"InsideCanvas2","src":"stamPic1.jpg","name":"ActiveImage Name","action":"DefaultCommand","actionParam":"Hi","w":"150","h":"75"}],"elementType":"Canvas","w":"250","h":"200","x":"250","y":"220"},{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","name":"ActiveImage Name","action":"DefaultCommand","actionParam":"Hi","w":"100","h":"150"},{"elementType":"ActiveImage","caption":"not First 2 day","src":"stamPic1.jpg","action":"DefaultCommand","actionParam":"Hi","w":"150","h":"150"},{"elementType":"ActiveImage","caption":"Another day","src":"stamPic2.jpg","action":"DefaultCommand","actionParam":"gl hf","w":"50","h":"200"}]}]}';
			
			//	var s:String = '{"siteName":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","pageType":"HomePage","pageName":"homepage","elements":[{"elementType":"Button","caption":"pageButton : Read more >>","x":"200","y":"350","action":"NextPage"},{"elementType":"StaticText","id":"1","x":"200","y":"100","w":"500","h":"150","briefText":"HEADER Lorem Ipsum is simply dummy text of the printing and typesetting industry.","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."},{"elementType":"StaticText","id":"2","x":"200","y":"220","w":"500","h":"100","briefText":"Second Header","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.."},{"elementType":"Image","src":"pageBg.png","x":"150","y":"50","w":"583","h":"372"}]},{"pageId":"1","pageType":"TextPage","pageName":"About us","elements":[{"elementType":"ActiveImage","caption":"Another day2","src":"stamPic2.jpg","x":"50","y":"300","action":"PreviousPage"},{"elementType":"StaticText","id":"2","x":"50","y":"50","w":"500","h":"100","briefText":"Header on second page","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.. By the way. it could be a htmlText, so it is possible to include images and hyperlinks within in.. "},{"elementType":"Button","id":"5","caption":"Prev Page","x":"200","y":"350","action":"PreviousPage"},{"elementType":"Image","src":"pageBg2.png","x":"150","y":"50","w":"583","h":"372"}]},{"pageId":"2","pageType":"TextPage","pageName":"Stam","elements":[{"elementType":"ActiveImage","caption":"Another day 3","src":"stamPic.jpg","x":"0","y":"200","action":"GotoToPageId","actionParam":"0"},{"elementType":"StaticText","id":"2","x":"50","y":"50","w":"500","h":"100","briefText":"Header on third page","fullText":"By the way. it could be a htmlText, so it is possible to include images and hyperlinks within in.. ","src":"stamPic.jpg"}]},{"pageId":"3","pageType":"TextPage","pageName":"Stam","elements":[{"elementType":"StaticText","id":"2","x":"50","y":"200","w":"500","h":"100","briefText":"Header on third page","fullText":"By the way. it could be a htmlText, so it is possible to include images and hyperlinks within i htmlText, so it is possible to include images and hyperlinks within in.. "}]},{"pageType":"editor","elements":[{"elementType":"NavigationToolbar"},{"elementType":"PropertiesToolbar"}]},{"pageType":"template","templateName":"Simple template","elements":[{"elementType":"Button","caption":"Homepage","action":"GotoToPageId","x":"50","y":"400","actionParam":"0"},{"elementType":"Button","caption":"Page 1","action":"GotoToPageId","x":"150","y":"400","actionParam":"1"},{"elementType":"Button","caption":"page 2","action":"GotoToPageId","x":"300","y":"400","actionParam":"2"},{"elementType":"Button","caption":"page 2","action":"GotoToPageId","x":"450","y":"400","actionParam":"3"},{"elementType":"Image","src":"siteBg.jpg","x":"0","y":"15","w":"800","h":"485"},{"elementType":"Image","src":"logo.png","x":"25","y":"30","w":"120","h":"60"}]}]}';
			
			dataBridge.pitLoad(s);

				
		}
		private function  buildApplicationUI( appStructure:Object ):void {
			

			var editor:Editor = new Editor();
			
			var defaultPageObject:Object = Manager.getDefaultPageData(Config.DEFAULT_PAGE_ID);
			if (defaultPageObject){
				editor.canvas = defaultPageObject;
				editor.drawUi();
				appWorkAreaSprite.addChild(editor);
			}else {
				trace("[Error] Manager.getDefaultPageData() returned empty Object");	
			}
			
/*			var c:Canvas = createCanvas({"name":"Element Properties","elements":[{"elementType":"InputProperty","label":"First","value":"Default1","w":"150","h":"25"},{"elementType":"InputProperty","label":"Second","value":"Default2","w":"150","h":"25"}],"canvasType":"ElementProperties","x":"200","y":"250"});
			addChild(c);*/
			
/*			 var aviableElements : Object = Manager.getSiteElementClasses();
			// check if element exist is aviable elements array
			var elementTypeNum : int =  aviableElements['names'].indexOf( 'InputProperty' );
			if ( elementTypeNum != - 1 ) {
				// if()
				var element : * = createElement( aviableElements['runtimeClassRefs'][elementTypeNum], 
				{"elementType":"InputProperty","label":"First day","value":"stamPic.jpg","x":"200","y":"50"}
				);

				addChild( element );

			}*/

		}
		
		// UI LAYOUT  ////////////////////////////////////////////////////////////////////////
		private function buildToolbars():void { 
			
			
			//addEventListener(MouseEvent.CLICK, clickHandler);	
		}
		


		// INTERACTION ////////////////////////////////////////////////////////////////////////
		private function clickHandler(event : MouseEvent) : void {
			/*var clickTarget : Sprite = event.target as Sprite;
			var GroupIcons:ArrayList = mainToolbar.getList();
			var index:int = GroupIcons.firstIndexOf(clickTarget);
			trace(clickTarget + "  " + index);
			//trace( layoutHGroupIconsArrayList.itemAt(index)  , layoutHGroupIconsArrayList.itemAt(index).name  );*/
		}
		
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

