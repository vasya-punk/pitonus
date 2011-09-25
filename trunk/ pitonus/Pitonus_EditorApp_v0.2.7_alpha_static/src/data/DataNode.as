package data {

    import org.as3commons.collections.framework.IIterable;
    import org.as3commons.collections.framework.IIterator;
    import org.as3commons.collections.iterators.ArrayIterator;
    import org.as3commons.collections.framework.IDataProvider;

	import utils.*;
	import data.utils.*;
	
    public class DataNode extends Node implements IDataProvider, IIterable {

	//	private var _id:String = null;
		private var _design:DataNode = null;
		private var _multipage:Boolean = false;
		
        public function DataNode( name : String  = null ) {
			super();
			if (name){
				this.name = name;
			}else {
				name = _id;	
			}

        }
		
		// Public ......................................................................
		
		// does't copy properties of nested pages or elements children
		public function addProperties( props:Object):void {
			var newProperties:Object = new Object();
			for (var p:String in props) {
				if(p != "pages" && p != "elements" && p != "design"){
					newProperties[p] = props[p];	
				}/*else {
					newProperties[p] = parseTreeRecursive(props[p]);
				}*/
			}
			this.properties = newProperties;
		}
      	
		public function addNodeFromObject( object : Object) : void {
			/*for (var name:String in object) {
				trace("addNodeFromObject________" + name);
			}*/
			//traceObject(object);
			var n:DataNode = createNodeFromObject(object);
            addNode( n );
			//trace("[Error] DataNode.addNodeFromObject() - disabled function");
        }

		public function removeNodes( ) : void {
			this.childNodes = new Array();
        }

		/*	
		public function set id( ID:String) : void{
			_id = ID;
        }*/

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
		
		
		// Getter/Setter --------------------------------------------------------------
		public function get design():DataNode { 
			return _design;
		}
		
		public function get elementType():String{ 
			return properties['elementType'];
		}
	
		public function set design(node:DataNode):void {
			_design = node;
		}
		
	

		
		
    }

}