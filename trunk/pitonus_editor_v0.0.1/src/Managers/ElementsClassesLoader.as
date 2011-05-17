package Managers
{
	
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	
	import Elements.*;

	import flash.events.EventDispatcher;

	import Utils.*;
	
	public class ElementsClassesLoader extends EventDispatcher {

		private var queue:LoaderMax ;
		private var aviableClassesNames:Object
		
		public function ElementsClassesLoader( elementTypes:Array ) 
		{
			// CLASSES REQUESTED BY JSON

			if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
				trace("Number of recived in JSON elementTypes : " + elementTypes.length);
			
			//create a LoaderMax named "mainQueue" and set up onProgress, onComplete and onError listeners
			queue = new LoaderMax({name:"ElementsClasses", auditSize:false, onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			
			
			// ALL ELEMENTS CLASSES AVIABLE FOR APPLICATION
			aviableClassesNames = new Object();
			
			aviableClassesNames['fileNames'] = new Array();
			aviableClassesNames['names'] = new Array();
			aviableClassesNames['qualifiedNames'] = new Array();
			aviableClassesNames['runtimeClassRefs'] = new Array();
			
			
			aviableClassesNames['fileNames'][0] = Config.ELEMENTS_CLASSES_PATH + "Button.swf"		
			aviableClassesNames['names'][0] = "Button";
			aviableClassesNames['qualifiedNames'][0] = "Elements::Button"
			
/*			aviableClassesNames['fileNames'][0] = Config.ELEMENTS_CLASSES_PATH + "StaticText.swf"		
			aviableClassesNames['names'][0] = "StaticText";
			aviableClassesNames['qualifiedNames'][0] = "Elements::StaticText"
			*/
			
			
			aviableClassesNames['fileNames'][3] = Config.ELEMENTS_CLASSES_PATH + "ActiveImage.swf"		
			aviableClassesNames['names'][3] = "ActiveImage";
			aviableClassesNames['qualifiedNames'][3] = "Elements::ActiveImage"

			aviableClassesNames['fileNames'][4] = Config.ELEMENTS_CLASSES_PATH + "InputProperty.swf"		
			aviableClassesNames['names'][4] = "InputProperty";
			aviableClassesNames['qualifiedNames'][4] = "Elements::InputProperty"
			
			aviableClassesNames['fileNames'][1] = Config.ELEMENTS_CLASSES_PATH + "Canvas.swf"		
			aviableClassesNames['names'][1] = "Canvas";
			aviableClassesNames['qualifiedNames'][1] = "Elements::Canvas"
			
			aviableClassesNames['fileNames'][2] = Config.ELEMENTS_CLASSES_PATH + "Tree.swf"		
			aviableClassesNames['names'][2] = "Tree";
			aviableClassesNames['qualifiedNames'][2] = "Elements::Tree"
/*						
			aviableClassesNames['fileNames'][3] = Config.ELEMENTS_CLASSES_PATH + "Image.swf"		
			aviableClassesNames['names'][3] = "Image";
			aviableClassesNames['qualifiedNames'][3] = "Elements::Image"

*/
			
			// DISABLE RUNTIME CLASS LOADING FOR DEBUG PERPOSES
			// use Static reference
			//aviableClassesNames['runtimeClassRefs'][0] = getClass(StaticText);
			//aviableClassesNames['runtimeClassRefs'][1] = getClass(Button);
			aviableClassesNames['runtimeClassRefs'][3] = getClass(ActiveImage);
			aviableClassesNames['runtimeClassRefs'][4] = getClass(InputProperty);
			aviableClassesNames['runtimeClassRefs'][0] = getClass(Button);
			aviableClassesNames['runtimeClassRefs'][1] = getClass(Canvas);
			aviableClassesNames['runtimeClassRefs'][2] = getClass(Tree);
			
			//aviableClassesNames['names'][4] = "Canvas";
			
			//aviableClassesNames['runtimeClassRefs'][3] = getClass(Image);
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
				trace("Number of total elementTypes : " + aviableClassesNames['names'].length);
			

			TweenLite.delayedCall(0.1, classesReady);
				
			/*
			 * for ( var i:uint = 0;  i < elementTypes.length ; i++ ) {
				var position:int = aviableClassesNames['names'].indexOf(elementTypes[i]);
				if (position != -1) {
					queue.append( new SWFLoader( aviableClassesNames['fileNames'][position], { name:aviableClassesNames['names'][position] } ) );
				}
			}
			
			//start loading
			queue.load();
			*/
			function progressHandler(event:LoaderEvent):void {
				if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
					trace("Elements classes progress: " + event.target.progress);
			}
			 
			function completeHandler(event:LoaderEvent):void {
				
				if (Config.DEBUG && Config.DEBUG_LEVEL > 2) 
					trace(event.target + " - loaded!");

				var runtimeClassRef:Class ;
				var classInstance:*;

				var loaders:Array = queue.getChildren();
				
				for (var i:uint = 0; i < loaders.length ; i++  ) {

					runtimeClassRef = queue.getLoader(aviableClassesNames['names'][i]).getClass(aviableClassesNames['qualifiedNames'][i]);
					aviableClassesNames['runtimeClassRefs'][i] = runtimeClassRef;
	
					// Classes should be instanced to make them aviable in main app
					classInstance = new runtimeClassRef();
				}
				
			
				classesReady();				
			}
			 
			function classesReady():void { 
				
				dispatchEvent(new EventReady(EventReady.READY, aviableClassesNames ));		
		
			}
			
			function errorHandler(event:LoaderEvent):void {
				trace("error occured with " + event.target + ": " + event.text);
			}
		}

	}
	
}