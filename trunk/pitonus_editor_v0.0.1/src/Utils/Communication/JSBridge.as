package Utils.Communication 
{

	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import Utils.*;

	


	
	public class JSBridge extends EventDispatcher
	{
		
		public function JSBridge(){
			if(ExternalInterface.available){
					callJs("JsPitReady", "Flash > Ready");	
					//wait for call from javascript
					ExternalInterface.addCallback("pitTrace", 	pitTrace);
					ExternalInterface.addCallback("pitLoad", 	pitLoad);
					ExternalInterface.addCallback("pitAdd",	 	pitAddElements);
			}else {
				trace("[Fault] ExternalInterface is not available. ExternalInterface requires browser that support NPRuntime");	
			}
		}
		
		public	function pitAddElements(elements:String):void {
				trace(elements);
		}
			
		public	function pitLoad(  str:String ):void {		
			dispatchEvent( new JSBridgeEvent( JSBridgeEvent.STRUCTURE_RECIEVED, str ) );
		}
			
		public	function pitTrace(  str:String):void {
			trace(str);
		}	
		
		public function callJs(func:String, param:String):void {	
			if(ExternalInterface.available){
				ExternalInterface.call( func, param );
			}else{
				trace("[Fault] ExternalInterface is not available. ExternalInterface requires browser that support NPRuntime");
			}

		}

	}

}