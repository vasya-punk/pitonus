package  
{
	public class Config {
		
		public static const DEBUG:Boolean = true;
		
		// DEBUG_LEVEL > 4 - to inspect layouts
		public static const DEBUG_LEVEL:uint = 3;
		
		public static const ELEMENTS_CLASSES_PATH:String = "ElementsClasses/";
	
		
		public static const DEFAULT_PAGE_ID:uint = 0;
				
				
		// DESIGN
		public static const ICONS_SCALE_RATIO:Number = 0.25;
		public static const ROUND_CORNERS:Number = 6;
		public static const ANIMATION_DELAY:Number = 0.25;
		
		// Command types
		public static const PAGE_COMMANDS: String = "page_commands";
		public static const DESIGN_COMMANDS: String = "design_commands";
		public static const EDITOR_COMMANDS: String = "editor_commands";
		public static const EXTERNAL_COMMANDS: String = "external_commands";
		
		public static const  PROPERTIES_PANEL_CANVAS_DATA:Object  = 
		{
  "canvasType": "Panel",
  "name": "Properties panel",
  "x": "750",
  "y": "5",
  "w": "195",
  "h": "540",
  "elements": [
  
    {
      "elementType": "Button",
	  "identifier":"UPDATE_BUTTON",
      "caption": "AddCanvas",
      "action": "AddElement"
    }, {
      "elementType": "Button",
	  "identifier":"REMOVE_BUTTON",
      "caption": "RemoveCanvas",
      "action": "RemoveElement"
    }, {
      "elementType": "Button",
	  "identifier":"SAVE_BUTTON",
      "caption": "UpdateElement",
      "action": "UpdateElement"
    }
  ]
}
;
		
		public static const  TEST_CONTENT_DATA_STRING:String  = <![CDATA[
		
		
		
{
  "name": "Pitonus Demo",
  "age": "0.25",
  "pages": [
    {
      "pageId": "0",
      "x": "5",
      "y": "5",
      "w": "650",
      "h": "500",
	  "identifier":"HOMEPAGE",
      "name": "Homepage",
      "elementType": "Canvas",
      "name": "homepage",
      "elements": [
        {
		 "elementType": "Canvas",
          "w": "450",
          "h": "150",
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
            },{
              "elementType": "ActiveImage",
              "caption": "InsideCanvas2",
              "src": "stamPic.jpg",
              "name": "ActiveImage Name",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "120",
              "h": "30"
            },{
		 "elementType": "Canvas",
          "w": "50",
          "h": "70",
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
              "w": "20",
              "h": "40"
            },{
              "elementType": "ActiveImage",
              "caption": "InsideCanvas2",
              "src": "stamPic.jpg",
              "name": "ActiveImage Name",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "50",
              "h": "30"
            },{
              "elementType": "ActiveImage",
              "caption": "InsideCanvas3",
              "src": "stamPic2.jpg",
              "name": "ActiveImage Name",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "60",
              "h": "30"
            }
          ]
         
        }
          ]
         
        },
        {
          "elementType": "ActiveImage",
          "caption": "First day",
          "src": "stamPic.jpg",
          "name": "ActiveImage Name",
          "action": "DefaultCommand",
          "actionParam": "Hi",
          "w": "100",
          "h": "150"
        },
        {
          "elementType": "ActiveImage",
          "caption": "not First 2 day",
          "src": "stamPic1.jpg",
          "action": "DefaultCommand",
          "actionParam": "Hi",
          "w": "150",
          "h": "150"
        }
		,
        {
          "elementType": "ActiveImage",
          "caption": "not First 2 day",
          "src": "stamPic1.jpg",
          "action": "DefaultCommand",
          "actionParam": "Hi",
          "w": "150",
          "h": "150"
        }
		,
        {
          "elementType": "ActiveImage",
          "caption": "not $$ day",
          "src": "stamPic1.jpg",
          "action": "DefaultCommand",
          "actionParam": "Hi",
          "w": "50",
          "h": "150"
        }
			,
		
        {
          "elementType": "ActiveImage",
          "caption": "Another day",
          "src": "stamPic2.jpg",
          "action": "DefaultCommand",
          "actionParam": "gl hf",
          "w": "50",
          "h": "200"
        }
      ]
    }
  ]
}


]]>;
;
			
			//	var s:String = '{"siteName":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","pageType":"HomePage","pageName":"homepage","elements":[{"elementType":"Button","caption":"pageButton : Read more >>","x":"200","y":"350","action":"NextPage"},{"elementType":"StaticText","id":"1","x":"200","y":"100","w":"500","h":"150","briefText":"HEADER Lorem Ipsum is simply dummy text of the printing and typesetting industry.","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."},{"elementType":"StaticText","id":"2","x":"200","y":"220","w":"500","h":"100","briefText":"Second Header","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.."},{"elementType":"Image","src":"pageBg.png","x":"150","y":"50","w":"583","h":"372"}]},{"pageId":"1","pageType":"TextPage","pageName":"About us","elements":[{"elementType":"ActiveImage","caption":"Another day2","src":"stamPic2.jpg","x":"50","y":"300","action":"PreviousPage"},{"elementType":"StaticText","id":"2","x":"50","y":"50","w":"500","h":"100","briefText":"Header on second page","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.. By the way. it could be a htmlText, so it is possible to include images and hyperlinks within in.. "},{"elementType":"Button","id":"5","caption":"Prev Page","x":"200","y":"350","action":"PreviousPage"},{"elementType":"Image","src":"pageBg2.png","x":"150","y":"50","w":"583","h":"372"}]},{"pageId":"2","pageType":"TextPage","pageName":"Stam","elements":[{"elementType":"ActiveImage","caption":"Another day 3","src":"stamPic.jpg","x":"0","y":"200","action":"GotoToPageId","actionParam":"0"},{"elementType":"StaticText","id":"2","x":"50","y":"50","w":"500","h":"100","briefText":"Header on third page","fullText":"By the way. it could be a htmlText, so it is possible to include images and hyperlinks within in.. ","src":"stamPic.jpg"}]},{"pageId":"3","pageType":"TextPage","pageName":"Stam","elements":[{"elementType":"StaticText","id":"2","x":"50","y":"200","w":"500","h":"100","briefText":"Header on third page","fullText":"By the way. it could be a htmlText, so it is possible to include images and hyperlinks within i htmlText, so it is possible to include images and hyperlinks within in.. "}]},{"pageType":"editor","elements":[{"elementType":"NavigationToolbar"},{"elementType":"PropertiesToolbar"}]},{"pageType":"template","templateName":"Simple template","elements":[{"elementType":"Button","caption":"Homepage","action":"GotoToPageId","x":"50","y":"400","actionParam":"0"},{"elementType":"Button","caption":"Page 1","action":"GotoToPageId","x":"150","y":"400","actionParam":"1"},{"elementType":"Button","caption":"page 2","action":"GotoToPageId","x":"300","y":"400","actionParam":"2"},{"elementType":"Button","caption":"page 2","action":"GotoToPageId","x":"450","y":"400","actionParam":"3"},{"elementType":"Image","src":"siteBg.jpg","x":"0","y":"15","w":"800","h":"485"},{"elementType":"Image","src":"logo.png","x":"25","y":"30","w":"120","h":"60"}]}]}';
			
			
			
			
	}
}