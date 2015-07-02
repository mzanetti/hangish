import QtQuick 2.0
import Ubuntu.Components 1.2

ListItem {
    id: delegate
    height: units.gu(6)

    Row {
        height: parent.height
        anchors {
            left: parent.left
            right: parent.right
            rightMargin: Theme.paddingLarge
        }
        spacing: units.gu(1)

        Image {
            id: img
            width: height
            height: delegate.height
            asynchronous: true
            source: imagePath
        }

        Label {
            width: parent.width - img.width - 2 * Theme.paddingLarge
            text: (unread > 0) ? qsTr(name + " " + unread) : qsTr(name)
            font.bold: (unread > 0) ? true : false
            anchors.verticalCenter: parent.verticalCenter
            maximumLineCount: 2
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
        }
    }
}
