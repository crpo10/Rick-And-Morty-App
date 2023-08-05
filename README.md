
# Rick and Morty App 🌌

Una aplicación Flutter para explorar el universo de Rick y Morty. Descubre personajes, episodios y más desde el multiverso más loco de la televisión.

[app_image](https://res.cloudinary.com/crpo20/image/upload/v1691272351/lfg8oz1zjh32grcj86nd.png)

## 🚀 Características

- **Explorar Personajes**: Navega a través de todos tus personajes favoritos de Rick y Morty.
- **Detalles de Episodios**: Obtén información sobre cada episodio, incluido su fecha de emisión.
- **Búsqueda Avanzada**: Encuentra rápidamente personajes y episodios con nuestro motor de búsqueda incorporado.

## 🛠️ Instalación y Uso

1. **Pre-requisitos**: 
   - Asegúrate de tener Flutter y Dart instalados en tu máquina. [Guía de instalación](https://flutter.dev/docs/get-started/install).
  
2. **Clonar y Ejecutar**:
   ```bash
   git clone https://github.com/tu-usuario/rick-and-morty-flutter-app.git
   cd rick-and-morty-flutter-app
   flutter run
### Patrón BLoC

Optamos por el patrón BLoC para la gestión del estado debido a su capacidad para separar la lógica de negocio de la lógica de UI, haciendo que el código sea más mantenible y escalable.

### BLoC de Personajes (Character BLoC)

El `CharacterBloc` es el corazón de la gestión de estado para los personajes en nuestra aplicación. Usa el patrón BLoC para manejar eventos relacionados con personajes y emitir estados correspondientes.

## Introducción

Este BLoC se encarga de interactuar con `CharacterRepository` para recuperar listas de personajes y emitir los estados adecuados para la capa de UI.

## Eventos y Estados

El BLoC maneja principalmente dos eventos:

1. **GetCharacters**: Solicita una lista inicial de personajes.
2. **GetMoreCharacters**: Solicita cargar más personajes, por lo general, para una funcionalidad de scroll infinito.

A su vez, el BLoC emite varios estados como respuesta a estos eventos, los más notables son:

- **CharacterInitial**: Estado inicial del BLoC, antes de que cualquier acción haya sido tomada.
- **CharacterLoaded**: Estado que indica que una lista de personajes ha sido cargada.

## Funcionamiento

### Al recibir `GetCharacters`:

- Si el estado actual es `CharacterInitial`, el BLoC recupera la lista inicial de personajes a través del `CharacterRepository`.
- Si el estado actual es `CharacterLoaded` y aún no se han alcanzado todos los personajes, el BLoC solicita y carga más personajes.

### Al recibir `GetMoreCharacters`:

- Si el estado actual es `CharacterLoaded` y aún no se han alcanzado todos los personajes, el BLoC procede a cargar más personajes.

## Funciones Auxiliares

La función `_hasReachedMax` es una función de utilidad que verifica si se ha alcanzado el número máximo de personajes cargados. Esta función es esencial para evitar llamadas innecesarias al repositorio cuando ya se han cargado todos los personajes disponibles.

## Conclusión

`CharacterBloc` juega un papel crucial en la gestión de la lógica relacionada con los personajes en la aplicación. Gracias a su diseño modular y a la separación de responsabilidades, es fácil de mantener y expandir en el futuro.

### BLoC de Episodios (Episode BLoC)

Este BLoC es responsable de gestionar y emitir el estado relacionado con los Episodeos de Rick y Morty. 
Utiliza el repositorio `EpisodeRepository` para recuperar datos.

Para solicitar la carga de personajes, emite el evento `GetEpisodes`.

La logica Implementada en este BLoC es muy parecida a la antes mencionada.

### BLoC de Busqueda de personajes (SearchCharacters BLoC)

Este BLoC es responsable de gestionar y emitir el estado relacionado a la busque de personajes de Rick y Morty. 
Utiliza el repositorio `CharacterRepository` para recuperar datos.

Para solicitar la carga de personajes, emite el evento `searchCharacters`.

El SearchCharacterBloc es responsable de gestionar las búsquedas de personajes en la aplicación. Este BLoC se comunica con CharacterRepository para realizar búsquedas basadas en una consulta proporcionada.

Cuando el BLoC recibe un evento SearchCharacters, realiza las siguientes acciones:

1. Emite CharacterSearching: Esto probablemente sirve como una señal para la capa de UI para mostrar algún indicador de carga, informando al usuario que la búsqueda está en proceso.

2. Realiza la búsqueda: El BLoC invoca el método searchCharacters del CharacterRepository con la consulta proporcionada en el evento.

3. Resultado de la búsqueda:

  Si la búsqueda es exitosa, emite CharacterSearchResult con la lista de personajes encontrados.

  Si ocurre un error durante la búsqueda, emite CharacterSearchError.

Este BLoC tiene un diseño claro y conciso, y se asegura de mantener la lógica de búsqueda separada de la UI, proporcionando una arquitectura limpia y mantenible.


## 📄 Licencia
Este proyecto está bajo la licencia MIT.

## ❓ FAQs
¿Esta aplicación utiliza la API oficial de Rick y Morty?
Sí, todas las informaciones se obtienen de la [API oficial de Rick y Morty.](https://rickandmortyapi.com/)

## 💌 Contacto
Si tienes alguna pregunta, no dudes en contactarme:

- **LinkedIn**: [Rafael Gomez](https://www.linkedin.com/in/rafael-g%C3%B3mez-m%C3%A1rquez-b52914133/)
- **Email**: [rafaeljose3020@gmail.com](mailto:rafaeljose3020@gmail.com)

