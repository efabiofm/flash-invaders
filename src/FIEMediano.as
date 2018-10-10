package 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class FIEMediano extends Enemigo
	{
		
		[Embed(source="assets/FIEMediano.png")]
		private var FIEMedianoPNG:Class
		
		public function FIEMediano(px:Number, py:Number, ptipoMovimiento:Number) 
		{
			super(px, py, 2, 2, FIEMedianoPNG, ptipoMovimiento);
			setVelocidad(20);
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}