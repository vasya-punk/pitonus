package ui.dialogs.modify 


{

	import controls.*;
	import data.*;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import ui.dialogs.Dialog;
	import ui.panels.Panel;
	import ui.panels.QuickToolbarPanel;
	import utils.*;
	import events.*;
	import data.utils.*;
	import flash.events.Event;
	import flash.text.TextField;
	import managers.*;
	import flash.display.Sprite;
	import elements.input.*;
	import controls.*;
	import flash.events.MouseEvent;
	import managers.utils.TraceNode;
	import com.adobe.serialization.json.*;
	import org.as3commons.ui.layout.shortcut.vgroup;
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;	

	public class ElementPropertiesDialog extends Dialog
	{
		private var _toolbar:*;
		private static var CANCEL:String = "Dialog_Cancel";

		
		public function ElementPropertiesDialog ( rec:* = null ) {		
			super(rec);
		}


	
	
		//============================= GETTERS/SETTERS  ===================================

		override protected function drawPanel():void {
		
            var _element:* = DataManager.selectedElement;

            if( _element ){

                var obj : Object =

                {
                    "pages" : {
                        "propertiesPage" : {
                            "elements" : {
                                "0" : {
                                   "text" :  "selected: " + _element.node,
                                    "fontColor" : "0x00974B",
                                    "elementType" : "TextBlock",
                                    "h" : "50",
                                    "w" : "225"
                                }
                            }
                            ,
                            "elementType" : "Canvas",
                            "layout" : "inlineH",
							"defaultPage":"true",
                            "w" : "200","h" : "100","marginX":"25","marginY":"25"
                        }
                    }
                    ,
                    "elementType" : "Canvas",
                    "layout" : "absolute",
                    "w" : "200","h" : "100","marginY":"50"
                }


                var props : Object = _element.getEditableProperties();
                var j : uint = 1;

				for( var item : String in props ){

					obj['pages']['propertiesPage']['elements'][j] =
					{
						"w" : "125", "h" : "20",
						"elementType" : "Input",
						"text" : _element.getProperty( item ),
						"label" : item, // props[item]
						"val" : item
					}
					j ++ ;

				}

				obj['pages']['propertiesPage']['elements'][++j] =  
							{
								"w" : "100",
								"elementType" : "TextButton",
								"h" : "30",
								"action" : "Select",
								"actionParam" : "updateElementProperties",
								"marginY":"5",
								"label" : "Apply"

							}
				
 /*               obj['design'] = {
                    "w" : "400","h" : "400", 
                    "elementType" : "Canvas",
					"layout":"absolute",
                    "elements" : {
						"0": {
							"elementType": "IconsBar",
							"w": "350",
							"items": [
							  "i10","i11"
							],
							"h": "40"
						  }
                    }
                };*/
				
				var separator:Sprite = dashHorizontal(0, 0, 250);
				addChild(separator);
				
                _control = new ControlWrapper( parseTreeRecursive( obj ), DataManager.getCommands(), this );
				_control.addEventListener( ControlEvent.CONTROL_READY, setSize );
				_control.addEventListener( ControlEvent.PAGE_CHANGED, update );
                addChild( _control );
          
			}


        }
		

		private  function update( e : ControlEvent = null ) : void 	{
            tabLayout.layout( this );
        	trace("Dialog.update() " + tabLayout.visibleRect.width + " x " + tabLayout.visibleRect.height);
        }		
		
		override public function get w():uint{
			return 250;
		}
		
		override public function get h():uint{
			return this.height + 50;
		}
		

		override public function select( param : String ) : void {
				 
				 var _element:* = DataManager.selectedElement;
				 var el : Array = _control.canvas.elements;

				 trace( "[a][d] ElementPropertiesDialog - " + param  + " param: "+ _element + " - updatingElementProps");
				 
				 for ( var i : int = 0; i < el.length; i ++ ) {
					 if( el[i] is Input ){
						 if ( ( el[i] as Input ).val ) {
							//trace( ">>> >>> " + ( el[i] as Input ).val + " : " + el[i].text  );
							_element.setProperty( ( el[i] as Input ).val,  el[i].inputText );
							// _element[ ( el[i] as Input ).val] = el[i].text ;
							//trace( "--- " + _element[ ( el[i] as Input ).val] + " : " + ( el[i] as Input ).val );
						 }
					 }
				 }

			dispatchEvent( new ControlEvent( ControlEvent.ELEMENT_UPDATE, _element ) )	;
		}
		
	}

}

