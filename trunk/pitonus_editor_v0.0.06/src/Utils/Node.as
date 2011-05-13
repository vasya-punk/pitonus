package Utils {

    import org.as3commons.collections.framework.IIterable;
    import org.as3commons.collections.framework.IIterator;
    import org.as3commons.collections.iterators.ArrayIterator;
    import org.as3commons.collections.framework.IDataProvider;

    public class Node implements IDataProvider, IIterable {
   


        protected static var i : uint = 0;
        public var id : uint = 0;
		
		private var _name : String;
        private var _canvas : Boolean = false;
		
        public var _properties : Object;
		private var _childNodes : Array = new Array();
 
        public function Node( name : String  ) {
            id = i ++ ;
            _name = name;
            // children = new Array();
        }

        public function addNode( node : Node ) : void {
            _canvas = true;
            _childNodes.push( node );
        }

        public function getItemAt( index : uint ) : * {
            return _childNodes[index];
        }

        public function get numItems() : uint {
            return _childNodes.length;
        }
		
        public function iterator( cursor : * = undefined ) : IIterator {
            return new ArrayIterator( _childNodes );
        }

        public function get name() : String {
            return _name;
        }
		
        public function get size() : uint {
            return _childNodes.length;
        }

        public function get childNodes() : Array {
            return _childNodes;
        }
		
        public function set childNodes( nodes : Array ) : void {
            _canvas = true;
            _childNodes = nodes;
        }
		
        public function get canvas() : Boolean {
            return _canvas;
        }
		
        public function itemAt( index : uint ) : * {
            return _childNodes[index];
        }
		
        public function toString() : String {
            return _name + " id[" + id.toString() + "]";
        }


        public function set properties( props : Object ) {
            _properties = props;
        }
		
        public function get properties() : Object {
            if( ! _properties )
				return null;
            else
				return _properties;

        }
    }

}