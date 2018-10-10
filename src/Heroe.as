package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * Clase de nave principal que hereda de la clase abstracta Heroe
	 * @author Fabio Flores
	 */
	public class Heroe extends Personaje
	{
		private var _cantBombas:Number;
		private var _nivelDisparo:Number;
		protected static var instance:Heroe;
		private var _balasHeroe:Array;
		private var _grupoBalasHeroe:FlxGroup;
		private var _indiceBala:int = 0;
		private const NIVEL_DISPARO_MAXIMO:Number = 3;
		private const MAXIMO_NIVEL_VIDA:Number = 5;
		private var _bombas:FlxGroup;
		private var _puntos:Number = 0;
		
		public function Heroe(px:Number, py:Number, pnivelDisparo:Number, pcantBombas:Number, pvida:Number) 
		{
			//Patrón SINGLETON: Solo se permite una instancia durante todo el tiempo de vida del programa
			if(instance === null){
				super(px, py, pvida);
				addAnimation("explotar", [1, 2, 3, 4, 5], 15, false); //se activa heroe.play("explotar");
				addAnimationCallback(onExplotionAnimation);
				setNivelDisparo(pnivelDisparo);
				setCantBombas(pcantBombas);
				setGrupoBalasHeroe(new FlxGroup(10));
				var bala:BalaHeroe;
				for (var i:int = 0; i < 10; i++){
					bala = FabricaBalasHeroe.fabricarBalaHeroe(_nivelDisparo);
					_grupoBalasHeroe.add(bala);
				}
				setBalasHeroe(_grupoBalasHeroe.members);
				setBombas(new FlxGroup());
			} else {
				throw new Error("No se permite crear otra instancia de Heroe, utilice Heroe.getInstance()");
			}
		}
		
		public function getCantBombas():Number{
			return _cantBombas;
		}
		
		public function setCantBombas(value:Number):void{
			_cantBombas = value;
		}
		
		public function getNivelDisparo():Number{
			return _nivelDisparo;
		}
		
		public function setNivelDisparo(value:Number):void{
			_nivelDisparo = value;
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.W || FlxG.keys.UP)
			{
				y -= getVelocidad();
			}
			if (FlxG.keys.S || FlxG.keys.DOWN)
			{
				y += getVelocidad();
			}
			if (FlxG.keys.A || FlxG.keys.LEFT)
			{
				x -= getVelocidad();
			}
			if (FlxG.keys.D || FlxG.keys.RIGHT)
			{
				x += getVelocidad();
			}
			if (FlxG.keys.justPressed("SPACE"))
			{
				disparar();
			}
			if (FlxG.keys.justPressed("B"))
			{
				dispararBomba();
			}
		}
		
		public function getBalasHeroe():Array{
			return _balasHeroe;
		}
		
		public function setBalasHeroe(value:Array):void{
			_balasHeroe = value;
		}
		
		//reutiliza las balas que estan dentro del array _balasHeroe
		public function disparar():void{
			var p:FlxPoint;
			try {
				if (_indiceBala >= 10){
				_indiceBala = 0;
				}
				var balaActual:BalaHeroe = _balasHeroe[_indiceBala];
				balaActual.sonar();
				p = new FlxPoint(this.x + width / 2 - balaActual.width / 2, this.y - balaActual.height / 2);
				balaActual.reset(p.x,  p.y);
				_indiceBala++;
			} catch(e:Error) {
				trace("Error al cargar nuevas balas");
			}
		}
		
		public function getGrupoBalasHeroe():FlxGroup{
			return _grupoBalasHeroe;
		}
		
		public function setGrupoBalasHeroe(value:FlxGroup):void {
			_grupoBalasHeroe = value;
		}
		
		public function aumentarNivelDisparo():void{
			if (_nivelDisparo < NIVEL_DISPARO_MAXIMO){
				setNivelDisparo(getNivelDisparo() + 1);
				for (var i:int = 0; i < 10; i++){
					_grupoBalasHeroe.remove(_balasHeroe[i], false);
					var bala:BalaHeroe = FabricaBalasHeroe.fabricarBalaHeroe(_nivelDisparo);
					_grupoBalasHeroe.add(bala);
				}
			}
		}
		
		public function reducirNivelDisparo():void{
			if (_nivelDisparo > 1){
				setNivelDisparo(getNivelDisparo() - 1);
				for (var i:int = 0; i < 10; i++){
					_grupoBalasHeroe.remove(_balasHeroe[i], false);
					var bala:BalaHeroe = FabricaBalasHeroe.fabricarBalaHeroe(_nivelDisparo);
					_grupoBalasHeroe.add(bala);
				}
			}
		}
		
		public function aumentarVida():void{
			if(getVida() < MAXIMO_NIVEL_VIDA){
				setVida(getVida() + 1);
			}
		}
		
		public function reducirVida(pdano:Number):void{
			this.velocity.y = 0;
			reducirNivelDisparo();
			setVida(getVida() - pdano);
			if (getVida() <= 0){
				this.play("explotar");
			}
		}
		
		private function onExplotionAnimation(name:String, frame:uint, index:uint):void{
			setVida(0);
			if (index === 5){
				kill();
			}
		}

		public function restaurarVelocidad():void{
			setVelocidad(3);
		}
		
		public function devolverObjeto():FlxGroup{
			var nuevoGroup:FlxGroup = new FlxGroup();
			nuevoGroup.add(this);
			nuevoGroup.add(_grupoBalasHeroe);
			nuevoGroup.add(_bombas);
			return nuevoGroup;
		}
		
		private function dispararBomba():void{
			if ( getCantBombas() > 0 ) {
				setCantBombas(getCantBombas() - 1);
				var p:FlxPoint = new FlxPoint(this.x + width / 2 - 6,  this.y);
				var nuevaBomba:Bomba = new Bomba(p.x, p.y);
				nuevaBomba.sonar();
				_bombas.add(nuevaBomba);
			}
		}
		
		public function getBombas():FlxGroup{
			return _bombas;
		}
		
		public function setBombas(pbombas:FlxGroup):void{
			_bombas = pbombas;
		}
		
		public function getPuntos():int{
			return _puntos;
		}
		
		public function setPuntos(ppuntos:int):void{
			_puntos = ppuntos;
		}
		
		public function getInstance():Heroe{
			return Heroe.instance;
		}
	}

}
