# RappiMovieTest

**CAPAS DE LA APLICACIÓN:**
1. Model
   1.1. PopularMovie+CoreDataClass: NSManagedObject de entidad PopularMovie.
   1.2. PopularMovie+CoreDataProperties: Propiedades/atributos de entidad PopularMovie.
   1.3. UpcomingMovie+CoreDataClass: NSManagedObject de entidad TopRtedMovie.
   1.4. UpcomingMovie+CoreDataProperties: Propiedades/atributos de entidad TopRtedMovie.
   1.5. TopRatedMovie+CoreDataClass: NSManagedObject de entidad UpcomingMovie.
   1.6. TopRatedMovie+CoreDataProperties: Propiedades/atributos de entidad UpcomingMovie.
   1.7. EntityName: Enum para los nombres de las entidades.
2. View
   2.1. BaseCell: Todos las clases de tipo CollectionViewCell heredan esta clase.
   2.2. MenuCell: Es la vista de la clase MenuBar.
   2.3. PopularCell: Es el primer cell de HomeViewController, muestra las películas más populares.
   2.4. TopRatedCell: Es el segundo cell de HomeViewController, muestra las películas más valoradas.
   2.5. UpComingCell: Es el tercer cell de HomeViewController, muestra las próximas películas.
   2.6. PopularMovieCell: Es la vista de PopularCell.
   2.7. TopRatedMovieCell: Es la vista de TopRatedCell.
   2.8. UpcomingMovieCell: Es la vista de UpComingCell.
   2.9. MenuBar: Es un UIView que se encuentra en HomeViewController y maneja el scroll de los 3 cells (Popular, Top Rated y Upcoming).
   
3. Controller
   3.1. HomeViewController: El CollectionView principal, funciona como el root. Posee los 3 cells (PopularCell, TopRatedCell y UpcominCell)
   3.2. LoginController: ViewController que maneja el login.
   3.3. MovieDetailController: ViewController para visualizar detalles de cada película seleccionada.
   
4. Service
   4.1. AuthService: Capa de autenticación. Aquí se obtiene el request_token, session_id, user_id para posteriormente loggearse (guardando datos en Keychain).
   4.2. ApiService: Todas las llamadas a los endpoints del servicio son manejadas en esta clase; todas con closures para su posterior uso en los controllers.
   
5. Utils
   5.1. Extensions: Extensiones de elementos (UIViews, UILabels, UIColor, etc).
   5.2. CoreDataStack: Para separar responsabilidades, esta clase solo maneja métodos de CoreData.
   5.3. CustomImageView: Caché para imágenes que vienen del servidor.
   5.4. Constants: Variables principales que se usan en todas las vistas.


**PREGUNTAS:**
1. En qué consiste el principio de responsabilidad única? Cuál es su propósito?
Consiste en que cada clase debe hacerse responsable por hacer determinadas cosas. Es un principio de diseño de software. Es importante considerarlo en términos de escalabilidad de un proyecto.

CARACTERISTICAS:
Permite entender qué funcionalidad hace algo espécifico. 
Modificar el código rápido y en el lugar preciso.
Abstraer la lógica en diferentes clases.
Definir Unit Test para cada clases, así se puede testear una pequeña parte del código.

2. Qué características tiene, según su opinión, un “buen” código o código limpio

**Eficiencia:** Más fácil de mantener.

**Mantenible**: Escribir código para que otros puedan leerlo y entenderlo.

**Bien estructurado**: Ordenado usando un buen patrón de diseño, separando responsabilidades de cada capa.

**Leíble:** Los nuevos programadores en un equipo deben entender rápido el código.

**Confiable:** Confiar en el orden y estructura del código puede ahorra tiempos importantes para el equipo y el negocio en general.


EJEMPLOS:

**Una sangría correcta (indentation):** Afecta bastante la lectura del código se no se usa apropiadamente. Es uno de las primeras cosas a considerar.

**Estándares de nombres:** Es importante que cada método variable tenga un nombre apropiado, que se logre entender cuál es su función.

**Declaración de variables y métodos:** Para no perder tiempo scrolleando intentando buscar variables, estas deben declarse arriba de la clase (en primer orden). Los métodos y variables públicos deben estar arriba de los privados.

**No duplicar código:** Intentar refactorizar las líneas de código que se usan más de una vez en toda la aplicación.

**Enums:** Para evitar errores de tipeo en variables que se usan mucho, usar enums es una buena opción.

**Massive Controllers:** Intentar no tener mucho código en los controllers. Ponerlos en otras clases y llamarlos mediante singleton.

**Dependencias mínimas**: Mientras más dependencias de librerías, más difícil será modificar el código en un futuro.

