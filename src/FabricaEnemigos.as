package 
{
	/**
	 * ...
	 * @author Rodrigo
	 * 
	 * comentarios: Fabrica simple encargada de instanciar los enemigos
	 */
	public class FabricaEnemigos 
	{
		
		public static function fabricarEnemigo(tipo:Number, px:Number, py:Number, ptipoMovimiento:Number):Enemigo
		{
			var enemigo:Enemigo = null;
			
			if (tipo === 1)
			{
				enemigo = new FIEPequenho(px, py, ptipoMovimiento);
			} 
			else if (tipo === 2) 
			{
				enemigo = new FIEMediano(px, py, ptipoMovimiento);
			} 
			else if (tipo === 3) 
			{
				enemigo = new FIEGrande(px, py);
			}
			
			return enemigo;
		}
		
	}

}
