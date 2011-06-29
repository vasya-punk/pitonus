package ui.tabs {


	import com.sibirjak.asdpc.textfield.Label;
	import com.sibirjak.asdpcbeta.selectbox.SelectBox;
	import elements.canvas.Canvas;

	import org.as3commons.ui.layout.debugger.LayoutDebugger;
	import org.as3commons.ui.layout.framework.IDisplay;
	import org.as3commons.ui.layout.framework.IDynTable;
	import org.as3commons.ui.layout.framework.IGroupLayout;
	import org.as3commons.ui.layout.framework.IHLayout;
	import org.as3commons.ui.layout.framework.ILayout;
	import org.as3commons.ui.layout.framework.IMultilineLayout;
	import org.as3commons.ui.layout.framework.ITable;
	import org.as3commons.ui.layout.framework.IVLayout;
	import org.as3commons.ui.layout.shortcut.hgroup;
	import org.as3commons.ui.layout.shortcut.hlayout;
	import org.as3commons.ui.layout.shortcut.vgroup;
	

	import flash.display.Sprite;

	/**
	 * @author Jens Struwe 29.03.2011
	 */
	public class PropertiesTab extends GenericTab {

		
		public function PropertiesTab(element:*, canvas:Canvas, receiver:* ) {
			
			super( element, canvas, receiver );		
	

			
			

			tabLayout = hlayout(
				"offsetX", 4,
				"offsetY", 8,
				"maxItemsPerRow", 2,
				"maxContentWidth", 150,
				"hGap", 8,
				"vGap", 4,
				
				headline("Properties", 150),
			
				label("Width:", -20),
				sliderWithLabel( {
					id: "widthSlider",
					width: 50,
					minValue: 50,
					maxValue: 800,
					value: element.w,
					snapInterval: 5,
					change: function( width : uint) : void {
						updateElement( "width", width );
					}
				}),

				label("Height:", -20),
				sliderWithLabel({
					width: 50,
					id: "heightSlider",
					minValue: 50,
					maxValue: 800,
					value: element.h,
					snapInterval: 5,
					change: function( height : uint) : void {
						updateElement( "height", height );
					}
				}),
			vgroup(
				"offsetX", 4,
				"offsetY", 15,
				"maxItemsPerRow", 2,
				"maxContentWidth", 150,
				"hGap", 8,
				"vGap", 4,
				
				dottedSeparator(144),

				headline("Properties2", 150)/*,
				
				label("Width:", -20),
				dropDownList( {
					id: "ddList",
					width: 50,

					snapInterval: 5,
					change: function( width : uint) : void {
						selectProperty( "width" );
					}
				})*/
			
			
			)
			);
			
			tabLayout.layout(this);
			
			
			
			
			
			
			
		}
		
	}

}