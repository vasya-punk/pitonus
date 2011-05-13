package Configuration 
{

	public class DummyObject  
	{
		public var elementType:String;
		public var caption:String;
		public var src:String;
		public var w:String;
		public var h:String;
		public var x:String;
		public var y:String;
		public var label:String;
		public var value:String;
		public var element:*;
		public var values:Array;
		private var otherVars:Object;
		
		public function DummyObject( optionalVars:Object = null ) {
			
			this['elementType']  = 'Dummy';
			this['caption'] = "New Element";
			this['src']  = "invalid.url";

			
			this['w']  = '100';
			this['h'] = '100';
			this['x']  = '0';
			this['y']  = '0';
			this['element']  = null;

			if ( optionalVars ) {
				for (var prop:String in optionalVars){
					try{
						this[prop] = optionalVars[prop];
					}catch (error:Error){
						trace('[error]\nthrow new Error("Unknown property: " + prop);');
						if (!otherVars)
							otherVars = new Object();
						otherVars[prop] = optionalVars[prop];
					}
				}
			}
	
		}
		
		public function get dummy():Object {
			if (otherVars){
				for (var prop:String in this) {
					otherVars[prop] = this[prop];
				}
				return otherVars;
			}
			else
				return this;
		} 
		
	}

}


