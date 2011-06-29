package data.utils 
{
	import data.*;
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */

		
	
		public function createNodeFromObject( object : Object) : DataNode {

			var name:String = (object['name']) ? object['name'] : object['elementType'];

			var node:DataNode = new DataNode( name );
			node.addProperties(object);

			return  node;
        }
		
	

}