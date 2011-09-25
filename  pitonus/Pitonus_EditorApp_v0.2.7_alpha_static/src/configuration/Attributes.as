package  configuration
{

	public class Attributes 
	{
		public static const LIST:String 			= "listAttribute";
		public static const TEXT_AREA:String 		= "textAreaAttribute";
		public static const INPUT:String 			= "inputAttribute";
		public static const NUMBER:String 			= "numberAttribute";
		public static const UPLOAD:String			= "uploadAttribute";
		public static const BOOLEAN:String			= "booleanAttribute";	
		public static const SYSTEM:String			= "systemValue";	
		
	
		public static const DEFAULT_EDITABLE_PROPERTIES:Object = {
				"elementType" 	: Attributes.LIST,
				"name"			: Attributes.INPUT,
				"w"				: Attributes.NUMBER,
				"h"				: Attributes.NUMBER,
				"action"		: Attributes.LIST,
				"actionParam"	: Attributes.LIST,
				"marginX"		: Attributes.NUMBER,
				"marginY"		: Attributes.NUMBER,
				"inline"		: Attributes.BOOLEAN
		};
		
				
		public static const MARKUP_LAYOUT_INLINE_VERTICAL:String 	= "inlineV";
		public static const MARKUP_LAYOUT_INLINE_HORIZONTAL:String 	= "inlineH";
		public static const MARKUP_LAYOUT_ABSOLUTE:String 	= "absolute";
	}
}
