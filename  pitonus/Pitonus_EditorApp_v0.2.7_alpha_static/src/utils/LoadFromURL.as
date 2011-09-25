package utils 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import managers.*;
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.display.*;
	
	
	public class LoadFromURL extends EventDispatcher	{
		
		public static var assetsLoaded:int = 0;
		private var loader:ImageLoader;
		private var _trg:*;
		
		// DEBUG
		private var _debug:Boolean = false;
		public function get debug():Boolean {return _debug;}
		public function set debug(value:Boolean):void { _debug = value; }
		
	
			
			
		
		public function LoadFromURL(trg:DisplayObject, url:String,  w:uint = 130, h:uint = 150, type:String = null) 
		{
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 3)	
				debug = true;
				
			_trg = trg;
		
			/*//create a LoaderMax named "mainQueue" and set up onProgress, onComplete and onError listeners
			var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			 
			//append several loaders
			//queue.append( new XMLLoader("xml/data.xml", {name:"xmlDoc"}) );
			queue.append( new ImageLoader(url, { 
											name:"photo1", 
											estimatedBytes:2400, 
											container:trg, 
											alpha:0, 
											width:130, height:150, 
											scaleMode:"proportionalInside"
											}) );
			//queue.append( new SWFLoader("swf/child.swf", {name:"childClip", estimatedBytes:3000, container:this, x:250, autoPlay:false}) );
			//queue.append( new MP3Loader("mp3/audio.mp3", {name:"audio", repeat:2, autoPlay:true}) );
			 
			//prioritize the loader named "photo1"
			LoaderMax.prioritize("photo1");  //same as LoaderMax.getLoader("photo1").prioritize();
			 
			//start loading
			queue.load();*/
			
			var t:String = (type) ? "stretch" : "proportionalInside";
			
			loader = new ImageLoader(url, { 
				container:trg, 
				scaleMode:t, 
				hAlign:"center", vAlign:"center", 
				onComplete:completeHandler,  
				width:w, height:h});
			loader.load();
			 
			function progressHandler(event:LoaderEvent):void {
				if(debug) trace("progress: " + event.target.progress);
			}
			 
			function completeHandler(event:LoaderEvent):void {
			/*	trace(typeof(loader.rawContent));
				var image:Bitmap = loader.rawContent as ;*/
				//TweenLite.from(image, 0.5, {alpha:0.1});
				assetsLoaded++;
				if (_trg as Sprite) {
					with (_trg.graphics) {
						clear();
					}
				}
				dispatchEvent(new Event( Event.COMPLETE, _trg));
			}
			 
			function errorHandler(event:LoaderEvent):void {
				DataManager.jsBridge.traceToJs("[Error] LoadFromUrl - error occured with " + event.target + ": " + event.text);
				trace("[Error] LoadFromUrl - Error occured with " + event.target + ": " + event.text);
			}
			
		}
		
	}

}



