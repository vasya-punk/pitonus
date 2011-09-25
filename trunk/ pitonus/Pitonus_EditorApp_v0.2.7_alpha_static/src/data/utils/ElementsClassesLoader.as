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
	
	public class ElementsClassesLoader extends EventDispatcher {

		private var queue:LoaderMax ;
		private var aviableClassesNames:Object
		private var _rec:*;
		
		public function ElementsClassesLoader( rec:* ) 
		{
			_rec = rec;
			
			// [TODO] -- Simulate Class loading
			_rec.elementClassesLoaded();
			
		/*	//create a LoaderMax named "mainQueue" and set up onProgress, onComplete and onError listeners
			queue = new LoaderMax({name:"ElementsClasses", auditSize:false, onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			
			
			// ALL ELEMENTS CLASSES AVIABLE FOR APPLICATION
			var aviableClassesNames:Object = new Object();
			
			aviableClassesNames['fileNames'] = new Array();
			aviableClassesNames['names'] = new Array();
			aviableClassesNames['qualifiedNames'] = new Array();
			aviableClassesNames['runtimeClassRefs'] = new Array();
			

			aviableClassesNames['fileNames'][0] = Config.ELEMENTS_CLASSES_PATH + "ActiveImage.swf"		
			aviableClassesNames['names'][0] = 	"ActiveImage";
			aviableClassesNames['qualifiedNames'][0] = 	"elements.activeimage::ActiveImage";
			



			for ( var i:uint = 0;  i < aviableClassesNames['names'].length ; i++ ) {
				//trace(".. aviableClassesNames['names'] " + aviableClassesNames['names'][i] + " " +i);
				//trace(".. aviableClassesNames['fileNames'] " + aviableClassesNames['fileNames'][i] + " " +i);
				//trace(".. aviableClassesNames['qualifiedNames'] " + aviableClassesNames['qualifiedNames'][i] + " " +i);
				if (i != -1) {
					queue.append( new SWFLoader( aviableClassesNames['fileNames'][i], { name:aviableClassesNames['names'][i] } ) );
				}
			}
			
			//start loading
			queue.load();
			 
			function progressHandler(event:LoaderEvent):void {
				//if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
				trace("Elements classes progress: " + event.target.progress);
			}
			 
			function completeHandler(event:LoaderEvent):void {
				
				//if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
				
				//trace(event.target + " - loaded!");

				var runtimeClassRef:Class ;
				var classInstance:*;

				var loaders:Array = queue.getChildren();
				
				for (var i:uint = 0; i < loaders.length ; i++  ) {

					runtimeClassRef = queue.getLoader(aviableClassesNames['names'][i]).getClass(aviableClassesNames['qualifiedNames'][i]);
					aviableClassesNames['runtimeClassRefs'][i] = runtimeClassRef;
	
					// Classes should be instanced to make them aviable in main app
					classInstance = new runtimeClassRef();
					trace("... classInstance " + classInstance);
				}
				
				//aviableClassesNames['runtimeClassRefs'][3] = getClass(new Image());
				
				trace(event.target + " - loaded! " + aviableClassesNames['runtimeClassRefs'][0] );
			
				_rec.elementClassesLoaded( aviableClassesNames['runtimeClassRefs'][0] );
				//dispatchEvent(new Event( Event.COMPLETE, aviableClassesNames ));					
			}
			 
			function errorHandler(event:LoaderEvent):void {
				trace("error occured with " + event.target + ": " + event.text);
			}
			*/
		}

	}
	
}