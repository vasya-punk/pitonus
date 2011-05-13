package  Elements
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import Utils.*;
	import Elements.*;
	import flash.display.*;
	import flash.text.TextField;
	
	// Abstract class, should be EXTENDED, but not INSTANCED
	public class Element extends Sprite implements IElement
	{
		protected var _properties:Object;
		protected var _editableProperties:Object;
		protected var _bounds:Sprite;
		
		protected var _initialized:Boolean = false;
		
		public function Element(obj:Object = null):void {
			if (obj)
				init(obj);
		}
		
		public function init(obj:Object):void {

			this._properties = obj;
			trace(" -------- " + obj['elementType']);
			this.addBounds();
			this.setPosition();
			_initialized = true;
		}
		
		public function update(obj:Object):void {
			for (var item:String in obj)
				this.setProperty(item, obj[item]);
			init( obj );	
		}

		public function cleanUp():void {
			trace("here display children should be removed");
		}
		//  Element properties /////////////////////////////////////////////////////////////////////////////////////////
		
		public function setProperty(prop:String, value:String):Boolean {
			if (this.isProperty(prop)){
				this._properties[prop] = value;
				return true;
			}else {
				return false;	
			}
		}
		
		public function getProperty(prop:String):String {
			if (this.isProperty(prop)){
				return this._properties[prop];
			}else {
				return null;
			}
		}
		
		public function isProperty(prop:String):Boolean {
			var result:Boolean = false;
			try{
				result = (this._properties[prop])? true : false;
			}catch (e:Error) {
				trace("[Error]:Property not found!\n" + e);
			}
			return result
		}
			
		// should be removed or reserved for system use only
		public function getProperties():Array {
			var props:Array = new Array();
			for ( var p:String in this._properties) {
					props.push(p);
			}
			return props;
		}
		
		public function getEditableProperties():Object {
			return _editableProperties;
		}
		
		public function validateProperties(props:Object):Boolean {

				_editableProperties = new Object();
				
				for (var prop:String in props) {

					if (!this.isProperty( prop )) 
						return false;
					else {
						_editableProperties[prop] = props[prop];
					}
				}

				
				return true;
		
		}
		
		public function setPosition():void { 
			
			if(this.isProperty("x") && this.isProperty("y")){
				this.x = int(this.getProperty("x"));
				this.y = int(this.getProperty("y"));
			}
		}
			
		public function addBounds(color:uint = 0xFF0000, alpha:Number = 0.1):void {
			_bounds = new drawSquareBox(  int(this.getProperty('w')), int(this.getProperty('h')) , color, alpha );
			_bounds.mouseEnabled = false;
			addChild(_bounds);

		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}

