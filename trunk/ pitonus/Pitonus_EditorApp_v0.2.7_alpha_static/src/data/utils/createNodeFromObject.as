package data.utils 
{
	import data.*;
	import utils.*;
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */

		
	
		public function createNodeFromObject( object : Object) : DataNode {

			var name:String = (object['name']) ? object['name'] : object['elementType'];
			name += String(randomRange(0, 100));
			var node:DataNode = new DataNode( name );
			node.addProperties(object);

			//trace("[Error] createNodeFromObject() - diabled function");
			return  node;
        }
		
	

}