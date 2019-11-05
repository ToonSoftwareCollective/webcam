import QtQuick 2.1
import qb.components 1.0

Screen {
	id: webcamConfigScreen

	screenTitle: "Config";

	function saveWebcamImageURL1(text) {
		if (text) {
			app.settings["webcamImageURL1"] = text;
	   		var doc2 = new XMLHttpRequest();
   			doc2.open("PUT", "file:///mnt/data/tsc/webcam.userSettings.json");
   			doc2.send(JSON.stringify(app.settings));
		}
	}

	onShown: {
		webcamImageURL1.inputText = app.settings["webcamImageURL1"];
	}

	EditTextLabel4421 {
		id: webcamImageURL1
		width: parent.width - 40
		height: isNxt ? 45 : 36
		leftTextAvailableWidth: isNxt ? 250 : 200
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
