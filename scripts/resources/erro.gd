extends CanvasLayer

@onready var report_error: Label = $report_error

func _process(_delta: float) -> void:
	report_error.text = "current OS: %s \nscore: %d \nbest score: %d \n 
	" % [OS.get_name(), SaveGame.save_data["score"], SaveGame.save_data["best_score"]]
