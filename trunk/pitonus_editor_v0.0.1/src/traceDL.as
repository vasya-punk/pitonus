/*---------------------------------------------------------------------------------------------

	[AS3] traceDL
	=======================================================================================

	Copyright (c) 2009 Tomek 'Og2t' Augustyn
	
	e	tomek@blog2t.net
	w	http://play.blog2t.net

	Please retain this info when redistributed.

	VERSION HISTORY:
	v0.1	30/4/2009	Initial concept
	v0.2	1/5/2009	Added more params, filter and depth
	
	USAGE:
	
	// displays the whole display list of any displayObject 
	traceDL(displayObject);
	
	// displays all displayObjects matching "filterString"
	traceDL(displayObject, "filterString");
	
	// displays the display list of any displayObject up to the given depth
	traceDL(displayObject, depth);

---------------------------------------------------------------------------------------------*/

package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	public function traceDL( d : DisplayObjectContainer, indent : String = '' ) : void{
            var i : int = 0;
            var o : * ;
            while( i < d.numChildren ){
                o = d.getChildAt( i );
                if( o is DisplayObjectContainer ){
                    // trace( o );
                    trace( indent + o.name );
                    traceDL( DisplayObjectContainer( o ), indent + '\t' );
                }
                else {
                    // trace( o );
                    trace( indent + o.name );
                }
                i ++ ;
            }
        }
}