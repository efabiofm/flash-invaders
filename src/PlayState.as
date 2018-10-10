package 
{
	/**
	 * ...
	 * @author Rodrigo
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;

	public class PlayState extends FlxState
	{
		[Embed(source = "sounds/temaprincipal.mp3")]
		private var _temaPrincipal:Class;
		private var _starfield:StarfieldFX;
		private var _stars:FlxSprite;
		private var _heroe:Heroe;
		private var dificultadActual:Number;
		private var nivelActual:Nivel;
		private var grupoNiveles:FlxGroup;
		private var _barraEstado:BarraEstado;
		private const LIMITE_HORIZONTAL:Number = 610;
		private const LIMITE_VERTICAL:Number = 0;
		private var puntajeActual: FlxText;
		private var pluginStars:FlxSpecialFX;
		private var nivelTxt:FlxText;
		private var puntosHeroe:Number;
		
		
		public function PlayState()
		{

			FlxG.playMusic(_temaPrincipal, 1);

			pluginStars = new FlxSpecialFX();
			if ( FlxG.getPlugin( FlxSpecialFX ) == null )
			{
				FlxG.addPlugin(pluginStars);
			}
			
			_starfield = FlxSpecialFX.starfield();
			_stars = _starfield.create( 0, 0, FlxG.width, FlxG.height, 200, StarfieldFX.STARFIELD_TYPE_2D );
			_starfield.setStarSpeed( 0, 0.5 );
				
			add( _stars );
			
			dificultadActual = 1;
			nivelActual = new Nivel(dificultadActual);
			_heroe = FIHeroe.getInstance();
			grupoNiveles = new FlxGroup();
			add(nivelActual.devolverObj());
			add(_heroe.devolverObjeto());
			
			puntosHeroe = _heroe.getPuntos();
			var puntos: String = "Puntaje Actual :" +  puntosHeroe
			puntajeActual = new FlxText(10, 10, 320, puntos);
			puntajeActual.setFormat(null, 15, 0xFFFFFF, "center");
			add(puntajeActual);
			
			var nivel: String = "Nivel :" +  nivelActual.getDificultadNivel();
			nivelTxt = new FlxText(150, 10, 320, nivel);
			nivelTxt.setFormat(null, 15, 0xFFFFFF, "center");
			add(nivelTxt);
			
			_barraEstado = new BarraEstado();
			add(_barraEstado);
			
		}

		override public function update():void
		{
			//Muestra el puntaje actual del heroe
			puntosHeroe = _heroe.getPuntos();
			puntajeActual.text = "Puntaje Actual :" +  puntosHeroe;
			nivelTxt.text= "Nivel :" + nivelActual.getDificultadNivel();
			add(grupoNiveles);
			
			if (nivelActual.getNivelTerminado())
			{
				dificultadActual++;
				var nivelNuevo:Nivel = new Nivel(dificultadActual);
				add(nivelNuevo.devolverObj());
				nivelActual = nivelNuevo;
			}
			
			if (nivelActual.returnEstadoHeroe() == false){
				FlxG.music.stop();
				remove(_stars);
				FlxG.removePlugin(pluginStars);
				_starfield.destroy();
				FlxG.switchState(new Perder(puntosHeroe, nivelActual.getDificultadNivel()));
			}
			
			_barraEstado.modificar(_heroe.getVida());
			_barraEstado.setTextoCantBombas(_heroe.getCantBombas());
			
			//evitar que el jugador se salga de la pantalla
			if(_heroe.x < LIMITE_VERTICAL){
				_heroe.x = LIMITE_VERTICAL;
			}
			if(_heroe.x > LIMITE_HORIZONTAL){
				_heroe.x = LIMITE_HORIZONTAL;
			}
			if(_heroe.y < LIMITE_VERTICAL){
				_heroe.y = LIMITE_VERTICAL;
			}
			if(_heroe.y > LIMITE_HORIZONTAL){
				_heroe.y = LIMITE_HORIZONTAL;
			}
			super.update();
		}
	}
}
