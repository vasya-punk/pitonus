package  
{
	public class Config {
		
		public static const DEBUG:Boolean = true;
		
		// DEBUG_LEVEL > 4 - to inspect layouts
		public static const DEBUG_LEVEL:uint = 2;
		
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
		
		public static const DEFAULT_NODE_NAME:String = "ElementId";
		
		
		public static const  PROPERTIES_PANEL_CANVAS_DATA:Object  = 
		{
		  "elementType": "Panel",
		  "name": "Properties panel",
		  "x": "1000",
		  "y": "10",
		  "w": "200",
		  "h": "580",
		  "elements": [
		   {
			  "elementType": "Canvas",
			   "name": "AttributesCanvas",
			  "identifier":"ATTRIBUTES_PANEL",
			   "w": "180",
				"h": "350", "elements":[
				
				]
			},
			 {
			  "elementType": "Button",
			  "identifier":"SAVE_BUTTON",
			  "caption": "UpdateElement",
			  "action": "UpdateElement"
			}
		  ]
		}
		;
		
		public static const  NEW_PAGE_DATA:Object  = 
		{
		  "elementType": "Canvas",
		  "name": "New Page",
		  "x": "5",
		  "y": "5",
		  "w": "650",
		  "h": "500",
		  "elements": [
		  
		  ]
		}
		;
		
	public static const  NAVIGATION_PANEL_DATA:Object  = {
			
		  "elementType": "Panel",
		  "name": "Navigation panel",
		  "x": "650",
		  "y": "5",
		  "w": "400",
		  "h": "340",
		  "elements": [{
			 "elementType": "Canvas",
			  "w": "250",
			  "h": "100",
			  "identifier":"NAVIGATION_PAGES",
			  "name": "Canvas inside Canvas",
			  "elements": [
				
			  ]
			 
			},
		  {
			"elementType" 	: "Tree",
            "name" : "Tree Site",
			"identifier":"NAVIGATION_TREE",
            "w": 			"300",
            "h" 		:	"300"
			},{
			  "elementType": "Button",
			  "caption": "AddElement",
			  "action": "AddElement"
			},{
			  "elementType": "Button",
			  "caption": "AddPage",
			  "action": "AddPage"
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
          "h": "200",
		  "identifier":"CANVAS_ON_PAGE",
          "name": "TestCanvas",
          "elements": [
            {
              "elementType": "ActiveImage",
              "caption": "Inside",
              "src": "stamPic.jpg",
              "name": "AI1 on TestCanvas",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "150",
              "h": "150"
            },{
		 "elementType": "Canvas",
          "w": "250",
          "h": "100",
		  "identifier":"CANVAS2",
          "name": "Canvas inside Canvas",
          "elements": [
            {
              "elementType": "ActiveImage",
              "caption": "Inside",
              "src": "stamPic.jpg",
              "name": "Element1 in Canvas in Canvas on homepage",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "50",
              "h": "50"
            },{
              "elementType": "ActiveImage",
              "caption": "InsideCanvas2",
              "src": "stamPic.jpg",
              "name": "Element2 in Canvas in Canvas on homepage",
              "action": "DefaultCommand",
              "actionParam": "Hi",
              "w": "50",
              "h": "50"
            }
          ]
         
        }
          ]
         
        },
        {
          "elementType": "ActiveImage",
          "caption": "First day",
          "src": "stamPic.jpg",
          "name": "Element on homepage",
          "action": "DefaultCommand",
          "actionParam": "Hi",
          "w": "100",
          "h": "150"
        },
        {
          "elementType": "ActiveImage",
          "caption": "Element on homepage",
          "src": "stamPic1.jpg",
          "action": "DefaultCommand",
		  "name": "Element on homepage",
          "actionParam": "Hi",
          "w": "150",
          "h": "150"
        }
		,
        {
          "elementType": "ActiveImage",
          "caption": "Element on homepage",
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
    },  {
      "pageId": "1",
      "x": "5",
      "y": "5",
      "w": "650",
      "h": "500",
      "name": "SAecond Page",
      "elementType": "Canvas",
      "name": "contact",
      "elements": [
         {
          "elementType": "ActiveImage",
          "caption": "Anotaaher day",
          "src": "stamPic2.jpg",
          "action": "DefaultCommand",
          "actionParam": "gl hf",
          "w": "50",
          "h": "200"
        }
		,
		{
          "elementType": "ActiveImage",
          "caption": "Anot22aaher day",
          "src": "stamPic.jpg",
          "action": "DefaultCommand",
          "actionParam": "gl hf",
          "w": "250",
          "h": "230"
        }
		
		]}
		
  ]
}


]]>;
;
			//	var s:String = '{"siteName":"Pitonus Demo","age":"0.25","pages":[{"pageId":"0","pageType":"HomePage","pageName":"homepage","elements":[{"elementType":"Button","caption":"pageButton : Read more >>","x":"200","y":"350","action":"NextPage"},{"elementType":"StaticText","id":"1","x":"200","y":"100","w":"500","h":"150","briefText":"HEADER Lorem Ipsum is simply dummy text of the printing and typesetting industry.","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."},{"elementType":"StaticText","id":"2","x":"200","y":"220","w":"500","h":"100","briefText":"Second Header","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.."},{"elementType":"Image","src":"pageBg.png","x":"150","y":"50","w":"583","h":"372"}]},{"pageId":"1","pageType":"TextPage","pageName":"About us","elements":[{"elementType":"ActiveImage","caption":"Another day2","src":"stamPic2.jpg","x":"50","y":"300","action":"PreviousPage"},{"elementType":"StaticText","id":"2","x":"50","y":"50","w":"500","h":"100","briefText":"Header on second page","fullText":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.. By the way. it could be a htmlText, so it is possible to include images and hyperlinks within in.. "},{"elementType":"Button","id":"5","caption":"Prev Page","x":"200","y":"350","action":"PreviousPage"},{"elementType":"Image","src":"pageBg2.png","x":"150","y":"50","w":"583","h":"372"}]},{"pageId":"2","pageType":"TextPage","pageName":"Stam","elements":[{"elementType":"ActiveImage","caption":"Another day 3","src":"stamPic.jpg","x":"0","y":"200","action":"GotoToPageId","actionParam":"0"},{"elementType":"StaticText","id":"2","x":"50","y":"50","w":"500","h":"100","briefText":"Header on third page","fullText":"By the way. it could be a htmlText, so it is possible to include images and hyperlinks within in.. ","src":"stamPic.jpg"}]},{"pageId":"3","pageType":"TextPage","pageName":"Stam","elements":[{"elementType":"StaticText","id":"2","x":"50","y":"200","w":"500","h":"100","briefText":"Header on third page","fullText":"By the way. it could be a htmlText, so it is possible to include images and hyperlinks within i htmlText, so it is possible to include images and hyperlinks within in.. "}]},{"pageType":"editor","elements":[{"elementType":"NavigationToolbar"},{"elementType":"PropertiesToolbar"}]},{"pageType":"template","templateName":"Simple template","elements":[{"elementType":"Button","caption":"Homepage","action":"GotoToPageId","x":"50","y":"400","actionParam":"0"},{"elementType":"Button","caption":"Page 1","action":"GotoToPageId","x":"150","y":"400","actionParam":"1"},{"elementType":"Button","caption":"page 2","action":"GotoToPageId","x":"300","y":"400","actionParam":"2"},{"elementType":"Button","caption":"page 2","action":"GotoToPageId","x":"450","y":"400","actionParam":"3"},{"elementType":"Image","src":"siteBg.jpg","x":"0","y":"15","w":"800","h":"485"},{"elementType":"Image","src":"logo.png","x":"25","y":"30","w":"120","h":"60"}]}]}';
			
			
			
			
	}
}