/**
 * Author: Qt君
 * WebSite: qthub.com
 * Email: 2088201923@qq.com
 * QQ交流群: 732271126
 * 关于更多: 扫码关注微信公众号: [Qt君] 第一时间获取最新推送.
 */
import QtQuick 2.0

Item {
    default property alias items: view.children
    anchors.fill: parent

    Flickable {
        id: view
        anchors.fill: parent
        contentWidth: _private.getMax().maxWidth
        contentHeight: _private.getMax().maxHeight
        clip: true

        property int childX: visibleArea.xPosition * contentWidth
        property int childY: visibleArea.yPosition * contentHeight

        onChildXChanged: {
            for (var i = 0; i < items.length; i++)
                items[i].x = -childX
        }

        onChildYChanged: {
            for (var i = 0; i < items.length; i++)
                items[i].y = -childY
        }

    }

    Loader {
        id: horizontalBar
        anchors.bottom: view.bottom
        sourceComponent: scrollBar

        Component.onCompleted: horizontalBar.item.orientation = Qt.Horizontal
    }

    Loader {
        id: verticalBar
        anchors.right: view.right
        sourceComponent: scrollBar

        Component.onCompleted: verticalBar.item.orientation = Qt.Vertical
    }

    property Component scrollBar:
        Rectangle {
            id: root
            property Flickable target: view
            property int orientation: Qt.Vertical
            /*
                orientation : enumeration
                This property holds the orientation of the scroll bar.
                Possible values:
                |Constant     |Description|
                |Qt.Horizontal|Horizontal|
                |Qt.Vertical  |Vertical(default)|
            */
            width: orientation == Qt.Vertical ? radius : target.width - radius
            height: orientation == Qt.Vertical ? target.height - radius : radius
            color: "white"
            opacity: 0.3
            radius: 10

            Rectangle {
                y: parent.orientation == Qt.Vertical ? target.visibleArea.yPosition * (target.height - parent.radius) : 0
                x: parent.orientation == Qt.Vertical ? 0 : target.visibleArea.xPosition * (target.width - parent.radius)
                width: parent.orientation == Qt.Vertical ? parent.width :
                        target.visibleArea.widthRatio * (target.width - parent.radius)
                height: parent.orientation == Qt.Vertical ? target.visibleArea.heightRatio * (target.height - parent.radius) :
                         parent.height
                color: "black"
                radius: parent.radius
                opacity: 0.7
            }
        }

    QtObject {
        id: _private
        function getMax() {
            var maxWidth = 0;
            var maxHeight = 0;

            for (var i = 0; i < items.length; i++) {
                if (items[i].width > maxWidth)
                    maxWidth = items[i].width

                if (items[i].height > maxHeight)
                    maxHeight = items[i].height
            }

            return {"maxWidth": maxWidth, "maxHeight": maxHeight}
        }
    }
}
