import QtQuick 1.1
import qb.components 1.0

Screen {
	id: webcamConfigScreen

	screenTitle: "Config";

	function saveWebcamImageURL1(text) {
		if (text) {
			app.webcamImageURL1 = text;
	   		var doc2 = new XMLHttpRequest();
   			doc2.open("PUT", "file:///HCBv2/qml/apps/webcam/selectedImageURL1.txt");
   			doc2.send(app.webcamImageURL1);
		}
	}

	onShown: {
		webcamImageURL1.inputText = app.webcamImageURL1;
	}

	EditTextLabel {
		id: webcamImageURL1
		width: parent.width - 40
		height: 35
		leftTextAvailableWidth: 200
		leftText: "URL webcam image"

		anchors {
			left: parent.left
			top: parent.top
			leftMargin: 20
			rightMargin: 20
			topMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qkeyboard.open("URL", webcamImageURL1.inputText, saveWebcamImageURL1)
		}
	}

	Text {
		id: myLabel
		text: "Example of valid URL: http://192.168.42.8/live/1/jpeg.jpg"
		anchors {
			left: parent.left
			top: webcamImageURL1.bottom
			leftMargin: 20
			rightMargin: 20
			topMargin: 20
			bottomMargin: 20
		}
	}

}
