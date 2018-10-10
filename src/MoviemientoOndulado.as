package 
{
	/**
	 * ...
	 * @author Rodrigo
	 * 
	 * una de las dos estrategias que pueden ser usadas por los enemigos para moverse
	 */
	public class MoviemientoOndulado implements IMovimientoEnemigo
	{
		
		public function mover(py:Number):Number
		{
			return ((Math.cos(py / 50) * 100)*0.75);
		}
		
	}

}