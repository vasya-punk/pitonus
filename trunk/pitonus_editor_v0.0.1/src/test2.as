package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import com.greensock. * ;
    import Utils.SimpleEvent;
    import flash.events.Event;

    import org.as3commons.ui.layout.HGroup;
    /* *
    * ...
    * @author Metaform ( c ) Interactive
    */
    public class test2  extends Sprite
    {

        public function test2()
        {
			
			var papaElement : Sprite = new Sprite ();
			addChild(papaElement);

            var element1 : tester = new tester();
            var element2 : tester = new tester();
            var element3 : tester = new tester();

            element1.name = "element1";
            element2.name = "element2";
            element3.name = "element3";

            with ( element1.graphics ) {
                beginFill( 0xDDDDDD , 0.5 );
                drawRect( 10, 10, 80, 80 );
            }

            with ( element2.graphics ) {
                beginFill( 0xD3DDDD , 0.5 );
                drawRect( 50, 50, 120, 120 );
            }

            with ( element3.graphics ) {
                beginFill( 0xD31DDD , 0.5 );
                drawRect( 100, 100, 180, 180 );
            }



            element2.addChild( element3 );
            element1.addChild( element2 );
            papaElement.addChild( element1 );


            this.addEventListener( MouseEvent.MOUSE_DOWN, func2 );

            // element3.addEventListener( SimpleEvent.SIMPLE_EVENT, func1 );
            // element1.addEventListener( SimpleEvent.SIMPLE_EVENT, func1 );
            //this.addEventListener( SimpleEvent.SIMPLE_EVENT, func1 );

            this.addEventListener( SimpleEvent.SIMPLE_EVENT, func1 );
			element1.addEventListener( SimpleEvent.SIMPLE_EVENT, func1 );

            function func1( e : SimpleEvent ) : void {
				e.stopPropagation();
                trace( ">>> " + e.data );
            }

            function func2( e : MouseEvent ) : void {
                trace( ">>> " + e + " " + e.currentTarget.name + " : " + e.target.name /* + " id: " + e.target.id */ );
            }




                       var layout : HGroup = new HGroup();

            layout.add( element1 );
            layout.add( element2 );
            layout.add( element3 );

            layout.layout( this );
           
			trace("papaElement: " + papaElement.numChildren + " " + layout.numItems);
			
			this.removeChild(element2);
			
			
            trace( "\n" );
            traceDL( this );
            trace( "\n" );

			
/*			var dispatcher : CustomDispatcher = new CustomDispatcher();
			dispatcher.addEventListener( CustomDispatcher.ACTION, actionHandler );
			dispatcher.doAction();*/

        }

    
		
   
	private function actionHandler( event : Event ) : void {
            trace( "actionHandler: " + event );
    }


       
    }

}

//  ---------------------------------------

import flash.display.Sprite;
import com.greensock. * ;
import Utils.SimpleEvent;

class tester extends Sprite	{
    public static var id : uint = 0;
	public var deny:Boolean = false;
    public function tester() {
        id ++ ;
        TweenLite.delayedCall( 0.5, func );
    }
    private function func() : void {
        // trace( "dispatchEvent: " + this.name );
		if(name == "element3")
			dispatchEvent( new SimpleEvent( SimpleEvent.SIMPLE_EVENT , "form " + name ) );
	}

}

//  ---------------------------------------




import flash.events.EventDispatcher;
import flash.events.Event;

class CustomDispatcher extends EventDispatcher {
    public static var ACTION : String = "action";

    public function doAction() : void {
        dispatchEvent( new Event( CustomDispatcher.ACTION ) );
    }
}