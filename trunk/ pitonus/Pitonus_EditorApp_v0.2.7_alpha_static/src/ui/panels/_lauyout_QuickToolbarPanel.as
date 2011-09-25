package ui.panels
{

    import controls. * ;
    import data. * ;
    import elements. * ;
    import elements.canvas.Canvas;
    import events.ControlEvent;
    import events.UiEvent;
	import flash.events.MouseEvent;
    import flash.geom.Rectangle;
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
	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.framework.IDisplay;
	import org.as3commons.ui.layout.framework.IDynTable;
	import org.as3commons.ui.layout.framework.IGroupLayout;
	import org.as3commons.ui.layout.framework.IHLayout;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.framework.IMultilineLayout;
	import org.as3commons.ui.layout.framework.ITable;
	import org.as3commons.ui.layout.framework.IVLayout;
	import org.as3commons.ui.layout.shortcut.hgroup;
	import org.as3commons.ui.layout.shortcut.hlayout;
	import org.as3commons.ui.layout.shortcut.vgroup;

    public class QuickToolbarPanel extends Sprite
    {
        private var _receiver : * ;
        private var _ready : Boolean = false;
        private var _element : Element
        private var _w : uint = 100;
        private var _h : uint = 100;
        private var _control : ControlWrapper;
		public var tabLayout : ILayout;
		private var _panel:* = null;
		
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

            if ( _element ) {
				
				

				var _aviableElements:Object =	DataManager.mcClasses;
				var elementTypeNum : int =  _aviableElements['names'].indexOf( "quickSelect_Panel" );
				var elementClass : * = null;
				var menuElements:Array = new Array();
				
				if ( elementTypeNum != - 1 ) {
					elementClass = _aviableElements['runtimeClassRefs'][elementTypeNum];
				}
				
				if (elementClass) {
					
					//for (var i:int = 0; i < items.length; i++) {
						_panel = new elementClass;
						//element.x = element.width * i + i * 1;
						//element.name = i;
						//element.menuMC.label.text = items[i]; 
						
						//element.menuMC.over();

						_panel.btn1.addEventListener(MouseEvent.CLICK, onMenuClick);
						_panel.btn2.addEventListener(MouseEvent.CLICK, onMenuClick);
						
						/*
						menuElements.push(_panel);*/
					//}
					
				
				
				
				
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
										"w" : "200"
									}
								}
								,
								"elementType" : "Canvas",
								"layout" : "inlineH",
								"w" : "200","h" : "100"
							}
						}
						,
						"elementType" : "Canvas",
						"layout" : "inlineH",
						"w" : "200", "h" : "100"
						
					}

					var props : Object = _element.getMinimalProperties();
					// trace( "Props......................" );
					// traceObject( props );

					var j : uint = 2;

					for ( var i : String in obj['pages' ] ) {

						for( var item : String in props ){
							// trace( " ---> " + item );
							// for( var p : String in props['elements'] ){

							obj['pages'][i]['elements'][j] =
							{
								"w" : "150", "h" : "20",
								"elementType" : "Input",
								"text" : _element.getProperty( item ),
								"label" : item, // props[item]
								"val" : item
							}
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
						"w" : "200","h" : "100", 
						"elementType" : "Canvas",
						"layout" : "inlineH",
						"elements" : {

							"1" : {
							   "src":"editor/bg03.png",
							   "elementType":"Image",
							   "h":"300","w":"200"

							}
						}
					};

					_control = new ControlWrapper( parseTreeRecursive( obj ), DataManager.getCommands(), this );
					_control.addEventListener( ControlEvent.CONTROL_READY, onControlReady );
					addChild(_control);
					

				}
            }
			
			
			function onMenuClick(e:MouseEvent):void {
					trace("MouseEvent " + e.currentTarget + " " + e.currentTarget.name);
					//dispatchEvent(new ControlEvent(ControlEvent.MENU_CLICK, uint(e.currentTarget.name)));
					switch (e.currentTarget.name) 
					{
						default:
						/*case "btn1":
							_rec.addElement("Image");
						break;
						case "btn2":
							_rec.addElement("TextBlock");
						break;
						case "btn3":
							_rec.addElement("ActiveImage");
						break;
						case "btn4":
							_rec.addElement("Button");
						break;*/
						
					}
			}

        }


        public function onControlReady( e : ControlEvent ) : void {
          //  trace( "QuickToolbarPanel.onControlReady: dispatchEvent for resize window\n" );
		  //trace("QTP onControlReady: " + e.size.width );
		  
			tabLayout = vgroup(
	
							
							_panel,
							_control
			
					);
					
			tabLayout.layout(this);
		  
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
            trace( ">>>select " + param  );
            var el : Array = _control.canvas.elements;

            for ( var i : int = 0; i < el.length; i ++ ) {
                if( el[i] is Input ){
                    if ( ( el[i] as Input ).val ) {
                        trace( ">>> >>> " + ( el[i] as Input ).val + " : " + el[i].text  );
                        _element.setProperty( ( el[i] as Input ).val,  el[i].inputText );
                        // _element[ ( el[i] as Input ).val] = el[i].text ;
                        trace( "--- " + _element[ ( el[i] as Input ).val] + " : " + ( el[i] as Input ).val );
                    }
                }
            }

            dispatchEvent( new ControlEvent( ControlEvent.ELEMENT_UPDATE, _element ) )	;
        }


        public function get canvas() : Canvas {
            return _control.canvas;
        }
		
		/*public function get size() : Rectangle{
            return _control.size;
        }*/

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