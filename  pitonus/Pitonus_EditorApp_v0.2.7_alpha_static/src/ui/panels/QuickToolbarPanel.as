package ui.panels
{
    import com.adobe.air.crypto.EncryptionKeyGenerator;
    import controls. * ;
    import data. * ;
    import elements. * ;
    import elements.canvas.Canvas;
	import elements.image.Image;
    import events.ControlEvent;
	import events.EditorEvent;
    import events.UiEvent;
	import flash.events.MouseEvent;
    import flash.geom.Rectangle;
	import ui.dialogs.selection.*;
	import ui.dialogs.create.CreateImageDialog;
	import ui.dialogs.modify.ElementPropertiesDialog;
    import utils. * ;
    import data.utils. * ;
    import flash.events.Event;
    import flash.text.TextField;
    import managers. * ;
    import configuration. * ;
    import flash.display.Sprite;
    import elements.input. * ;
    import controls. * ;
    import managers.utils.TraceNode;
    import flash.events.Event;

    public class QuickToolbarPanel extends Sprite
    {
        private var _receiver : * ;
        private var _ready : Boolean = false;
        private var _element : Element
        private var _w : uint = 100;
        private var _h : uint = 100;
        private var _control : ControlWrapper;
		private var panelHeight: uint = 170;

        public function QuickToolbarPanel (  rec : * = null ) {

            _receiver = rec;

            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
			buildPanel();
		}
		
		private function buildPanel( ) : void 	{
			 
            _element = DataManager.selectedElement;

            if( _element ){

				var _aviableElements:Object =	DataManager.mcClasses;
				var elementTypeNum : int =  _aviableElements['names'].indexOf( "quickSelect_Panel" );
				var elementClass : * = null;
				var menuElements:Array = new Array();
				
				if ( elementTypeNum != - 1 ) {
					elementClass = _aviableElements['runtimeClassRefs'][elementTypeNum];
				}
				
				if (elementClass) {
					var element:* = null;
					element = new elementClass;

					element.btn1.addEventListener(MouseEvent.CLICK, onMenuClick);
					switch (_element.elementType) 
					{
						case "TextBlock" :
							element.btn2.visible = false;
							element.btn3.visible = false;
							tint(element.item2, true);
							tint(element.item3, true);
							element.btn4.addEventListener(MouseEvent.CLICK, onMenuClick);
							break;
						default:	
						case "Image" :
							element.btn2.addEventListener(MouseEvent.CLICK, onMenuClick);
							element.btn3.addEventListener(MouseEvent.CLICK, onMenuClick);
							element.btn4.addEventListener(MouseEvent.CLICK, onMenuClick);
						/*	tint(element.item3, true);
							element.btn3.visible = false;*/
							break;
					}
				
					
					menuElements.push(element);
					
					
				
				
				
				
					var obj : Object =

					{
						"pages" : {
							"propertiesPage" : {
								"elements" : {
									"0" : {
									   "text" :  "Element selected: " + _element.node,
										"fontColor" : "0x000000",
										"elementType" : "TextBlock",
										"h" : "80",
										"w" : "175",
										"header":"Quick Properties","marginY" : "5"
									}
								}
								,
								"elementType" : "Canvas",
								"layout" : "inlineH",
								"w" : "175","h" : "100", "marginY" : panelHeight, "marginX" : "25"
							}
						}
						,
						"elementType" : "Canvas"
						
					}

					var props : Object = _element.getMinimalProperties();
		
					var j : uint = 2;
					var marginFirst:uint = 15;
					for ( var i : String in obj['pages' ] ) {

						for( var item : String in props ){
							
							obj['pages'][i]['elements'][j] =
							{
								"w" : "125", "h" : "20",
								"elementType" : "Input",
								"marginY": marginFirst,
								"text" : _element.getProperty( item ),
								"label" : item, // props[item]
								"val" : item
							}
							marginFirst = 0;
							j++ ;
							
							// }
						}
						obj['pages'][i]['elements'][++j] =
							{
								"w" : "100",
								"elementType" : "TextButton",
								"h" : "30",
								"action" : "Select",
								"actionParam" : "updateElementProperties",
								"label" : "Apply"

							}
					}

					obj['design'] = {
						"elementType" : "Canvas",
						"layout" : "inlineH",
						"elements" : {

							"1" : {
							   "src":Config.ASSETS_EDITOR + "bg03.png",
							   "elementType":"Image",
							   "h":"320","w":"200"

							}
						}
					};

					_control = new ControlWrapper( parseTreeRecursive( obj ), DataManager.getCommands(), this );
					_control.addEventListener( ControlEvent.CONTROL_READY, onControlReady );
					
					addChild( _control );
					element.y += 5;
					addChild(element);
					addChild(dashHorizontal(5,panelHeight,190));
					
				}
            }
			
			
			function onMenuClick(e:MouseEvent):void {
					
					//dispatchEvent(new ControlEvent(ControlEvent.MENU_CLICK, uint(e.currentTarget.name)));
					
					var dialog:*;
					switch (e.currentTarget.name) 
					{
						default:
						case "btn1":
							dialog = new ElementPropertiesDialog();
							dialog.addEventListener(ControlEvent.ELEMENT_UPDATE, updateHandler);	
							trace("[a][p] QuickToolbarPanel - onMenuClick() - EditElementProperties: " +  _element );
							break;
						case "btn2":
							dialog = new ChooseFromDialog("Image");
							dialog.addEventListener(UiEvent.SELECTION, selectionHandler);
							trace("[a][p] QuickToolbarPanel - onMenuClick() - SelectImage: " +  _element );
							break;
						
						case "btn3":
							//_rec.addElement("ActiveImage");
						break;
					case "btn4":
							trace("[a][p] QuickToolbarPanel - onMenuClick() REMOVE_ELEMENT: " +  _element );
							dispatchEvent( new ControlEvent( ControlEvent.REMOVE_ELEMENT, _element ) )	;
						break;
						
				}
				if (dialog) {
					dialog.addEventListener(Event.COMPLETE, addDialogHandler);	
					addChild(dialog);
				}
				
				
							
				function addDialogHandler(e:Event):void {
					(DataManager.popupManager as PopUpsManager).addPopup(dialog, "Element properties");
				}
			}

        }
		
		public function updateHandler( e:ControlEvent):void { 
			dispatchEvent( new ControlEvent( ControlEvent.ELEMENT_UPDATE, _element ) )	;
		}
		
		public function selectionHandler( e:UiEvent):void { 
			trace("[a][p] QuickToolbarPanel - selectionHandler() " + e.data['src'] + " - e.data['src']");
			_element.setProperty( "src",  e.data['src']);
			dispatchEvent( new ControlEvent( ControlEvent.ELEMENT_UPDATE, _element ) )	;
		}
		
		public function addElementFromObject( obj:Object):void {
			//trace("addElementFromObject");
			//canvas.node.addNodeFromObject(obj);
			DataManager.selectedElement.properties = obj;
			DataManager.receiver.drawPage();
			DataManager.receiver.updateWindows();
		}

        public function onControlReady( e : ControlEvent ) : void {
          //  trace( "QuickToolbarPanel.onControlReady: dispatchEvent for resize window\n" );
		  //trace("QTP onControlReady: " + e.size.width );
            dispatchEvent( new UiEvent( UiEvent.DOCUMENT_READY, e.data ) );
        }

        public function clear() : void {
			if( _control){
				if ( _control.stage ) {
					_control.destroy();
					removeChild( _control );
				}
			}
        }

        public function select( param : String ) : void {
            trace( "[a][p] QuickToolbarPanel - select() - Apply: " + param  );
            var el : Array = _control.canvas.elements;

            for ( var i : int = 0; i < el.length; i ++ ) {
                if( el[i] is Input ){
                    if ( ( el[i] as Input ).val ) {
						
						
						// Canvas layout "absolute" to "inline" transition
						if (_element is Canvas && ( el[i] as Input ).val == "layout") {
							//trace(" --------------> " + ( el[i] as Input ).val + " x " +el[i].inputText);
							var c:Canvas = _element as Canvas;
							if ( c.layout == "absolute" && (el[i].inputText == "inlineH" || el[i].inputText == "inlineV")) {
								//c.layout = el[i].inputText;
								for (var j:int = 0; j < c.node.childNodes.length; j++) {
									if ( c.node.childNodes[i].elementType == "Image") {
										c.node.childNodes[i].properties['src'] = Config.IMAGES_PATH + "pic05.jpg";
									}
									c.node.childNodes[i].properties['marginX'] = 0;
									c.node.childNodes[i].properties['marginY'] = 0;
									//trace(" --------------> " + ( el[i] as Input ).val + " x " +el[i].inputText);
								}
							}
						}
						
                        _element.setProperty( ( el[i] as Input ).val,  el[i].inputText );
                    }
                }
				
            }

            dispatchEvent( new ControlEvent( ControlEvent.ELEMENT_UPDATE, _element ) )	;
        }


        public function get canvas() : Canvas {
            return _control.canvas;
        }
		


        public function set element( value : * ) : void 	{

            if ( _control ) {
                if ( _control.stage ) {
                    _control.destroy();
                    removeChild( _control );
                }
            }
            buildPanel();
        }

    }

}