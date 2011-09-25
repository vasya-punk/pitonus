package managers.utils
{

	import elements.*;
	import elements.activeimage.*;
	import elements.image.*;
	import elements.canvas.*;
	import elements.textblock.*;
	import elements.textbutton.*;
	import elements.input.*;
	import elements.sitemenu.*;
	import elements.dropdownlist.*;
	import elements.iconsbar.*;
	
	import utils.*;

	import flash.utils.getQualifiedClassName;
	
	public function prepairInternalElementClasses( classes:* = null ):Object 		{	
			
			if(!classes){
		
				var aviableClasses:Object = new Object();
				
				aviableClasses['fileNames'] = new Array();
				aviableClasses['names'] = new Array();
				aviableClasses['qualifiedNames'] = new Array();
				aviableClasses['runtimeClassRefs'] = new Array();

				aviableClasses['fileNames'][0] = Config.ELEMENTS_CLASSES_PATH + "Canvas.swf"		
				aviableClasses['names'][0] = "Canvas";
				aviableClasses['qualifiedNames'][0] = "elements.canvas::Canvas";
				aviableClasses['runtimeClassRefs'][0] = getClass(Canvas);
				
				aviableClasses['fileNames'][1] = Config.ELEMENTS_CLASSES_PATH + "ActiveImage.swf"		
				aviableClasses['names'][1] = 	"ActiveImage";
				aviableClasses['qualifiedNames'][1] = 	"elements.activeimage::ActiveImage";
				aviableClasses['runtimeClassRefs'][1] = getClass(ActiveImage);

				aviableClasses['fileNames'][2] = Config.ELEMENTS_CLASSES_PATH + "Image.swf"		
				aviableClasses['names'][2] = "Image";
				aviableClasses['qualifiedNames'][2] = "elements.image::Image";
				aviableClasses['runtimeClassRefs'][2] = getClass(Image);
				
				aviableClasses['fileNames'][3] = Config.ELEMENTS_CLASSES_PATH + "TextBlock.swf"		
				aviableClasses['names'][3] = "TextBlock";
				aviableClasses['qualifiedNames'][3] = "elements.textblock::TextBlock";
				aviableClasses['runtimeClassRefs'][3] = getClass(TextBlock);
				
				aviableClasses['fileNames'][4] = Config.ELEMENTS_CLASSES_PATH + "TextButton.swf"		
				aviableClasses['names'][4] = "TextButton";
				aviableClasses['qualifiedNames'][4] = "elements.textbutton::TextButton";
				aviableClasses['runtimeClassRefs'][4] = getClass(TextButton);
				
				aviableClasses['fileNames'][5] = Config.ELEMENTS_CLASSES_PATH + "DropDownList.swf"		
				aviableClasses['names'][5] = "DropDownList";
				aviableClasses['qualifiedNames'][5] = "elements.dropdownlist::DropDownList";
				aviableClasses['runtimeClassRefs'][5] = getClass(DropDownList);
				
				aviableClasses['fileNames'][6] = Config.ELEMENTS_CLASSES_PATH + "Input.swf"		
				aviableClasses['names'][6] = "Input";
				aviableClasses['qualifiedNames'][6] = "elements.input::Input";
				aviableClasses['runtimeClassRefs'][6] = getClass(Input);
				
				aviableClasses['fileNames'][7] = Config.ELEMENTS_CLASSES_PATH + "SiteMenu.swf"		
				aviableClasses['names'][7] = "SiteMenu";
				aviableClasses['qualifiedNames'][7] = "elements.sitemenu::SiteMenu";
				aviableClasses['runtimeClassRefs'][7] = getClass(SiteMenu);
				
				aviableClasses['fileNames'][8] = Config.ELEMENTS_CLASSES_PATH + "IconsBar.swf"		
				aviableClasses['names'][8] = "IconsBar";
				aviableClasses['qualifiedNames'][8] = "elements.iconsbar::IconsBar";
				aviableClasses['runtimeClassRefs'][8] = getClass(IconsBar);
				
				aviableClasses['fileNames'][9] = Config.ELEMENTS_CLASSES_PATH + "Background.swf"		
				aviableClasses['names'][9] = "Background";
				aviableClasses['qualifiedNames'][9] = "elements.image::Background";
				aviableClasses['runtimeClassRefs'][9] = getClass(Background);
				
			
				return aviableClasses;
			}else {
				trace("[PrepairClasses] Stop process... Not Ready Yet");
				return null;
			}
		}
		
		
	
}