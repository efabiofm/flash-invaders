package 
{
	/**
	 * ...
	 * @author Rodrigo
	 */
	import org.flixel.*;
	[SWF(width="640",height="640",backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")] 
	 
	public class FlashInvaders extends FlxGame
	{
		
		public function FlashInvaders() 
		{
			super(640,640,MenuPrincipal);
			//forceDebugger = false;
		}
		
}

}