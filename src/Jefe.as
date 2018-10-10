package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class Jefe extends Personaje
	{
		[Embed(source = "sounds/explosion_jefe.mp3")]
		private var sonidoMorir:Class;
		private var intervaloDisparos:Number;
		private var contadorTiempo:Number;
		private var posibilidadDisparo:Number;
		private var balasEnemigas:FlxGroup;
		private var salio:Boolean;
		private var danho:Number;
		private var heroe:Heroe;
		private var velX:Number;
		private var velY:Number;
		
		public function Jefe(px:Number, py:Number, pv:Number, pPNG:Class, pdanho:Number) 
		{
			super(px, py, pv);
			loadGraphic(pPNG, true, false, 129, 129);
			addAnimation("explotar", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 15, false);
			addAnimationCallback(onExplotionAnimation);
			velX = 0;
			velY = 50;
			
			intervaloDisparos = 1;
			posibilidadDisparo = 70;
			balasEnemigas = new FlxGroup();
			salio = false;
			danho = pdanho;
			heroe = FIHeroe.getInstance();
			
			addAnimation("explotar", [1, 2, 3], 15, false);
			addAnimationCallback(onExplotionAnimation);
			
			reiniciarContador();
		}
		
		
		public function getBalasJefe():FlxGroup
		{
			return balasEnemigas;
		}
		
		private function recibirBomba(pjefe:Jefe, pbombas:Bomba):void{
			pbombas.explotar();
			this.setVida(this.getVida() - (pbombas as Bomba).getDano());
			if (this.getVida() < 1 ) {
				FlxG.play(sonidoMorir);
				this.play("explotar");
			}
		}
		
		private function getPosicionDelCanhon1():FlxPoint
		{
			var p: FlxPoint = new FlxPoint(x + ((this.width/4)/2), y + (this.height));
			return p;
		}
		
		private function getPosicionDelCanhon2():FlxPoint
		{
			var p: FlxPoint = new FlxPoint(x + (((this.width/4)/2)*3), y + (this.height));
			return p;
		}
		
		private function getPosicionDelCanhon3():FlxPoint
		{
			var p: FlxPoint = new FlxPoint(x + (((this.width/4)/2)*5), y + (this.height));
			return p;
		}
		
		private function getPosicionDelCanhon4():FlxPoint
		{
			var p: FlxPoint = new FlxPoint(x + (((this.width/4)/2)*7), y + (this.height));
			return p;
		}
		
		private function dispararCanhon(p: FlxPoint):void
		{
			var balaEnemiga:BalaEnemiga = new BalaEnemiga(p.x, p.y, this.danho);
			balasEnemigas.add(balaEnemiga);
		}
		
		private function numAleatorioEntreRangos(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		private function disparar():void
		{
			var rollPosibilidadDisparo:Number = Math.ceil(Math.random() * 100);
			if (rollPosibilidadDisparo <= posibilidadDisparo)
			{
				dispararCanhon(getPosicionDelCanhon1());
				dispararCanhon(getPosicionDelCanhon2());
				dispararCanhon(getPosicionDelCanhon3());
				dispararCanhon(getPosicionDelCanhon4());
			}
		}
		
		private function onExplotionAnimation(pAnimacion:String, pFrameNumber:uint, pFrameIndex:uint):void{
			if (pFrameIndex == 14){
				heroe.setPuntos(10);
				this.kill();
			}
		}
		
		private function recibirDanho(pJefe:Jefe, pbalasHeroe:FlxSprite):void
		{
			pbalasHeroe.kill();
			this.setVida(this.getVida() - (pbalasHeroe as BalaHeroe).getDano());
			if (this.getVida() < 1 ) {
				FlxG.play(sonidoMorir);
				this.play("explotar");
			}
		}
		
		private function choqueConHeroe(pJefe:Jefe, heroe:FIHeroe):void
		{
			this.setVida(this.getVida() - 1);
			heroe.play("explotar");
		}
		
		private function reiniciarContador():void
		{
			contadorTiempo = intervaloDisparos;
		}
		
		override public function update():void
		{
			velocity.y = velY;
			velocity.x = velX;
			contadorTiempo -= FlxG.elapsed;
			
			if (this.y >= 0 && salio != true)
			{
				velY = 0;
				velX = 50;
				salio = true;
			}
			
			if (this.x <= 129)
			{
				velX = (numAleatorioEntreRangos(30, 60));
			}
			
			if (this.x >= 511)
			{
				velX = -(numAleatorioEntreRangos(30, 60));
			}
			
			if (salio)
			{
				y = 0;
			}
			
			if(contadorTiempo < 0)
			{
				disparar();
				reiniciarContador();
			}
			
			FlxG.collide(this, heroe.getGrupoBalasHeroe(), recibirDanho);
			FlxG.collide(this, heroe, choqueConHeroe);
			FlxG.collide(this, heroe.getBombas(), recibirBomba);
			FlxG.collide(this.getBalasJefe(), heroe.getGrupoBalasHeroe(), destruirBalasHeroeJefe);
			
			super.update();
			
		}
		
		private function destruirBalasHeroeJefe(pbalasJefe:FlxSprite, pbalasHeroe:FlxSprite):void {
			pbalasHeroe.kill();
			pbalasJefe.kill();
		}
		
		public function devolverObj():FlxGroup 
		{
			var obj:FlxGroup = new FlxGroup();
			obj.add(this);
			obj.add(balasEnemigas);
			return obj;
		}
	}

}
