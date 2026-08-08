class_name HotspotLayer
extends CanvasLayer

signal hotspot_triggered(goto_id: String)

# TODO (Roadmap paso 2): instanciar Hotspot.tscn por cada elemento
# del array "hotspots" del JSON, y reemitir su señal hotspot_clicked
# como hotspot_triggered(goto_id).

func spawn_hotspots(hotspots_data: Array) -> void:
	pass # Se implementa en el próximo paso

func clear_hotspots() -> void:
	pass # Se implementa en el próximo paso
