package 
{
	/**
	 * ...
	 * @author Fabio Flores
	 * 
	 * comentarios: Fabrica simple encargada de instanciar los diferentes tipos y niveles de balas usadas por el heroe
	 */
	public class FabricaBalasHeroe 
	{
		
		public static function fabricarBalaHeroe(pnivel:Number):BalaHeroe
		{
			var bala:BalaHeroe;
			switch(pnivel){
				case 1:
					bala = new DNivel1();
					break;
				case 2:
					bala = new DNivel2();
					break;
				case 3:
					bala = new DNivel3();
					break;
				default:
			}
			return bala;
		}
		
	}

}