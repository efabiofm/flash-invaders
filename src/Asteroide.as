package 
{
	/**
	 * ...
	 * @author Achio
	 */
	public class Asteroide extends Obstaculo
	{
		[Embed(source = "assets/Asteroide2.png")]
		private var AsteroidePNG:Class;
		
		public function Asteroide(x:Number, y:Number) 
		{
			super(x, y, AsteroidePNG, 100, 30, 30);
			addAnimation("explotar", [1, 2, 3, 4, 5], 15, false);
			addAnimationCallback(onExplotionAnimation);
			
		}
				
		private function onExplotionAnimation(name:String, frame:uint, index:uint):void{
			if (index === 5){
				kill();
			}
		}
	}

}