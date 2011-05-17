package Utils {

    import org.as3commons.collections.framework.IIterable;
    import org.as3commons.collections.framework.IIterator;
    import org.as3commons.collections.iterators.ArrayIterator;
    import org.as3commons.collections.framework.IDataProvider;

	import Utils.*;
	
    public class Node implements IDataProvider, IIterable {

        protected static var i : 	uint = 0;
       
		
		private var _name : 		String;
        private var _isCanvas : 	Boolean = false;
		private var _childNodes : 	Array;
		private var _properties : 	Object;
		
		public var id : 			uint = 0;
  
        public function Node( name : String  ) {
            id = i ++ ;
            _name = name;
            _childNodes = new Array();
        }

        public function addNode( node : Node ) : void {
            _isCanvas = true;
            _childNodes.push( node );
        }

        public function getItemAt( index : uint ) : * {
            return _childNodes[index];
        }
		
		public function removeNodeAt( index : uint ) : void {
           _childNodes.splice(index,1)
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
            _isCanvas = true;
            _childNodes = nodes;
        }
		
        public function get isCanvas() : Boolean {
            return _isCanvas;
        }
		
        public function itemAt( index : uint ) : * {
            return _childNodes[index];
        }
		
        public function toString() : String {
            return _name + id.toString();
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