package Commands{
	
	
	import Controls.*;
	
	public class AddElement implements ICommand {
			
		private var receiver:*;
		private var element:Object = 

		 {
		 "elementType": "Canvas",
          "w": "50",
          "h": "120",
		  "identifier":"CANVAS_TO_REMOVE",
          "name": "ElementProperties",
          "elements": [
            {
              "elementType": "ActiveImage",
              "caption": "Inside",
              "src": "stamPic.jpg",
              "name": "ActiveImage Name",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "50",
              "h": "40"
            },
            {
              "elementType": "ActiveImage",
              "caption": "InsideCanvas2",
              "src": "stamPic1.jpg",
              "name": "ActiveImage Name",
              "action": "DefaultCommand",
			  "identifier":"MY_ACTIVEIMAGE",
              "actionParam": "Hi",
              "w": "75",
              "h": "40"
            }
          ]
         
        }

		;
		
		public function AddElement(rec:*):void {
			this.receiver = rec;
		}	
		
		public function execute():void {
			
			if (Config.DEBUG && Config.DEBUG_LEVEL > 2)	
				trace("\nAddElement Command Executed.");

			receiver.addElement(element);
		}
	}
}