package 
{
	/**
	 * Bala concreta del heroe, nivel 2
	 * @author Fabio Flores
	 */
	public class DNivel2 extends BalaHeroe
	{
		[Embed(source="assets/DNivel2.png")]
		private var _balaN2Png:Class
		[Embed(source = "sounds/bala_l2.mp3")]
		private var _balaN2Mp3:Class;
		
		public function DNivel2() 
		{
			super(-20, -20, -600, 2, _balaN2Png, _balaN2Mp3);
		}
		
	}

}