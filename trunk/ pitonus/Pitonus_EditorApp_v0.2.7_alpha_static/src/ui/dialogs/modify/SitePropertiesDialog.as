package ui.dialogs.modify
{
    import controls. * ;
    import data. * ;
    import flash.display.Shape;
    import flash.geom.Rectangle;
    import ui.dialogs.Dialog;
    import ui.dialogs.selection.ChooseFromDialog;
    import ui.panels.Panel;
    import ui.panels.QuickToolbarPanel;
    import utils. * ;
    import events. * ;
    import data.utils. * ;
    import flash.events.Event;
    import flash.text.TextField;
    import managers. * ;
    import flash.display.Sprite;
    import elements.input. * ;
    import controls. * ;
    import flash.events.MouseEvent;
    import managers.utils.TraceNode;
    import com.adobe.serialization.json. * ;
    import org.as3commons.ui.layout.shortcut.vgroup;
    import com.sibirjak.asdpc.core.skins.BackgroundSkin;
	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	import fl.events.ListEvent;
	import fl.controls.ComboBox;


	
    public class SitePropertiesDialog extends Dialog
    {
        private var _toolbar : * ;
		private var panelHeight: uint = 75;

        public function SitePropertiesDialog ( rec : * = null ) {
            super( rec );
        }
        override protected function drawPanel() : void {

            var _aviableElements : Object = 	DataManager.mcClasses;
            var elementTypeNum : int =  _aviableElements['names'].indexOf( "siteProperties_Panel" );
            var elementClass : * = null;
            var menuElements : Array = new Array();

            if ( elementTypeNum != - 1 ) {
                elementClass = _aviableElements['runtimeClassRefs'][elementTypeNum];
            }

            if ( elementClass ) {
                var panel : * = null;
                panel = new elementClass;

                panel.btn1.addEventListener( MouseEvent.CLICK, onMenuClick );
                panel.btn2.addEventListener( MouseEvent.CLICK, onMenuClick );


            }

            addChild( panel );
            var separator : Sprite = dashHorizontal( 0, 0, 250 );
            addChild( separator );


            var obj : Object =

            {
                "pages" : {
                    "propertiesPage" : {
                        "elements" : {
                            "0" : {
                                "text" :  "Select background align",
                                "fontColor" : "0x00974B",
                                "elementType" : "TextBlock",
                                "h" : "50",
                                "w" : "225"
                            }
                        }
                        ,
                        "elementType" : "Canvas",
                        "layout" : "inlineH",
                        "defaultPage" : "true",
                        "w" : "200", "h" : "100", "marginX" : "10", "marginY" : panelHeight + 15
                    }
                }
                ,
                "elementType" : "Canvas",
                "layout" : "absolute",
                "w" : "200", "h" : "100", "marginY" : "50"
            }

            _control = new ControlWrapper( parseTreeRecursive( obj ), DataManager.getCommands(), this );
            _control.addEventListener( ControlEvent.CONTROL_READY, setSize );
            _control.addEventListener( ControlEvent.PAGE_CHANGED, update );
            addChild( _control );

			
			addChild(dashHorizontal(10,panelHeight + 10,240));
			
			
			var myComboBox:ComboBox = new ComboBox();
			myComboBox.addItem( { label: Config.ALIGN_FULLSCREEN } );
			myComboBox.addItem({label: Config.ALIGN_BOTTOM_CENTER });
			myComboBox.addItem({label: Config.ALIGN_BOTTOM_LEFT });
			myComboBox.addItem({label: Config.ALIGN_BOTTOM_RIGHT });
			myComboBox.addItem({label: Config.ALIGN_CENTER });
			myComboBox.addItem( { label: Config.ALIGN_LEFT_CENTER } );
			myComboBox.addItem({label: Config.ALIGN_RIGHT_CENTER });
			myComboBox.addItem({label: Config.ALIGN_TOP_CENTER });
			myComboBox.addItem( { label: Config.ALIGN_BOTTOM_CENTER } );
			myComboBox.addItem({label: Config.ALIGN_TOP_LEFT });
			myComboBox.addItem({label: Config.ALIGN_TOP_RIGHT });
			

			myComboBox.move(10, panelHeight + 35);
			myComboBox.setSize(230,24)
			addChild(myComboBox);
			
			myComboBox.addEventListener(Event.CHANGE, selectItemHandler);

			function selectItemHandler(event:Event):void{
			   trace(myComboBox.value);
			   DataManager.receiver.site.design.backgroundAlign(myComboBox.value);
			}
			
/*
			var maxLength:Number = 0;
			var i:uint;
			
			myComboBox.selectedIndex = -1;
			myComboBox.dropdownWidth = maxLength + 20;
			myComboBox.open();*/
			
			
			
			
			
            /*
            obj['design'] = {
            "w" : "400", "h" : "400",
            "elementType" : "Canvas",
            "layout" : "absolute",
            "elements" : {
            "0" : {
            "elementType" : "IconsBar",
            "w" : "350",
            "items" : [
            "i10", "i11"
            ],
            "h" : "40"
            }
            }
            }; */

            /* var separator : Sprite = dashHorizontal( 0, 0, 250 );
            addChild( separator );

            _control = new ControlWrapper( parseTreeRecursive( obj ), DataManager.getCommands(), this );
            _control.addEventListener( ControlEvent.CONTROL_READY, setSize );
            _control.addEventListener( ControlEvent.PAGE_CHANGED, update );
            addChild( _control ); */

        }


        private function onMenuClick( e : MouseEvent ) : void {
            trace( "[a][d] SitePropertiesDialog - onMenuClick() : " + e.currentTarget.name );
            // dispatchEvent( new ControlEvent( ControlEvent.MENU_CLICK, uint( e.currentTarget.name ) ) );

            var dialog : * ;
            switch ( e.currentTarget.name )
            {
                default :

                case "btn1" :
                    dispatchEvent( new UiEvent( UiEvent.SELECT_IMAGE, this ) );
                    break;

                case "btn2" :
                    DataManager.receiver.site.design.backgroundSrc = null;	
                    break;

            }

        }

	/*	override protected function setSize( e : ControlEvent = null ) : void 	{
			
			super.setSize(e);
			
			var _selectBox:SelectBox = new SelectBox();
			_selectBox.dataSource = ["a", "b", "c", "d", "e", "f"];
			_selectBox.selectItemAt(0);
			//_selectBox.setSize(w,h);
			//_selectBox.setStyle(SelectBox.style.maxVisibleItems, 6);
			//_selectBox.setStyle(SelectBox.style.listItemSize, 20);
			_selectBox.bindProperty(
				SelectBox.BINDABLE_PROPERTY_SELECTED_ITEM, itemSelected
			);
			
			_selectBox.y = panelHeight;
			addChild(_selectBox);

			var _label:Label = new Label();
			_label.text = "No item selected";
			_label.moveTo(0, panelHeight+25);
			addChild(_label);
	
			function itemSelected(item : String) : void {
				if (_label) {
					_label.text = (
						item + " is selected"
						+ " at " + _selectBox.selectedIndex
					);
				}
				//dispatchEvent(new DropDownListEvent(DropDownListEvent.ON_SELECT, caller, item));
			}
		}*/
	
        private  function update( e : ControlEvent = null ) : void 	{
            tabLayout.layout( this );
             trace( "[a][d] SitePropertiesDialog - update() : " + tabLayout.visibleRect.width + " x " + tabLayout.visibleRect.height );
        }

        override public function get w() : uint{
            return 250;
        }

        override public function get h() : uint{
            return this.height + 50;
        }
		
		

    }

}
