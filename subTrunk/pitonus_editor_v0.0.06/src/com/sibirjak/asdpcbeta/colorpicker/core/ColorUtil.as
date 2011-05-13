/**
 * ActionScript Data Provider Controls
 * 
 * Copyright (c) 2010 Jens Struwe, http://www.sibirjak.com/
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.sibirjak.asdpcbeta.colorpicker.core {

	/**
	* @author jes 04.12.2009
	*/
	public class ColorUtil {

		public static function hexToString(hex : Number, addHash : Boolean = true) : String {
			var hexString : String = hex.toString(16);
			hexString = ("000000").substr(0, 6 - hexString.length) + hexString; 
			if (addHash) hexString = "#" + hexString; 
			return hexString.toUpperCase();
		}

		public static function hsbToRgb(h : Number, s : Number, br : Number) : Object {
			return hex2Rgb(hsb2Hex(h, s, br));
		}

		public static function rgb2Hsb(r : Number, g : Number, b : Number) : Object {
			return hex2Hsb(rgb2Hex(r, g, b));
		}

		public static function hex2Rgb(hex : Number) : Object {
			return {
				r : ( hex >> 16 ) & 0xFF,
				g : ( hex >> 8 ) & 0xFF,
				b : hex & 0xFF
			};
		}

		public static function rgb2Hex(r : Number, g : Number, b : Number) : Number {
			return (r << 16) | (g << 8) | b;
		}

		public static function hsb2Hex( h : Number, s : Number, br : Number ) : Number {
	
			var r : Number;
			var g : Number;
			var b : Number;
			var rgb : Number;
		
			if (!isNaN(s)) {
				s = (100 - s ) / 100;
				br = ( 100 - br ) / 100;
			}
		
			if ( ( h  > 300 && h <= 360 ) || ( h >= 0 && h <= 60 ) )  {
				r = 255;
				g = ( h / 60 ) * 255;
				b = ( ( 360 - h ) / 60 ) * 255;
			} else if ( h > 60 && h <= 180 )  {
				r = ( ( 120 - h ) / 60 ) * 255;
				g = 255;
				b = ( ( h - 120 ) / 60 ) * 255;
			} else  {
				r = ( ( h - 240 ) / 60 ) * 255;
				g = ( ( 240 - h ) / 60 ) * 255;
				b = 255;
			}
			
			if ( r > 255 || r < 0 ) r = 0;
			if ( g > 255 || g < 0 ) g = 0;
			if ( b > 255 || b < 0 ) b = 0;
			
			if (!isNaN(s)) {
				r += ( 255 - r ) * s;
				g += ( 255 - g ) * s;
				b += ( 255 - b ) * s;
				r -= r * br;
				g -= g * br;
				b -= b * br;
				r = Math.round( r );
				g = Math.round( g );
				b = Math.round( b );
			}
			rgb = b + ( g * 256 ) + ( r * 65536 );
			return rgb;
		}

		public static function hex2Hsb(hex : Number) : Object {
			var rgb : Object = hex2Rgb(hex);
			var r : Number = rgb["r"];
			var g : Number = rgb["g"];
			var b : Number = rgb["b"];

			var h : Number;
			var s : Number;
			var bri : Number;

			bri = Math.max(r, g, b);
			var min : Number = Math.min(r, g, b);

			s = ( bri <= 0 ) ? 0 : Math.round( 100 * ( bri - min ) / bri );

			bri = Math.round( ( bri / 255 ) * 100 );

			h = 0;
			if ( ( r == g ) && ( g == b ) )	{
				h = 0;
			} else if ( r >= g && g >= b ) {
				h = 60 * ( g - b ) / ( r - b );
			} else if ( g >= r && r >= b ) {
				h = 60 + 60 * ( g - r ) / ( g - b );
			} else if ( g >= b && b >= r ) {
				h = 120 + 60 * ( b - r ) / ( g - r );
			} else if ( b >= g && g >= r) {
				h = 180 + 60 * ( b - g ) / ( b - r );
			} else if ( b >= r && r >=  g ) {
				h = 240 + 60 * ( r - g ) / ( b - g );
			} else if ( r >= b && b >= g ) {
				h = 300 + 60 * ( r - b ) / ( r - g );
			} else {
				h = 0;
			}
			h = Math.round( h );

			return {h: h, s: s, b: b};
		}

	}
}
