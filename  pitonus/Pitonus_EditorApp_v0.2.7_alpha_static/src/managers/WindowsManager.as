package managers
{
    import flash.display.Sprite;
    import flash.events.Event;
    import events. * ;
	import flash.geom.Rectangle;
    import ui. * ;
    import ui.pinbar. * ;
    import com.sibirjak.asdpcbeta.window.core.WindowPosition;
    import com.sibirjak.asdpcbeta.window.Window;
    import com.sibirjak.asdpc.core.constants.Position;
    import ui.windows. * ;
    import ui.panels.*;
    import com.greensock. * ;
    import com.greensock.easing. * ;
    import ui.windows.NavigationWindow;



    public class WindowsManager extends Sprite
    {

        private var _sizeIcon : Class;

        private var _application_cascade : Class;

        private var windowContainer : WindowContainer;
        private var windows : Object;
        private var pinBar : PinBar ;
        private var _rec : * ;

        public function WindowsManager( rec : * , wc : * ) {
            _rec = rec;
            windowContainer = wc;

            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point

            createWindows(  );

            // TweenLite.delayedCall( 1, createWindows );

        }

        private function createWindows() : void {
            
			windows = new Object();

            pinBar = new PinBar();
            pinBar.setStyle( PinBar.style.position, Position.BOTTOM );


            createNavigationWindow();
            createQuickToolbarWindow();

            addChild( pinBar );
        }

        public	function updateWindows( trg : * = null ) : void {
			
			
			trace("[i][m] WindowsManager - updateWindows()" );
			
            var quickToolbarWindow : Window = windows['quickToolbarWindow'];
            var navigationWindow : Window = windows['navigationWindow'];

			if ( quickToolbarWindow ) {
				if ( quickToolbarWindow.document.stage ) {
					if( DataManager.selectedElement ){
						( quickToolbarWindow.document as QuickToolbarPanel ).element = DataManager.selectedElement;
						quickToolbarWindow.restore();
					}
					else {
						( quickToolbarWindow.document as QuickToolbarPanel ).clear();
					}
				}
			}
			
			if ( navigationWindow ) {
				if( DataManager.selectedElement ){
					( navigationWindow.document as NavigationWindow ).reDrawContent( DataManager.selectedElement.node );
				}
				else {
					( navigationWindow.document as NavigationWindow ).reDrawContent();
				}
			}



        }



        private function resizeQTWindow( e : UiEvent ) : void {
			var r:Rectangle = e.data.size;
            var quickToolbarWindow : Window = windows['quickToolbarWindow'];
            quickToolbarWindow.setSize(  e.data.width, e.data.height);
        }

        private function createQuickToolbarWindow( element : * = null ) : void {

			var quickToolbarWindow : Window = new Window();
         
            quickToolbarWindow.moveTo( 450, 20 );
            quickToolbarWindow.setStyle( Window.style.windowIconSkin, _application_cascade );


            quickToolbarWindow.document = new QuickToolbarPanel( this );

            quickToolbarWindow.document.addEventListener( UiEvent.DOCUMENT_READY, resizeQTWindow );
            quickToolbarWindow.document.addEventListener( ControlEvent.ELEMENT_UPDATE, onElementUpdate );
			quickToolbarWindow.document.addEventListener( ControlEvent.REMOVE_ELEMENT, onElementRemove );

            function onElementUpdate( e : ControlEvent ) : void {
				//trace("WindowsManager. onElementUpdate ................ ");
                _rec.updateTransformSelection( e.data );
            }
			
			 function onElementRemove( e : ControlEvent ) : void {
                _rec.site.removeElement();
            }

            quickToolbarWindow.title = "QuickToolbar";
            quickToolbarWindow.minimisePosition = new WindowPosition( 100, 0 );
            quickToolbarWindow.minimised = true;
            // quickToolbarWindow.setSize(  100, 100 );

            windowContainer.addChild( quickToolbarWindow );


            pinBar.registerWindow( quickToolbarWindow, _application_cascade );
            windows['quickToolbarWindow'] = quickToolbarWindow;

        }
 


        private function createNavigationWindow(  ) : void {

            windows['navigationWindow'] = new Window();
            var navigationWindow : Window = windows['navigationWindow'];

            navigationWindow.moveTo( 775, 20 );
            navigationWindow.setStyle( Window.style.windowIconSkin, _application_cascade );


            navigationWindow.document = new NavigationWindow(  this );
            navigationWindow.document.addEventListener( UiEvent.NODE, onSelectNode );

            function onSelectNode( e : UiEvent ) : void {
                _rec.onSelectNode( e.data );
            }

            navigationWindow.title = "Navigation";
            navigationWindow.minimisePosition = new WindowPosition( 300, 0 );

            navigationWindow.minimised = true;

            windowContainer.addChild( navigationWindow );

            navigationWindow.setSize(
				NavigationWindow( navigationWindow.document ).tabLayout.visibleRect.width + 10,
				NavigationWindow( navigationWindow.document ).tabLayout.visibleRect.height + 46
            );


            pinBar.registerWindow( navigationWindow, _application_cascade );

        }
    }

}