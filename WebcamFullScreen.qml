import QtQuick 1.1
import qb.components 1.0

Screen {
	id: webcamFullScreen

	screenTitle: "Webcam";

	onCustomButtonClicked: {
		if (app.webcamConfigScreen) {
			 app.webcamConfigScreen.show();
		}
	}

	onShown: {
		console.log("webcam: WebcamFullScreen.onShown() called")
		addCustomTopRightButton("Configuratie")
		screenStateController.screenColorDimmedIsReachable = false
		app.webcamTimer1Interval = 1000
		screenStateController.notifyChangeOfSettings()
		app.pictureCountdownCounter = app.pictureCountdownCounterStart
		app.webcamTimer1Running = true
	}

	onHidden: {
		console.log("webcam: WebcamFullScreen.onHidden() called")
		app.webcamTimer1Interval = 60000
		app.pictureCountdownCounter = -1
		screenStateController.screenColorDimmedIsReachable = true
		app.webcamTimer1Running = false
	}

	function test001() {
		if (app.pictureCountdownCounter <= 0 && webcamFullScreen.visible) {
			screenStateController.screenColorDimmedIsReachable = true
//			screenStateController.manualDim = true;
			webcamFullScreen.hide()
			screenStateController.forceTestScreenState(3);
		}
	}

	Image {
		id: webcamImage1
		width: parent.width
		height: parent.height - 30
		fillMode: Image.PreserveAspectFit
		source: app.webcamImage1Source
		anchors {
			left: parent.left
			top: parent.top
		}
		cache: false
		z: app.webcamImage1Z
		onStatusChanged: {
			app.webcamImage1Ready = (webcamImage1.status == Image.Ready)
			test001()
		}
		MouseArea {
			anchors.fill: parent
		 	onClicked: {
				app.pictureCountdownCounter = app.pictureCountdownCounterStart
		 	}
 		}
	}

	Image {
		id: webcamImage2
		width: parent.width
		height: parent.height - 30
		fillMode: Image.PreserveAspectFit
		source: app.webcamImage2Source
		anchors {
			left: parent.left
			top: parent.top
		}
		cache: false
		z: app.webcamImage2Z
		onStatusChanged: {
			app.webcamImage2Ready = (webcamImage2.status == Image.Ready)
			test001()
		}
		MouseArea {
			anchors.fill: parent
		 	onClicked: {
				app.pictureCountdownCounter = app.pictureCountdownCounterStart
		 	}
 		}
	}

	Rectangle {
	    width: parent.width
	    height: 20
	    color: "white"
			anchors {
				left: parent.left
				bottom: parent.bottom
			}
			z: 10
	}

	Rectangle {
	    width: Math.abs((app.pictureCountdownCounter/app.pictureCountdownCounterStart)*parent.width)
	    height: 20
	    color: "green"
			anchors {
				left: parent.left
				bottom: parent.bottom
			}
			z: 20
	}

}
