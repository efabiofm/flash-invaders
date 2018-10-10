package 
{
	/**
	 * ...
	 * @author Fabio Flores
	 * 
	 * comentarios: Fabrica simple encargada de instanciar los items que apareceran en pantalla
	 */
	public class FabricaItems
	{
		private var _velocidad:Number;
		
		public static function fabricarItem(ptipo:Number, px:Number, py:Number):FIFItem 
		{
			var item:FIFItem;
			switch(ptipo){
				case 1:
					item = new POVida(px, py);
					break;
				case 2:
					item = new POVelocidad(px, py);
					break;
				case 3:
					item = new PODisparo(px, py);
					break;
				default:
			}
			return item;
		}
		
	}

}