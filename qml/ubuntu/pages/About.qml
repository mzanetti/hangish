import QtQuick 2.0
import Ubuntu.Components 1.2

Page {
    objectName: "AboutPage"
    title: qsTr("About Hangish")

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.rightMargin: Theme.paddingMedium

        Item {
            width: 1
            height: 3 * Theme.paddingLarge
        }
        Image {
            width: parent.width / 5
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:///icons/harbour-hangish.png"
            smooth: true
            asynchronous: true
        }
        Item {
            width: 1
            height: Theme.paddingLarge
        }
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("A client for Google Hangouts")
        }
        Item {
            width: 1
            height: Theme.paddingLarge
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            fontSize: "x-small"
            text: "Copyright © 2015 Daniele Rogora"
        }
        Item {
            width: 1
            height: 2 * Theme.paddingLarge
        }
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            fontSize: "small"
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: qsTr("Hangish is open source software licensed under the terms of ")
                  + qsTr("the GNU General Public License.")
        }
        Item {
            width: 1
            height: 2 * Theme.paddingLarge
        }
        /*
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("View license")
            onClicked: {
                pageStack.push(Qt.resolvedUrl("LicensePage.qml"));
            }
        }
        */
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Donate")
            onClicked: {
                pageStack.push(Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=daniele%2erogora%40gmail%2ecom&lc=IT&item_name=Hangish%20development&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted"));
            }
        }
    }
    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingSmall
        fontSize: "x-small"
        text: "https://github.com/rogora/hangish"
    }
}
