package Elements
{

    import com.greensock.easing.Strong;
    import com.sibirjak.asdpc.treeview.TreeNodeEvent;
    import com.sibirjak.asdpc.treeview.TreeView;
    import fl.controls.ComboBox;
    import flash.display.DisplayObject;
    import flash.events.Event;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFieldAutoSize;

    import com.sibirjak.asdpcbeta.selectbox.SelectBox;
    import com.sibirjak.asdpc.listview.ListItemEvent;
    import org.as3commons.collections.framework.IRecursiveIterator;
    import org.as3commons.collections.iterators.RecursiveIterator;
    import flash.display.Sprite;


    import Utils. * ;
    import Managers. * ;
    import Elements. * ;
    import Configuration. * ;
    import Controls. * ;

    import org.as3commons.ui.layout.Display;
    import org.as3commons.ui.layout.HLayout;
    import org.as3commons.ui.layout.shortcut. * ;
    import org.as3commons.ui.layout.debugger.LayoutDebugger;
    import org.as3commons.ui.layout.HGroup;
    import org.as3commons.ui.layout.VGroup;

    public class  Tree extends Element implements IElement
    {

        public var view : TreeView;

        public function Tree( node  : Node ) {
            //trace( "Tree const" );
            super( node );
        }
		
        public function selectNode( node  : Node ) {
            view.expandNodeAt( 0, true );
            // view.expandNodeAt( 1, true );
            view.selectItemAt( node.id  - 1 );
            // view.expandNodeAt( 3, false ); */
        }
		
        override public function init() : void {

            //trace( "Tree init" );
            addBounds();

            view = new TreeView();
            view.dataSource = Manager.getSiteRootNode();

            view.setStyle( TreeView.style.showRoot, false );
            view.setSize(  int( _node.properties['w'] ) - 10, int( _node.properties['h'] )   );


            addChild( view );

            view.addEventListener( TreeNodeEvent.SELECTION_CHANGED, selectHandler );




         

            function selectHandler( e : TreeNodeEvent ) : void {

                if ( e.selected ) {
                    //trace( e.item + " "  + ( e.item as Node ).id );
                    // traceObject( event.item.properties, event.item );
					dispatchEvent( new SimpleEvent(SimpleEvent.SIMPLE_EVENT , e.item as Node ) );
                }
                else {
                    trace( "No item selected" );
                }
            }

        }


    }
}