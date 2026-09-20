# TFM — Aventura gráfica educativa sobre IA

## 1. Información general

**Título del TFM:** Desarrollo de una aventura gráfica educativa, tipo Point&Click, usando la plataforma Godot en consonancia con IA generativa para la concienciación y educación de la IA.

**Género:** Aventura gráfica / Point&Click.

**Motor:** Godot.

**Propósito:** Utilizar un videojuego narrativo para concienciar al jugador sobre el uso de la inteligencia artificial generativa, sus posibilidades y sus riesgos.

## 2. Concepto del juego

El juego es una aventura gráfica centrada en la investigación de un caso policial. El jugador explora escenas, investiga pistas, resuelve retos y toma decisiones mediante diálogos ramificados.

La narrativa es el principal vehículo para introducir las competencias educativas relacionadas con la inteligencia artificial. Las decisiones del jugador forman parte de la historia y condicionan la manera en la que se desarrolla la investigación.

Las mecánicas principales son:

- Exploración de escenarios.
- Investigación de pistas y objetos.
- Resolución de retos.
- Interacción con personajes.
- Diálogos con decisiones.
- Deducción de información a partir de las evidencias.
- Progresión narrativa mediante escenas.

## 3. Ambientación y tono

La historia utiliza una ambientación policial con tono de novela negra.

El conflicto gira alrededor de un caso en el que se mezclan el mundo físico y el digital, permitiendo introducir de forma natural cuestiones relacionadas con la inteligencia artificial.

El tono general debe mantener:

- Misterio.
- Investigación policial.
- Tensión.
- Humor seco.
- Ironía.
- Conflicto entre el detective humano y la inteligencia artificial.

## 4. Personajes principales

### Lex

Detective joven, prometedor e irascible.

Es el compañero humano de Agente377. Desconfía de la inteligencia artificial y muestra rechazo hacia ella, especialmente porque considera que una IA no debería ocupar el puesto de un agente de policía.

Su relación con Agente377 es uno de los elementos recurrentes de la narrativa.

### Agente377

Agente de policía basado en inteligencia artificial.

Tiene una empatía superficial y una forma de comunicarse seria, literal y orientada al análisis.

Su comportamiento debe contrastar con el de Lex. Mientras Lex tiende a reaccionar emocionalmente, Agente377 analiza las situaciones desde una perspectiva racional.

Lex utiliza recurrentemente el término **«policIA»** para referirse a Agente377 como forma de burlarse de su naturaleza artificial.

### Inspectora McNamara

Superior de Lex y Agente377.

Es irascible, impaciente y tiene poca tolerancia para las discusiones entre ambos. Su función es impulsar la investigación y recordarles que deben trabajar juntos.

## 5. Caso principal

El caso comienza con un robo cometido contra un banco.

No se ha sustraído únicamente dinero físico: también han desaparecido fondos digitales almacenados en los servidores internos.

### Robo físico

Alguien ha vaciado la cámara acorazada del Banco Nacional.

### Robo digital

Al mismo tiempo, todos los fondos digitales almacenados en los servidores internos han desaparecido.

La simultaneidad de ambas operaciones hace pensar que existe una relación entre ellas.

Agente377 señala que las dos operaciones requieren conocimientos completamente distintos, lo que inicialmente lleva a plantear la posibilidad de que hayan participado dos delincuentes.

Sin embargo, la investigación revela elementos que apuntan a que el robo forma parte de algo más elaborado.

## 6. El mensaje «A.H.»

En la cámara acorazada aparece una nota en papel.

En el servidor comprometido aparece también un archivo de texto.

Ambos contienen exactamente el mismo mensaje:

> A.H.

Las iniciales no corresponden inicialmente con ninguna firma conocida en las bases de datos policiales.

El significado de «A.H.» queda deliberadamente abierto:

- Puede ser una firma.
- Puede ser una amenaza.
- Puede ser una invitación.
- Puede ser una forma de anunciar algo.
- Puede ser una distracción para desviar la investigación.

El mensaje está destinado a ser encontrado y constituye una de las primeras grandes incógnitas de la investigación.

## 7. Inicio de la historia

La historia comienza en la oficina de policía.

Lex y Agente377 están interactuando con McNamara antes de recibir el caso. La relación entre los dos protagonistas queda establecida mediante una conversación en la que el jugador puede elegir diferentes actitudes.

### Rutas de diálogo

Las decisiones de diálogo se organizan alrededor de tres tipos de respuesta:

1. **Profesional** — Lex intenta centrarse en el trabajo y en la investigación.
2. **Hostil** — Lex muestra abiertamente su rechazo hacia Agente377.
3. **Sarcástica** — Lex responde mediante ironía y comentarios mordaces.

Estas tres rutas sirven para representar diferentes formas de interpretar al protagonista sin romper la progresión principal de la historia.

## 8. Briefing inicial

McNamara informa a Lex y Agente377 de que alguien ha vaciado la cámara acorazada del Banco Nacional.

La particularidad del caso es que, simultáneamente, han desaparecido los fondos digitales almacenados en los servidores internos.

La primera hipótesis es que podrían existir dos responsables:

- Un delincuente especializado en el robo físico.
- Otro especializado en el robo digital.

La aparición de «A.H.» cambia la interpretación inicial del caso.

McNamara ordena a ambos agentes desplazarse al Banco Central para continuar la investigación y obtener un informe preliminar antes del anochecer.

## 9. Estructura narrativa

El juego se organiza mediante capítulos, secuencias y escenas.

