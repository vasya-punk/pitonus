package Utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public function getVisibleBounds(target:DisplayObject, targetCoordinateSpace:DisplayObject):Rectangle {
		 
			var _bd:BitmapData;
			var _matrix:Matrix = new Matrix();
			var _rect:Rectangle = new Rectangle(0, 0, 2800, 2800);	
			
			if (_bd == null) {
				_bd = new BitmapData(2800, 2800, true, 0x00FFFFFF);
			}
			var msk:DisplayObject = target.mask;
			target.mask = null;
			_bd.fillRect(_rect, 0x00FFFFFF);
			_matrix.tx = _matrix.ty = 0;
			var offset:Rectangle = target.getBounds(targetCoordinateSpace);
			var m:Matrix = (targetCoordinateSpace == target) ? _matrix : target.transform.matrix;
			m.tx -= offset.x;
			m.ty -= offset.y;
			_bd.draw(target, m, null, "normal", _rect, false);
			var bounds:Rectangle = _bd.getColorBoundsRect(0xFF000000, 0x00000000, false);
			bounds.x += offset.x;
			bounds.y += offset.y;
			target.mask = msk;
			return bounds;
		
	}
}
