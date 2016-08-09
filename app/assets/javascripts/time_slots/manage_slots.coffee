changeColor = ($object) -> 
	if $object.data("between") == true
		$object.css("background", "rgb(78, 179, 211)")
	else
		$object.css("background", "#FFFFFF")

updateData = ->
	data = "["
	$('.time-slot-button').each ->
		if $(this).data("between") == true
			wday = $(this).data("wday")
			start_hour_and_min = $(this).data("hour") * 100
			end_hour_and_min = start_hour_and_min + 100
			
			dataString = '{' + 
												'"wday":"' + wday + '",' + 
												'"start_hour_and_min":"' + start_hour_and_min + '",' + 
												'"end_hour_and_min":"' + end_hour_and_min + '"' + 
												'},'
			data += dataString
	
	$('#form-manage-time-slot-slots-data').val(data.substring(0,data.length-1) + "]")

$('.time-slot-button').click ->
	$slot = $(this)
	$slot.data("between", if $slot.data("between") == true then false else true)
	changeColor($slot)

$('#form-manage-time-slot-button').click ->
	updateData()
	$('#form-manage-time-slot').submit()

$(document).ready ->
	$('.time-slot-button').each ->
		changeColor($(this))