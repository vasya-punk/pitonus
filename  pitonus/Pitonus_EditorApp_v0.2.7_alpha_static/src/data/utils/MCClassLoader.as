package data.utils 
{
	
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	import elements.*;
	import events.SimpleEvent;
	import flash.events.Event;

	import flash.events.EventDispatcher;

	import managers.*;
	
	public class MCClassLoader extends EventDispatcher {

		private var queue:LoaderMax ;
		private var aviableClassesNames:Object
		private var _rec:*;
		
		// DEBUG
		private var _debug:Boolean = false;
		public function get debug():Boolean {return _debug;}
		public function set debug(value:Boolean):void { _debug = value; }
	
		public function MCClassLoader( rec:* ) 
		{
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 3)	
				debug = true;
			
			_rec = rec;
			


			//create a LoaderMax named "mainQueue" and set up onProgress, onComplete and onError listeners
			queue = new LoaderMax({name:"ElementsClasses", auditSize:false, onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			
			
			// ALL ELEMENTS CLASSES AVIABLE FOR APPLICATION
			var aviableClassesNames:Object = new Object();
			
			aviableClassesNames['fileNames'] = new Array();
			aviableClassesNames['names'] = new Array();
			aviableClassesNames['qualifiedNames'] = new Array();
			aviableClassesNames['runtimeClassRefs'] = new Array();
			

			aviableClassesNames['fileNames'][0] = Config.MC_PATH + "mc_siteMenu.swf"		
			aviableClassesNames['names'][0] = 	"siteMenu";
			aviableClassesNames['qualifiedNames'][0] = 	"mc_siteMenu";
			
			aviableClassesNames['fileNames'][1] = Config.ASSETS_EDITOR + "addElement_Panel.swf"		
			aviableClassesNames['names'][1] = 	"addElement_Panel";
			aviableClassesNames['qualifiedNames'][1] = 	"addElement_Panel";
			
			aviableClassesNames['fileNames'][2] = Config.ASSETS_EDITOR + "quickSelect_Panel.swf"		
			aviableClassesNames['names'][2] = 	"quickSelect_Panel";
			aviableClassesNames['qualifiedNames'][2] = 	"quickSelect_Panel";
			
			aviableClassesNames['fileNames'][3] = Config.ASSETS_EDITOR + "siteProperties_Panel.swf"		
			aviableClassesNames['names'][3] = 	"siteProperties_Panel";
			aviableClassesNames['qualifiedNames'][3] = 	"siteProperties_Panel";
			
			aviableClassesNames['fileNames'][4] = Config.ASSETS_EDITOR + "project_Panel.swf"		
			aviableClassesNames['names'][4] = 	"project_Panel";
			aviableClassesNames['qualifiedNames'][4] = 	"project_Panel";



			for ( var i:uint = 0;  i < aviableClassesNames['names'].length ; i++ ) {
				//trace(".. aviableClassesNames['names'] " + aviableClassesNames['names'][i] + " " +i);
				//trace(".. aviableClassesNames['fileNames'] " + aviableClassesNames['fileNames'][i] + " " +i);
				//trace(".. aviableClassesNames['qualifiedNames'] " + aviableClassesNames['qualifiedNames'][i] + " " +i);
				if (i != -1) {
					queue.append( new SWFLoader( aviableClassesNames['fileNames'][i], { name:aviableClassesNames['names'][i] } ) );
				}
			}
			
			DataManager.jsBridge.traceToJs("MCClassLoader constructor" );
				
			
			//start loading
			queue.load();
			 
			function progressHandler(event:LoaderEvent):void {
				//if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
				//trace("MCClassLoader classes progress: " + event.target.progress);
				DataManager.jsBridge.traceToJs("SWF progressHandler()" + event.target.progress );
			}
			 
			function completeHandler(event:LoaderEvent):void {
				
				//if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
				
				//trace(event.target + " - loaded!");

				var runtimeClassRef:Class ;
				var classInstance:*;

				var loaders:Array = queue.getChildren();
				
				for (var i:uint = 0; i < loaders.length ; i++  ) {

					runtimeClassRef = queue.getLoader(aviableClassesNames['names'][i]).getClass(aviableClassesNames['qualifiedNames'][i]);
					
					if (!runtimeClassRef ) { 
						trace("[Error] MCClassLoader.completeHandler() - runtimeClassRef is null...");
					}else{
						aviableClassesNames['runtimeClassRefs'][i] = runtimeClassRef;
						
						/*trace(".... aviableClassesNames['names'][i]  " 
								+ aviableClassesNames['names'][i] 
								+ " " + aviableClassesNames['qualifiedNames'][i]
								+ " " + runtimeClassRef);
						*/
						// Classes should be instanced to make them aviable in main app
						classInstance = new runtimeClassRef();
						//trace("... classInstance " + classInstance);
					}
				}
				
				//aviableClassesNames['runtimeClassRefs'][3] = getClass(new Image());
				
				if(debug) 	trace("[i] MCClassLoader - loaded! " + aviableClassesNames['runtimeClassRefs'][0] );
				DataManager.jsBridge.traceToJs(event.target + "MCClassLoader - loaded! " + aviableClassesNames['runtimeClassRefs'][0] );
				_rec.elementClassesLoaded( aviableClassesNames );
				//dispatchEvent(new Event( Event.COMPLETE, aviableClassesNames ));					
			}
			 
			function errorHandler(event:LoaderEvent):void {
				DataManager.jsBridge.traceToJs("SWF errorHandler()" + event.target + ": " + event.text );
				trace("[Error] MCClassLoader - occured with " + event.target + ": " + event.text);
			}
			
		}

	}
	
}