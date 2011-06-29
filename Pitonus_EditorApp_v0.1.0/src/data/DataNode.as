package data {

    import org.as3commons.collections.framework.IIterable;
    import org.as3commons.collections.framework.IIterator;
    import org.as3commons.collections.iterators.ArrayIterator;
    import org.as3commons.collections.framework.IDataProvider;

	import utils.*;
	import data.utils.*;
	
    public class DataNode extends Node implements IDataProvider, IIterable {

        public function DataNode( name : String  = null ) {
			super();
			if (name)
				this.name = name;
        }
		
		// Public ......................................................................
		
		// does't copy properties of nested pages or elements children
		public function addProperties( props:Object):void {
			var newProperties:Object = new Object();
			for (var p:String in props) {
				if(p != "pages" && p != "elements"){
					newProperties[p] = props[p];	
				}else {
					newProperties[p] = parseTreeRecursive(props[p]);
				}
			}
			this.properties = newProperties;
		}
      	
		public function addNodeFromObject( object : Object) : void {
			var n:DataNode = createNodeFromObject(object);
            addNode( n );
        }

		public function removeNodes( ) : void {
			this.childNodes = new Array();
        }

		public function removeNode( node : DataNode) : void {
			
			// TODO remove Nodes recursive
			for (var i:uint = 0 ; i < this.childNodes.length; i++ ) {
				//trace( node + " : " + this.childNodes[i]   );
				if ( node == this.childNodes[i] ) {
					this.removeNodeAt(i);
				}
			}
			//this.removeNodeAt(1);
        }
		
		

		
		
    }

}