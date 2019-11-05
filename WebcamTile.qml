import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: webcamTile

	function init() {}

	onClicked: {
		if (app.webcamFullScreen) {
			app.webcamFullScreen.show();
			console.log("webcam: app.webcamFullScreen.show() called")
		}
	}

	Image {
		id: tileWebcamImage1
    		width: 200; height: 140
		source: "qrc:/tsc/webcam_large.jpg"
		anchors {
			verticalCenter: parent.verticalCenter
			horizontalCenter: parent.horizontalCenter
		}
		cache: false
		visible: !dimState
	}	
}
