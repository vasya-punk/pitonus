package layout.general {
	import com.sibirjak.asdpcbeta.layout.VLayout;
	import layout.common.box.Box;
	import org.as3commons.ui.layout.HGroup;
	import flash.display.Sprite;
		import org.as3commons.ui.layout.*;
	import org.as3commons.ui.layout.shortcut.*;

	public class AddingItems extends Sprite {
		public function AddingItems() {
			var layout : HGroup = new HGroup();
			layout.add(new Box());
			layout.add(new Box(), new Box(), new Box());
			layout.add(Box.create(3)); // Array
			layout.add(vgroup(
					"id", "vgroup",
					Box.create(2)
				) );
			layout.add(new Box(), Box.create(2));
			layout.layout(this);
		}
	}
}