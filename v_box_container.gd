extends VBoxContainer

func set_datos(dato: FotoDato):
	$TextureRect.texture = dato.imagen
	$Label.text = dato.fecha
	$Label2.text = dato.descripcion
