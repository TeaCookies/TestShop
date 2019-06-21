<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="EUC-KR">
    <title>vision-test</title>
    <script src="libraries/p5.js" type="text/javascript"></script>

    <script src="libraries/p5.dom.js" type="text/javascript"></script>
    <script src="libraries/p5.sound.js" type="text/javascript"></script>

    <script src="//code.jquery.com/jquery-2.2.1.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/javascript-canvas-to-blob/3.3.0/js/canvas-to-blob.min.js"></script>
    <script type="text/javascript">
    
    var request, output;

    var capture;
    var w = 640, h = 480;

    function setup() {
      capture = createCapture(VIDEO);
      createCanvas(w, h);
      capture.size(w, h);
      capture.hide();
    }

    function blobToBase64(blob, cb) {
      var reader = new window.FileReader();
      reader.readAsDataURL(blob); 
      reader.onloadend = function() {           
        cb(reader.result);
      }
    }

    function canvasToBase64(canvas, cb) {
      canvas.toBlob(function(blob) {
        blobToBase64(blob, cb);
      }, 'image/jpeg');
    }

    function upload() {
        canvasToBase64(canvas, function(b64) {
          b64 = b64.replace('data:image/jpeg;base64,', ''); // remove content type
          request = {
            "requests":[
              {
                "image":{ "content": b64 },
                "features":[
                  {
                    // if you want to detect more faces, or detect something else, change this
                    "type":"WEB_DETECTION",
                    "maxResults":1
                  }
                ]
              }
            ]
          };
          
          $.ajax({
            method: 'POST',
            url: 'https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDaDu7bjQpGLN3nKnUfulB3khHE-iGQap0',
            contentType: 'application/json',
            data: JSON.stringify(request),
            processData: false,
            success: function(data){
              output = data;
              var faceData = data.responses[0].faceAnnotations[0];
              console.log('joy: ' + faceData.joyLikelihood);
              console.log('sorrow: ' + faceData.sorrowLikelihood);
              console.log('anger: ' + faceData.angerLikelihood);
              console.log('surprise: ' + faceData.surpriseLikelihood);
            },
            error: function (data, textStatus, errorThrown) {
              console.log('error: ' + data);
            }
          })
        })
    }

    function draw() {
      // whatever you draw here will be uploaded to google when you call upload()
      image(capture, 0, 0, w, h);
    }

    function mousePressed() {
      upload();
    }
    
    
    
    
    </script>

    <style> body {padding: 0; margin: 0;} canvas {vertical-align: top;} </style>
  </head>
  <body>
  </body>
</html>

