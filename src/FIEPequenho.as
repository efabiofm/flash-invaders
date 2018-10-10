package 
{
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class FIEPequenho extends Enemigo
	{
		
		[Embed(source="assets/FIEPequenho.png")]
		private var FIEPequenhoPNG:Class
		
		public function FIEPequenho(px:Number, py:Number, ptipoMovimiento:Number) 
		{
			super(px, py, 1, 1, FIEPequenhoPNG, ptipoMovimiento);
			setVelocidad(25);
		}
	}

}