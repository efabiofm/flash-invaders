package 
{
	/**
	 * Item que aumenta en una unidad la vida del heroe
	 * @author Fabio Flores
	 */
	public class POVida extends FIFItem
	{
		[Embed(source = "assets/ItemVida.png")]
		private var itemPNG:Class
		
		public function POVida(x:Number, y:Number) 
		{
			super(x, y, itemPNG);
		}
		
		override public function activarEfecto():void{
			super.activarEfecto();
			var heroe:Heroe = FIHeroe.getInstance();
			heroe.velocity.y = 0;
			heroe.aumentarVida();
		}
		
	}

}