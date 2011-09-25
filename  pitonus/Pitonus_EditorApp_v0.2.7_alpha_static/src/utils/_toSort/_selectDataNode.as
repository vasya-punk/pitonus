package Utils
{
	import com.adobe.air.crypto.EncryptionKeyGenerator;
    import Elements.Canvas;
    import Elements.Element;
    import Utils. * ;
	import Data. * ;
    import Managers. * ;
    import com.sibirjak.asdpcbeta.selectbox.SelectBox;
    import com.sibirjak.asdpc.listview.ListItemEvent;
    import org.as3commons.collections.framework.IRecursiveIterator;
    import org.as3commons.collections.iterators.RecursiveIterator;

    public function selectDataNode( rootNode:DataNode, requestedNode  : DataNode ) : int{



        var iterator : IRecursiveIterator = new RecursiveIterator( rootNode );
        var item : DataNode;


        var i : uint = 0;
        while ( iterator.hasNext() ) {
            item = iterator.next();

            try {
                // trace( requestedNode + " | " + item + " | " + i );
                if ( requestedNode == item ) {
                    return  i  ;
                    // trace( prefix( iterator.depth ) + " | " + item + " id: " + item.id );
                }
            }
            catch ( e : Error ) {
                trace( "[Error] " + e );
            }
            i ++ ;
        }
		return -1;
    }
}