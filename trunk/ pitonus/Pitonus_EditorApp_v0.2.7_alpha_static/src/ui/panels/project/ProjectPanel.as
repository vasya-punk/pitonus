package ui.panels.project
{
	import com.sibirjak.asdpc.button.Button;
	import com.sibirjak.asdpc.button.ButtonEvent;
	import com.sibirjak.asdpc.core.managers.IPopUpControl;
    import data.DataNode;
    import controls. * ;
	import flash.events.MouseEvent;
    import managers. *
    import ui.panels. *
    import data.utils. * ;
	import events. * ;
	 
    import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.shortcut.vgroup;
	
    import flash.display.Sprite;
    import flash.events.Event;
   
	import com.sibirjak.asdpc.core.skins.BackgroundSkin;
    import com.sibirjak.asdpc.listview.ListItemEvent;
    import com.sibirjak.asdpc.listview.ListView;
    import com.sibirjak.asdpc.textfield.Label;

    public class ProjectPanel extends Panel implements IPanel
    {
        private var _navigation : * ;
		private var panel:* = null;

        public function ProjectPanel( rec : * ) {
            super( rec );
        }

        override public function init( e : Event = null ) : void 	{
            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
            _navigation = new ProjectListView( _rec.pages );
            drawPanel();
        }

        public function update() : void {
            _navigation.setDataSource();
            drawPanel();
        }

        public function saveSite () : void {
            _rec.saveSite();
        }

        public function addElement( type : String ) : void {
            if ( type == "Page" ) {
                dispatchEvent( new EditorEvent( EditorEvent.GENERIC, EditorEvent.PAGE_ADD ) );
            }
        }


        override public function drawPanel() : void {

            /*var elementNode : DataNode = parseTreeRecursive(

            {
                "elementType" : "Canvas",
                "w" : "200",
                "h" : "340",
                "layout" : "absolute",
                "pages" : {
                    "page0" : {
                        "elements" : {

                            "0" : {
                                "elementType" : "TextBlock",
                                "text" : "PROJECT 3:",
                                "w" : "200",
                                "h" : "450",
                                "fontColor" : "0x00974B"
                            } ,
                            "4" : {
                                "elementType" : "TextButton",
                                "label" : "Save Project",
                                "w" : "200",
                                "h" : "50",
                                "marginY" : "5",
                                "action" : "SaveSite"
                            },
                            "3" : {
                                "elementType" : "TextButton",
                                "label" : "Site Settings",
                                "w" : "200",
                                "h" : "50",
                                "actionParam" : "site",
                                "action" : "Settings"
                            }  ,
                            "bb4aa" : {
                                "elementType" : "TextButton",
                                "label" : "Add New Page",
                                "w" : "150",
                                "h" : "30",
                                "marginY" : "15",
                                "action" : "AddElement",
                                "actionParam" : "Page"
                            }



                        }
                        ,
						 "elementType" : "Canvas",
                        "w" : "200",
                        "h" : "180"
                    }
                }
            }

            );*/
			
            /*_control = new ControlWrapper( elementNode, DataManager.getCommands(), _rec );
            _control.addEventListener( ControlEvent.CONTROL_READY, setSize );
            addChild( _control );*/
			
			var _aviableElements:Object =	DataManager.mcClasses;
			var elementTypeNum : int =  _aviableElements['names'].indexOf( "project_Panel" );
			var elementClass : * = null;
			var menuElements:Array = new Array();
			
			if ( elementTypeNum != - 1 ) {
				elementClass = _aviableElements['runtimeClassRefs'][elementTypeNum];
			}
			
			if (elementClass) {
				
				//for (var i:int = 0; i < items.length; i++) {
					panel = new elementClass;
					//element.x = element.width * i + i * 1;
					//element.name = i;
					//element.menuMC.label.text = items[i]; 
					
					//element.menuMC.over();

					panel.btn1.addEventListener(MouseEvent.CLICK, onMenuClick);
					panel.btn2.addEventListener(MouseEvent.CLICK, onMenuClick);
			
					addChild(panel);
					
					addChild( _navigation );
					_navigation.y = 155;
					_navigation.x = 10;

				//}
				
			}
			function onMenuClick(e:MouseEvent):void {
				trace("[a][p] ProjectsPanel - onMenuClick() : " + e.currentTarget + " " + e.currentTarget.name);
				//dispatchEvent(new ControlEvent(ControlEvent.MENU_CLICK, uint(e.currentTarget.name)));
				switch (e.currentTarget.name) 
				{
					default:
					case "btn1":
						DataManager.receiver.site.settings();	
					break;
					case "btn2":
						DataManager.receiver.site.saveSite();
					break;
					
					
				}
			}
			
			var btn:Button = new Button();
			btn.label = "Add new page";	
			btn.setStyle(Button.style.labelStyles, [
			 Label.style.color, 0x535353,
			 Label.style.bold, true,
			 Label.style.backgroundColor, 0x808080,

			 Label.style.size, 13
			]);
			btn.setSize( 170, 25 );
			btn.moveTo(10, 125);
			btn.addEventListener(ButtonEvent.CLICK, clickHandler);
			
			function clickHandler(e:ButtonEvent) : void 	{ 
				DataManager.receiver.site.createPage();	
			}
			
			addChild(btn);
			
			setSize();
        }

        override public function cleanUp() : void 	{
            if ( _control ) {
                if ( _control.stage ) {
                    _control.removeEventListener( ControlEvent.CONTROL_READY, setSize );
                    _control.destroy();
                    removeChild( _control );
                    _control = null;
                }
            }
            drawPanel();

        }

        override public function setSize( e : ControlEvent = null ) : void 	{

            /*if ( ! _background ) {

                tabLayout = vgroup(
                "offsetX", 0,
                "offsetY", 0,
                "hGap", 8,
                "vGap", 4,

                _control,
                _navigation

                );

                tabLayout.layout( this );

                _background = new BackgroundSkin();
                _background.setSize( tabLayout.visibleRect.width, tabLayout.visibleRect.height );
                addChildAt( _background, 0 );*/
                DataManager.layout.addToLayout( this, Config.ALIGN_TOP_RIGHT );
          /*  }
            else {
                tabLayout.layout( this );
                _background.setSize( tabLayout.visibleRect.width, tabLayout.visibleRect.height + 10);
            }*/

        }
    }

}