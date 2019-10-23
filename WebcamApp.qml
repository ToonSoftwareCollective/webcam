import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0;

App {
	id: webcamApp

	property url 	tileUrl : "WebcamTile.qml"
	property url 	thumbnailIcon: "./drawables/webcam.png"
	property 		WebcamFullScreen webcamFullScreen
	property 		WebcamConfigScreen webcamConfigScreen
	property 		WebcamTile webcamTile

	property string 	webcamImage1Source
	property string 	webcamImage2Source
	property bool 	webcamImage1Ready: false
	property bool 	webcamImage2Ready: false
	property int 	webcamImage1Z: 100
	property int 	webcamImage2Z: 0
	property int 	pictureCycleCounter: 0
	property int 	pictureCountdownCounterStart: 50
	property int 	pictureCountdownCounter: 100
	property int 	webcamTimer1Interval: 1000
	property bool 	webcamTimer1Running: false
//	property string 	webcamImageURL1 : "http://192.168.42.8/live/1/jpeg.jpg";
//	property string 	webcamImageURL1 : "http://69.203.221.199:8000/jpg/image.jpg";
//	property string 	webcamImageURL1 : "http://61.216.15.197/axis-cgi/jpg/image.cgi?camera=1&resolution=320x240&compression=25";
	property string 	webcamImageURL1 : "http://91.133.85.170:8090/record/current.jpg"

	QtObject {
		id: p
		property url webcamFullScreenUrl : "WebcamFullScreen.qml"
		property url webcamConfigScreenUrl : "WebcamConfigScreen.qml"
	}

	function init() {
		registry.registerWidget("tile", tileUrl, this, "webcamTile", {thumbLabel: qsTr("Webcam"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", p.webcamFullScreenUrl, this, "webcamFullScreen");
		registry.registerWidget("screen", p.webcamConfigScreenUrl, this, "webcamConfigScreen");
		webcamImage1Source = webcamImageURL1;
		webcamImage2Source = webcamImageURL1;
		webcamImage1Z = 0;
		webcamImage2Z = 100;
	}

	function listProperty(item){
    		for (var p in item)
    			console.log(p + ": " + item[p]);
	}

	Component.onCompleted: {
		readDefaults();
		console.log("webcam: listProperty(screenStateController)")
		listProperty(screenStateController)
	}

	function updateWebcamImage1() {
		if (webcamFullScreen.visible && !dimState){
			console.log("webcam: updateWebcamImage1() called")
			switch(pictureCycleCounter) {
			case 0:
				webcamImage2Source = ""
				webcamImage2Source = webcamImageURL1
				pictureCycleCounter = pictureCycleCounter + 1
				break
			case 1:
				if (webcamImage2Ready) {
					webcamImage2Z = 100
					webcamImage1Z = 0
					pictureCycleCounter = pictureCycleCounter + 1
					pictureCountdownCounter = pictureCountdownCounter - 1
				}
				break
			case 2:
				webcamImage1Source = ""
				webcamImage1Source = webcamImageURL1
				pictureCycleCounter = pictureCycleCounter + 1
				break
			case 3:
				if (webcamImage1Ready) {
					webcamImage1Z = 100
					webcamImage2Z = 0
					pictureCycleCounter = 0
					pictureCountdownCounter = pictureCountdownCounter - 1
				}
				break
			}
		}
	}

	Timer {
		id: webcamTimer1
		interval: webcamTimer1Interval
		triggeredOnStart: true
		running: webcamTimer1Running
		repeat: true
		onTriggered: updateWebcamImage1()
	}

	function readDefaults() {
		var doc1 = new XMLHttpRequest();
		doc1.onreadystatechange = function() {
			if (doc1.readyState == XMLHttpRequest.DONE) {
				if (doc1.responseText.length > 8) {
					webcamImageURL1 = doc1.responseText;
				}
 			}
		}
		doc1.open("GET", "file:///HCBv2/qml/apps/webcam/selectedImageURL1.txt", true);
		doc1.send();
	}
}
