document.addEventListener("DOMContentLoaded", function() {
	const zooming = new Zooming({
		bgColor: "#1e592a"
	})
	zooming.listen('.attendance-location')
})