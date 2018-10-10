package 
{
	/**
	 * ...
	 * @author Rodrigo
	 * 
	 * comentarios: Fabrica simple encargada de instanciar la estrategia correcta a usar por el enemigo
	 */
	public class FabricaMovimientosEnemigos 
	{
		
		public static function fabricarEstrategiaMovimiento(ptipo:Number):IMovimientoEnemigo 
		{
			var resul:IMovimientoEnemigo = null;
			
			if (ptipo === 1)
			{
				resul = new MovimientoLineal();
			} 
			else if (ptipo === 2)
			{
				resul = new MoviemientoOndulado();
			}
			
			return resul;
		}
		
	}

}