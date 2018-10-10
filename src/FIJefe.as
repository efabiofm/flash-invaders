package 
{
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class FIJefe extends Jefe
	{
		
		[Embed(source = "assets/FIJefe.png")]
		private var FIJefePNG:Class;
		
		public function FIJefe(px:Number, py:Number){
			super(px, py, 20, FIJefePNG, 1);
		}
		
	}
}