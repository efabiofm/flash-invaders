package 
{
	/**
	 * Bala concreta del heroe, nivel 3
	 * @author Fabio Flores
	 */
	public class DNivel3 extends BalaHeroe
	{
		[Embed(source="assets/DNivel3.png")]
		private var _balaN3Png:Class
		[Embed(source = "sounds/bala_l3.mp3")]
		private var balaN3Mp3:Class;
		
		public function DNivel3() 
		{
			super(-20, -20, -1000, 3, _balaN3Png, balaN3Mp3);
		}
		
	}

}