La estructura utilizada para documentar cada escena incluye:

- Finalidad de la escena.
- Actores/personajes.
- Escena y contexto.
- Mecánicas.
- Retos.
- Diálogo.
- Decisiones.
- Deducciones.
- Transición a la siguiente escena.

Las escenas deben combinar narrativa y jugabilidad para que las competencias educativas relacionadas con IA formen parte de la resolución del caso y no aparezcan como contenido independiente.

## 10. Sistema de diálogos

Los diálogos se representan mediante una estructura JSON para facilitar su implementación y ramificación.

Ejemplo conceptual:

```json
{
  "speaker": "Lex",
  "text": "Texto del diálogo",
  "choices": [
    {
      "text": "Respuesta profesional",
      "goto": "profesional"
    },
    {
      "text": "Respuesta hostil",
      "goto": "hostil"
    },
    {
      "text": "Respuesta sarcástica",
      "goto": "sarcastico"
    }
  ]
}
```

Los diálogos pueden utilizar:

- `speaker` para identificar al personaje.
- `text` para el contenido.
- `choices` para las decisiones del jugador.
- `goto` para dirigir el flujo.
- `anchor` para identificar puntos concretos del diálogo.
- `next_scene` para pasar a otra escena.
- `transition` para definir la transición entre escenas.

## 11. Principios narrativos

### Las decisiones deben tener sentido

Las respuestas del jugador deben representar diferentes actitudes o razonamientos, no elecciones arbitrarias.

### La investigación debe avanzar mediante deducciones

Las pistas encontradas deben permitir al jugador formular hipótesis y conectar información.

### La IA debe estar integrada en la historia

La concienciación sobre inteligencia artificial debe surgir de las situaciones, personajes, conflictos y retos del juego.

### El conflicto Lex–Agente377 debe ser recurrente

La relación entre ambos personajes sirve como hilo conductor y permite introducir preguntas sobre la confianza en sistemas de IA, sus capacidades y sus limitaciones.

### Mantener el contraste humano/IA

Lex debe representar una perspectiva más intuitiva, emocional y desconfiada.

Agente377 debe representar una perspectiva analítica, racional y basada en el procesamiento de información.

## 12. Objetivo educativo

El objetivo general del proyecto es que el jugador desarrolle competencias relacionadas con la concienciación sobre la inteligencia artificial.

El juego pretende mostrar que la IA puede utilizarse para facilitar determinadas tareas, pero que también existen consecuencias negativas y riesgos asociados a su uso.

El videojuego debe favorecer una actitud crítica ante la IA en lugar de presentar la tecnología exclusivamente como positiva o negativa.

Entre los conceptos que pueden abordarse mediante la narrativa y las mecánicas se encuentran:

- Capacidades de la IA generativa.
- Limitaciones de los sistemas de IA.
- Necesidad de verificar información.
- Riesgos de la generación de contenido falso.
- Uso responsable de herramientas de IA.
- Diferencias entre razonamiento humano y procesamiento artificial.
- Confianza y dependencia de sistemas automatizados.

## 13. Dirección artística y narrativa

La referencia narrativa principal es el género policial/noir.

La presentación debe transmitir:

- Investigación.
- Sospecha.
- Ambigüedad.
- Humor irónico.
- Contraste entre tecnología y métodos policiales tradicionales.

La tecnología y la inteligencia artificial deben formar parte del mundo del juego y no aparecer únicamente como un recurso didáctico externo.

## 14. Mecánicas de Point&Click

El bucle básico de juego es:

1. Llegar a una escena.
2. Observar el entorno.
3. Interactuar con objetos y personajes.
4. Obtener pistas.
5. Resolver pequeños retos.
6. Tomar decisiones en diálogos.
7. Realizar deducciones.
8. Avanzar a la siguiente escena.

Los objetos y pistas deben contribuir a la investigación y, cuando sea posible, reforzar los conceptos educativos relacionados con IA.

## 15. Estado narrativo inicial

### Capítulo 1 — Inicio de la investigación

**Secuencia 1 — Presentación y caso**

- Presentación de Lex.
- Presentación de Agente377.
- Presentación de McNamara.
- Conflicto inicial entre Lex y Agente377.
- Introducción del robo.
- Descubrimiento del doble robo físico/digital.
- Aparición del mensaje «A.H.».
- Primeras hipótesis.
- Orden de investigar la escena del crimen.

**Escena siguiente prevista:**

`cap1_sec1_esc2`

Esta escena continúa la investigación en el lugar del robo.

## 16. Elementos que deben mantenerse consistentes

- Lex es desconfiado respecto a la IA.
- Agente377 mantiene un tono serio y analítico.
- McNamara es impaciente e irascible.
- Lex llama «policIA» a Agente377 como broma recurrente.
- Las rutas de diálogo son profesional, hostil y sarcástica.
- El caso combina robo físico y robo digital.
- «A.H.» es una pieza central del misterio inicial.
- Las decisiones deben integrarse en la narrativa.
- La deducción debe formar parte de la jugabilidad.
- La IA debe ser un elemento narrativo y educativo, no únicamente una temática superficial.

## 17. Referencia del TFM

El proyecto está planteado como una aplicación práctica dentro del Trabajo Fin de Máster del Máster Universitario en Desarrollo de Software.

La documentación registrada establece como objetivo diseñar y desarrollar una aventura gráfica educativa Point&Click utilizando Godot y tecnologías de IA generativa, con la finalidad de trabajar la concienciación y educación sobre inteligencia artificial mediante la propia experiencia de juego.
