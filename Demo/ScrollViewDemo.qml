import QtQuick 2.0
import "./"

ScrollView {
    width: 100
    height: 100

    Rectangle {
        id: item
        width: 500
        height: 500
        color: "lightblue"

        Text {
            text: "1234234234"
        }

        Text {
            anchors.right: parent.right
            anchors.top: parent.top
            text: "1234234234"
        }
    }

    Rectangle {
        width: 200
        height: 200
        color: "gray"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {

            item.width += 10
            console.log(">>>>>>>>>")
        }
    }
}
