Este documento define cómo debe estar escrito cada archivo .json de escena (resources/story/*.json). Pásaselo a la IA que te genera los diálogos para que siempre produzca un JSON compatible con el juego.

# Estructura general del archivo

A partir de ahora, cada JSON de escena es un objeto con dos claves:

{
  "lines": [ ... ],
  "hotspots": [ ... ]
}
lines: el guion de diálogo.
hotspots: los objetos/personajes investigables de la escena.

Si una escena no tiene investigación (por ejemplo, una escena 100% lineal), hotspots puede ser un array vacío [].

## lines

Es un array de "líneas". Cada línea es un objeto con una de estas formas:
- Línea de diálogo normal
{ "speaker": "Lex", "text": "Vaya, menudo desastre." }
speaker: debe coincidir con un nombre de Character.Name (Lex, Agente377, Policia, Mcnamara, Henry).
text: el texto que se muestra.

- Cambio de fondo
{ "location": "bar" }
Carga res://assets/Background/bar.png.

- Cambio de escena/archivo
{ "next_scene": "cap1_sec1_esc2", "transition": "fade" }
next_scene: nombre del siguiente archivo JSON (sin .json).
transition: "fade" o "slide" (opcional, por defecto "fade").

- Ancla (punto al que se puede saltar)
{ "anchor": "pista_llave" }
Marca una posición en el array. No muestra nada, solo sirve como destino de un goto.

- Salto directo
{ "goto": "pista_llave" }
Salta a la línea con ese anchor.

- Elección del jugador
{
  "choices": [
    { "text": "Preguntar por la llave", "goto": "pista_llave" },
    { "text": "Preguntar por la hora",  "goto": "pista_hora" }
  ]
}

- Añadir una pista al inventario
{ "add_clue": "llave_oxidada" }
Cuando el guion llega a esta línea, se añade automáticamente la pista llave_oxidada al inventario del jugador (ver sección 3).
No muestra texto ni pausa el diálogo; se procesa y sigue a la línea siguiente, igual que un anchor.

Ejemplo típico de un hotspot que da una pista:
{ "anchor": "examinar_llave" },
{ "speaker": "Lex", "text": "Una llave oxidada... esto es importante." },
{ "add_clue": "llave_oxidada" },
{ "goto": "vuelta_investigacion" }

## hotspots
Es un array de objetos investigables de la escena actual. Cada uno tiene esta forma:
{
  "id": "llave_mesa",
  "type": "object",
  "label": "Llave sobre la mesa",
  "goto": "examinar_llave",
  "required": true,
  "one_time": false
}

Campo	Tipo	Obligatorio	Descripción
id	string	Sí	Identificador único del hotspot dentro de la escena.
type	string	Sí	"object", "npc" o "exit" (ver abajo).
label	string	No	Texto descriptivo (para tooltip/cursor). No imprescindible al principio.
goto	string	Sí	Nombre del anchor en lines al que salta al hacer clic.
required	bool	No (default false)	Si es true, hay que investigarlo antes de que la salida (exit) se desbloquee.
one_time	bool	No (default false)	Si es true, tras la primera interacción el hotspot se desactiva/deja de reaccionar.

### Tipos de hotspot
"object" → un objeto normal del escenario (una llave, una mancha de sangre, una puerta cerrada...).
"npc" → un personaje con el que se puede hablar. Funciona igual que "object" (salta a un anchor), la diferencia es solo semántica por ahora — más adelante el NPC podrá tener su propia mini-conversación con choices.
"exit" → el hotspot que permite salir de la escena/avanzar de capítulo. Si hay algún hotspot con required: true que aún no se ha investigado, el juego mostrará un texto de bloqueo en vez de dejar salir (esto lo implementaremos en el punto 6 del roadmap; el campo se define ya para que la IA lo genere desde ahora).
Ejemplo completo de hotspots
"hotspots": [
  {
    "id": "llave_mesa",
    "type": "object",
    "label": "Llave sobre la mesa",
    "goto": "examinar_llave",
    "required": true,
    "one_time": true
  },
  {
    "id": "hablar_policia",
    "type": "npc",
    "label": "Agente de policía",
    "goto": "hablar_con_policia",
    "required": true,
    "one_time": false
  },
  {
    "id": "puerta_salida",
    "type": "exit",
    "label": "Salir del bar",
    "goto": "fin_investigacion_bar",
    "required": false,
    "one_time": false
  }
]

## Pistas / Inventario (resources/story/clues.json)
Los id usados en add_clue deben existir en un archivo aparte, resources/story/clues.json, que define el texto que se mostrará en el inventario:
{
  "llave_oxidada": {
    "title": "Llave oxidada",
    "text": "Una llave vieja encontrada sobre la mesa del bar. Parece que no se ha usado en años."
  }
}

Este archivo es independiente por proyecto, no por escena — todas las pistas del juego van aquí, se van añadiendo a medida que escribes más escenas.

# Notas importantes
No dupliques id de hotspots dentro de la misma escena.
Todo goto (de un hotspot o de un choice) debe apuntar a un anchor que exista en lines.
Todo add_clue debe tener su entrada correspondiente en clues.json.
De momento, deja siempre "required": false en los hotspots de tipo "exit" — ese campo no aplica a la salida misma, solo a los objetos/NPC.
Los campos label y one_time son opcionales: si tienes dudas, la IA puede omitirlos y el juego usará los valores por defecto ("" y false).