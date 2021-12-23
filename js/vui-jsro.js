helper.dom.ready(function () {

	var jsro = new Thinfinity.JsRO();
	var ro = null;

	jsro.on('model:ro', 'created', function () {
		ro = jsro.model.ro;
	});

	jsro.on('ro', 'dohtml2canvasop', function () {
      html2canvas(document.body,{background: '#fff'}).then(function(canvas) {
        var base64URL = canvas.toDataURL('image/png');
        ro.data = base64URL;
      });
	});
    
});
