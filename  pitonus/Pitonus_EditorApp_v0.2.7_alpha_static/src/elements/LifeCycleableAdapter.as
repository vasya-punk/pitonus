package elements {
	
	import org.as3commons.ui.lifecycle.lifecycle.LifeCycleAdapter;

	public class LifeCycleableAdapter extends LifeCycleAdapter {
		
		override protected function onInit() : void {
			LifeCycleable(_component).init();
		}

		override protected function onDraw() : void {
			LifeCycleable(_component).draw();
		}

		override protected function onUpdate() : void {
			LifeCycleable(_component).update();
		}
	}
}