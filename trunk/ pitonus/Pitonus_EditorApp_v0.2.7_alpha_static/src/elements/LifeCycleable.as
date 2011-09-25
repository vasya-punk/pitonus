package elements 
{
	import flash.display.Sprite;
	import org.as3commons.ui.lifecycle.lifecycle.LifeCycleAdapter;
	import managers.*;

	public class LifeCycleable extends Sprite// LayoutObject 
	{
		protected  	var _lcAdapter 				: LifeCycleAdapter;
		
		public function LifeCycleable() {
			_lcAdapter = new LifeCycleableAdapter();
			LifeCycleManager.registerComponent(this, _lcAdapter);

		}
		
		// should be called after Element's property changed and draw or update is needed
		public function invalidate() : void {
			//trace("LifeCycleable.invalidate");
			_lcAdapter.invalidate();
		}
		
		public function validateNow() : void {
			//trace("LifeCycleable.validateNow");
			_lcAdapter.validateNow();
		}
		
		//============================= Abstract functions  ===================================
		
		public function init():void {
			validateNow();
		}

		// called by LifeCycle after init() or by _lcAdapter.validateNow(); called ??
		public function draw() : void {
			trace ( "LifeCycleable.draw()");
		}
		
		// called by LifeCycle after Element propety was changed by _lcAdapter.invalidate(); called
		public function update() : void {
			trace ( "LifeCycleable.update()");
		}
	}

}