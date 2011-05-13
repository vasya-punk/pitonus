package {
        import org.as3commons.collections.framework.IRecursiveIterator;
        import org.as3commons.collections.iterators.RecursiveIterator;
        import flash.display.Sprite;

	import Elements.*;
	import Controls.*
	import Utils.*
	import Utils.Communication.*;
	import Utils.Console.*
	import Managers.*;
	
	import Editor.*;
	import com.sibirjak.asdpc.treeview.*;
	import org.as3commons.collections.*;
	import org.as3commons.collections.framework.*;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.adobe.serialization.json.*;	
	

		
        public class test extends Sprite {
			private var dataBridge:					JSBridge;
			private var obj:Object;
			//private var _i:uint = 0;
                public function test() {
					dataBridge = new JSBridge();
					dataBridge.addEventListener( JSBridgeEvent.STRUCTURE_RECIEVED, processData);
					function processData(e:JSBridgeEvent):void {
						var str:String = e.data;
						obj = JSON.decode( str );
					}
                        /*var root : Node = new Node();

                        var child1 : Node = new Node();
                        child1.children = [new Node(), new Node()];
						
                        var child2 : Node = new Node();
                        child2.children = [new Node(), new Node()];
						
                        var child3 : Node = new Node();
                        var child4 : Node = new Node();
						
                        child4.children = [new Node(), new Node()];
                        child3.children = [child4, new Node()];

                        root.children = [child1, child2, child3];*/
						
var s:String = '{"siteName":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"elementType":"Canvas","name":"ElementProperties","w":"200","h":"150","x":"50","y":"220","elements":[{"elementType":"InputProperty","label":"First","value":"Default1","w":"150","h":"25"},{"elementType":"InputProperty","label":"Second","value":"Default2","w":"150","h":"25"},{"elementType":"Canvas","w":"200","h":"150","x":"50","y":"220","name":"StamProperties","elements":[{"elementType":"InputProperty","label":"Second","value":"Default2","w":"150","h":"25"}]}]},{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"},{"elementType":"ActiveImage","caption":"Another day","src":"stamPic2.jpg","action":"DefaultCommand","actionParam":"gl hf","w":"200","h":"150","x":"300","y":"100"}]}]}';
//var s:String = '{"siteName":"Pitonus Demo","age":"0.25","elementType":"Root","pages":[{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"},{"elementType":"ActiveImage","caption":"Another day","src":"stamPic2.jpg","action":"DefaultCommand","actionParam":"gl hf","w":"200","h":"150","x":"300","y":"100"}]},{"pageId":"0","x":"5","y":"5","w":"600","h":"300","elementType":"Canvas","name":"homepage","elements":[{"elementType":"ActiveImage","caption":"First day","src":"stamPic.jpg","action":"DefaultCommand","actionParam":"Hi","w":"200","h":"150","x":"100","y":"100"}]}]}';

dataBridge.pitLoad(s);
						
						//var root : Node = new Node();
						//root.obj = obj;
						
						
						function rec(obj:Object, d:uint = 0):Node {
							d++;
							trace("\n");	
							var node:Node;
						
							for ( var s:String in obj ) {
		
								if (obj[s] is Array) {
									
									trace(prefix(d) + " Property is Array : [" + s  + "] ");
									
									var i:uint
									var c:Array = new Array();
									node = new Node();
									
									if (s == 'pages' || s == 'elements' ) {
										
										for ( i = 0; i < obj[s].length; i++ ) {
											
											var rc:Node = rec(obj[s][i], d);

											if(rc != null){
												rc.properties = obj[s][i];
												c.push(rc);
											}
										}
									}
									
											
									node.children = c;
									//trace("\n" + d + " Children num: " + node.children.length + " "+ node);
									
								}else {
									trace(prefix(d) + " Property: " + obj['elementType'] + " : '" + s + "' = " + obj[s]);
								}
								
							}
							
							return (node) ? node : null;
						}
						
						//traceObject(obj);
						
						

						
						
						var root : Node =   rec(obj)
						root.properties = (obj);
					
						
						trace( "\n ****** RecursiveIterator ******\n\nRoot");
						traceObject(root.properties);				
                        
						var iterator : IRecursiveIterator = new RecursiveIterator(root);
                        var item : Node;

                        while (iterator.hasNext()) {
							item = iterator.next();

							
							try {
								trace("\nitem: " + item);
									//if (item.children){// ['action'] == "DefaultCommand" )
										trace( "." + prefix(iterator.depth) 
													+ " | " + iterator.depth 
													+ "  > Canvas" );
										traceObject(item.properties);
									//}
								
							}catch (e:Error) {
									trace("[Error] " + e);
							}
                        }
						
						var list : ArrayList = new ArrayList();

						var a:* = obj;
						a['name'] = "Page " + a['pageId'];
						list.add(a);

						//var treeIterator : IIterator = list.iterator();         
						var treeView:TreeView = new TreeView();		
						treeView = new TreeView();
						treeView.setStyle(TreeView.style.showRoot, false);
						treeView.setSize(180,300);
						treeView.dataSource = list;
						addChild(treeView);
			
                        // Node 1
                        // .......Node 2
                        // .......Node 3
                        // Node 4
                        // .......Node 5
                        // .......Node 6
                        // Node 7
                        // .......Node 8
                        // ..............Node 9
                        // ..............Node 10
                        // .......Node 11
                }
				//private function set i(theI:uint):void {	_i = theI;	 }
				/*
				 * private function get i():uint {		
					return ++_i;	
				}*/
				
                private function prefix(depth : uint) : String {
						if (depth == 0)
							return "[pages] ";
                        var prefix : String = "";
                        for (var i : uint = 0; i < depth; i++) 
							prefix += ".";
                        return prefix;
                }
        }
}

import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.iterators.ArrayIterator;

internal class Node implements IIterable {
		protected static var i:uint = 0;
        public var id : uint = 0;
        public var children : Array;
		public var _properties : Object;
        public function Node() {
            
			//number = (theNumber == 0) ? i++ : theNumber;
			id = i++;

            children = new Array();
        }
        public function iterator(cursor : * = undefined) : IIterator {
                return new ArrayIterator(children);
        }
        public function toString() : String {
                return "Node " + id.toString();
        }
		
		
		public function set properties(props:Object) {
				//trace("   _properties: " +props);
				_properties = props;
		}
		public function get properties():Object {
			if(!_properties)
				return null;
			else
				return _properties;
			
		}
}


