package elements
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.display.*;
	import flash.text.TextField;
	
	import managers.*;
	import utils.*;
	import data.*;
	import data.utils.*;
	import configuration.*;
	import elements.*;
	
	

	/**
	* Abstract class, should be EXTENDED, but not INSTANCED
	*
	* @param param1 Describe param1 here.
	* @param param2 Describe param2 here.
	*
	* @return Describe return value here.
	*
	* @see someOtherMethod
	*/
	
	public class Element extends LifeCycleable implements IElement
	{
		
		protected 	var _node					: DataNode;
		protected 	var _editableProperties		: Object;
	
		public function Element( node:DataNode ):void {
			if ( node ) {
				_node = node;
				
			}else {
				throw new Error("[Error] Init Element failed");
			}
		}
		
		//============================= Abstract functions  ===================================
		
		// initial preparations, called by LifeCycle before Element was added to display list
		override public function init():void {
			validateNow();
		}

		// called by LifeCycle after Element propety was changed by _lcAdapter.invalidate(); called
		override public function update() : void {
			trace ( "Element.update()");
		}
		
		// called by LifeCycle after init() by _lcAdapter.validateNow(); called
		override public function draw() : void {
			trace ( "Element.draw()");
		}

		//============================= Element GETTERS  ===================================

		protected function cleanUp():void{
			for (var i:uint = 0; i < this.numChildren; i++ ) {
				this.removeChildAt(i);
			}
		}
		
		public function get node():DataNode{
			return _node;
		}
		
		public function getProperty(prop:String):String {
			if (this.isProperty(prop)){
				return _node.properties[prop];
			}else {
				return null;
			}
		}
		
		public function getEditableProperties():Object {
			return _editableProperties;
		}
			
		// should be removed or reserved for system use only
		public function getProperties():Array {
			var props:Array = new Array();
			for ( var p:String in _node.properties) {
					props.push(p);
			}
			return /*_node.properties*/ props;
		}
		
		public function get elementType( ):String {
			return String(this.getProperty('elementType'));
		}
		
		public function get w():uint {
			return uint( this.getProperty('w') );
		}
		
		public function get h():uint {
			return uint( this.getProperty('h') );
		}
		
		public function get marginX():uint {
			return uint( this.getProperty('marginX') );
		}
		
		public function get marginY():uint {
			return uint( this.getProperty('marginY') );
		}
		
		public function get identifier():String {
			return String( this.getProperty('identifier') );
		}
		
		public function get id():String {
			return String( _node.id );
		}
		
		override public function get name():String {
			return _node.name;
		}
		
		public function get action():String {
			return String( this.getProperty('action') );
		}
		
		public function get actionParam():String {
			return String( this.getProperty('actionParam') );
		}
		
		public function get inline():Boolean {
			// TODO inline or absolute default?
			return 	toBoolean(this.getProperty('inline'));
		}
		
		//============================= Element SETTERS  ===================================
		
		
		public function set elementType(val:* ):void {
			trace("Currently unsupported");
			//setProperty( "elementType", String(val) );
		}
		
		public function set w( val:* ):void {
			setProperty( "w", String(val) );
		}
		
		public function set h( val:* ):void {
			setProperty( "h", String(val) );
		}
		
		override public function set width(newValue:Number):void {
			setProperty( "w", String(newValue) );
		}
		
		override public function set height( newValue:Number ):void {
			setProperty( "h", String(newValue) );
		}
		
		public function set marginX( val:* ):void {
			setProperty( "marginX", String(val) );
		}
		
		public function set marginY( val:* ):void {
			setProperty( "marginY", String(val) );
		}
		
		public function set identifier( val:* ):void {
			setProperty( "identifier", String(val) );
		}
		
		override public function set name(str:String):void {
			_node.name = str;
		}
		
		public function set action( val:* ):void {
			setProperty( "action", String(val) );
		}
		
		public function set actionParam(  val:* ):void {
			setProperty( "actionParam", String(val) );
		}
		
		public function set inline( val:Boolean ):void {
			setProperty( "inline", String(val) );
		}
		

		protected function setEditableProperties( props:Object ):void {
			
				_editableProperties = new Object();	
				var prop:String;
				
				/* initialize with default editable properties for all Elements
				"elementType" 	: Attributes.LIST,
				"name"			: Attributes.INPUT,
				"w"				: Attributes.NUMBER,
				"h"				: Attributes.NUMBER,
				"action"		: Attributes.LIST,
				"actionParam"	: Attributes.LIST,
				"marginX"		: Attributes.NUMBER,
				"marginY"		: Attributes.NUMBER,
				"inline"		: Attributes.BOOLEAN */
	
				for ( prop in Attributes.DEFAULT_EDITABLE_PROPERTIES) {
					_editableProperties[prop] = Attributes.DEFAULT_EDITABLE_PROPERTIES[prop];
				}
				
				// append additional properties from Object passed by extended Element class
				for (prop in props) {
					_editableProperties[prop] = prop;
				}
				
		}
		
		public function setProperty(prop:String, value:String, inVal:Boolean = true):void {
			
			_node.properties[prop] = value;		
			
			if(inVal)
				invalidate();
	
		}
		
		//============================= Misc/Util Methods ===================================
		
		public function isProperty(prop:String):Boolean {
			var result:Boolean = false;
			try{
				result = ( _node.properties[prop] )? true : false;
			}catch (e:Error) {
				trace("[Error]:Property not found!\n" + e);
				return false;
			}
			return result
		}
		
		public function getMinimalProperties():Object {
			var minimalProperties:Object =  new Object();
			minimalProperties["w"] = Attributes.NUMBER;
			minimalProperties["h"]= Attributes.NUMBER;
			return minimalProperties;
		}
	}

}

