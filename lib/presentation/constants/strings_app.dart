
import 'package:gremio_de_historias/presentation/constants/constants_app.dart';

class StringsApp{

  //Titulos de pantallas
  static const String JUEGOS_PRESTADOS = "Juegos prestados";
  static const String SELECCIONE_JUEGO = "Seleccione el juego";
  static const String SELECCIONE_MIEMBRO = "Seleccione el miembro";
  static const String DETALLE = "Detalle";
  static const String JUEGOS_DISPONIBLES = "Juegos Disponibles";
  static const String DEVOLVER_JUEGO = "Devolver Juego";
  static const String ASOCACION_CULTURAL = "Asociación cultural";

  //Error
  static const String ERROR_GUARDAR_JUEGOS = "Error al guardar los juegos que se prestan";
  static const String ERROR_OBTENER_JUEGOS_POR_USUARIO = "Error al obtener los juegos en poder del usuario";
  static const String ERROR_OBTENER_TODOS_JUEGOS = "Error al obtener todos los juegos de la BD";
  static const String ERROR_SELECCION_AL_MENOS_UN_JUEGO = "Elija al menos un juego";
  static const String ERROR_RETIRAS_MAS_DE_UN_JUEGO = "No puedes retirar mas de ${ConstantsApp.ALLOWED_GAMES_IN_HOUSE} juegos";
  static const String ERROR_MAS_DE_UN_JUEGO_EN_CASA = "No puedes tener más de ${ConstantsApp.ALLOWED_GAMES_IN_HOUSE} juegos en tu poder";
  static const String ERROR_OBTENER_MIEMBROS = "Error al obtener los usuarios";
  static const String ERROR_DEVOLVER_JUEGO = "Error al devolver el juego";
  static const String ERROR_CARGAR_JUEGO_IPHONE = "Error al cargar los juegos prestados en pantalla de iphone";
  static const String ERROR_CREDENCIALES_INCORRECTAS = "Credenciales incorrectas";
  static const String ERROR_FIREBASE = "Error con el logueo la base de datos";
  static const String CAMPO_OBLIGATORIO = "Campo obligatorio";

  //Varios
  static const String NO_HAY_JUEGOS_PARA_DEVOLVER = "No tienes juegos en tu poder para devolver";
  static const String JUEGO_RETIRADO = "Juego retirado correctamente";
  static const String USER = "Usuario: ";
  static const String PRESTAR = "Prestar";
  static const String DEVOLVER = "Devolver";
  static const String OBSERVACIONES_ = "Observaciones: ";
  static const String SOLICITADO_POR = "Solicitado anteriormente por: ";
  static const String JUEGO_SIN_SACAR = "Este juego aún no ha dejado la ludoteca. Sé el primero en hacerlo.";
  static const String PRESTAMO = "Prestamo";
  static const String DEVOLUCION = "Devolución";
  static const String IPHONE = "iPhone";
  static const String CERRAR_SESION = "Cerrar Sesión";
  static const String NO_JUEGOS_DEVOLVER = "No tienes juegos en tu poder para devolver.";
  static const String EN_PODER_DE = "En poder de: ";
  static const String SEGURO_DEVOLUCION = "¿Seguro que deseas devolver este juego?";
  static const String OBSERVACIONES = "Observaciones";
  static const String ACEPTAR = "Aceptar";
  static const String CANCELAR = "Cancelar";
  static const String ERROR = "Error";
  static const String RETRY = "Retry";
  static const String INFORMACION = "Información";
  static const String NOMBRE_USUARIO = "Nombre de usuario";
  static const String PASSWORD = "Contraseña";

}