package 
{
	/**
	 * Item que aumenta el nivel de disparo del heroe
	 * @author Fabio Flores
	 */
	public class PODisparo extends FIFItem
	{
		[Embed(source = "assets/ItemDisparo.png")]
		private var itemPNG:Class
		
		public function PODisparo(x:Number, y:Number) 
		{
			super(x, y, itemPNG);
		}
		
		override public function activarEfecto():void{
			super.activarEfecto();
			var heroe:Heroe = FIHeroe.getInstance();
			heroe.velocity.y = 0;
			heroe.aumentarNivelDisparo();
		}
		
	}

}