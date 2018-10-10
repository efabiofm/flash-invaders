package 
{
	/**
	 * Bala concreta del heroe, nivel 1
	 * @author Fabio Flores
	 */
	public class DNivel1 extends BalaHeroe
	{
		[Embed(source = "sounds/bala_normal.mp3")]
		private var balaN1Mp3:Class;

		public function DNivel1():void
		{
			super(-20, -20, -400, 1, null, balaN1Mp3);
			makeGraphic(4, 16, 0xFFFFFF00);
		}
		
	}

}