package 
{
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class FIEGrande extends Enemigo
	{
		
		[Embed(source="assets/FIEGrande.png")]
		private var FIEGrandePNG:Class
		
		public function FIEGrande(px:Number, py:Number) 
		{
			super(px, py, 3, 3, FIEGrandePNG, 1); //Este enemigo siempre deberia ir con un MovimientoLineal
			setVelocidad(12.5);
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}