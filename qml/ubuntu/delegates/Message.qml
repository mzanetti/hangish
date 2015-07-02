import QtQuick 2.0
import Ubuntu.Components 1.2

AbstractButton {
    id: delegate
    height: itemId.height + 10
    Item {
        id: itemId
        width: parent.width
        height: msgTextLabel.paintedHeight + senderLabel.paintedHeight + imageView.paintedHeight
        Column {
            width: parent.width * 0.75
            anchors.left: senderId == page.selfChatId ? parent.left : undefined
            anchors.right: senderId != page.selfChatId ? parent.right : undefined
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge

            Label {
                id: msgTextLabel
                width: parent.width
                text: msgtext
                wrapMode: Text.Wrap
                elide: Text.ElideRight
                horizontalAlignment: (senderId == page.selfChatId) ? Text.AlignLeft : Text.AlignRight
                color: (senderId == page.selfChatId) ? UbuntuColors.green : UbuntuColors.blue
                textFormat: Text.StyledText
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Image {
                id: imageView
                source: previewimage
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                cache: true
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 6 * 5
                x: units.gu(1)
            }

           Label {
                id: senderLabel
                width: parent.width
                font.bold: !read
                font.italic: !read
                text: (sender != "" ? sender + ", " : "") + timestamp
                horizontalAlignment: (senderId == page.selfChatId) ? Text.AlignLeft : Text.AlignRight
            }
            Image {
                id: hasReadImage

            }

        }
    }
    onClicked: openFullImage(fullimage)

    function openFullImage(url) {
        console.log(url)
        if (url.length>3) {
            fsImage.loadImage(url)
            pageStack.push(fsImage)
        }
    }
}

