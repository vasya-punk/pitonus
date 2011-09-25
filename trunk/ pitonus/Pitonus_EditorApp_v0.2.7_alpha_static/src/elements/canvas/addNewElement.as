package elements.canvas
{
	import elements.canvas.*;
	import utils.*;
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */

		
		public function addNewElement( canvas:Canvas, elementType:String ):void {
			
			
			switch (elementType) 
			{

				case "ActiveImage":
					canvas.node.addNodeFromObject(
						{
							"elementType" 	: "ActiveImage",
							"w" 			:  String(randomRange(50,150)),
							"h" 			:  String(randomRange(50,150)), 
							"action" 		: "DefaultCommand",
							"caption" 		: "LoresIpsum " +  String(randomRange(1,150)),
							"src" 			: "pic01.jpg",
							"actionParam" 	: "DefaultCommand param",
							"marginX"		: randomRange(25,550),
							"marginY"		: randomRange(25,350),
							"inline"		: "false"
						}
					);

				break;
				
				case "Image":
					canvas.node.addNodeFromObject(
						{
							"elementType" 	: "Image",
							"w" 			: String(randomRange(50,150)),
							"h" 			: String(randomRange(50,150)), 
							"src" 			: "pic01.jpg",
							"marginX"		: String(randomRange(25,550)),
							"marginY"		: String(randomRange(25,350)),
							"inline"		: "false"
						}
					);
					
				break;
				
				case "TextBlock":
					canvas.node.addNodeFromObject(
						{
							"elementType" 	: "TextBlock",
							"header"		: "Lorem Ipsum",
							"text" 		: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
							"w"				: "180",
							"h"				: "450",
							"marginX"		:  String(randomRange(25,550)),
							"marginY"		:  String(randomRange(25,350)),
							"fontColor"		: "0x00974B",
							"inline"		: "false"
						}
					);
					
				break;
				
				case "Button":
					canvas.node.addNodeFromObject(
						{
							"elementType": "TextButton",
							"label": "New Button",
							"w": "180",
							"h": "30"
						}
					);
					
				break;
				
				default:
					
				break;
			}
			
		}
		


}