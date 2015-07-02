/*

Hanghish
Copyright (C) 2015 Daniele Rogora

This file is part of Hangish.

Hangish is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Hangish is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Nome-Programma.  If not, see <http://www.gnu.org/licenses/>

*/


import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Web 0.2


Page {
    id: page
    title: "Hangish login"

    Connections
    {
        target: Client
        onInitFinished: {
            console.log("Init finished")
            pageStack.push(Qt.resolvedUrl("Roster.qml"))
        }
        onLoginNeeded: {
            infotext.visible = false
            loginIndicator.visible = false
            wv.visible = true
            wv.url = "https://accounts.google.com/o/oauth2/auth?scope=https://www.google.com/accounts/OAuthLogin%20https://www.googleapis.com/auth/userinfo.email&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&client_id=936475272427.apps.googleusercontent.com"
            //pageStack.push(Qt.openUrlExternally())
        }

        onAuthFailed: {
            loginIndicator.running = false
            infotext.text = error
            resultLabel.text = qsTr("Login Failed ") + error
            delauthbtn.visible = true
        }

        onSecondFactorNeeded: {
        }
    }

    Column {
        width: parent.width
        height: parent.height
        spacing: units.gu(1)

        Item {
            // Spacer
            height: parent.height / 3
            width: 1
        }

        ActivityIndicator {
            id: loginIndicator
            running: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: infotext
            text: qsTr("Logging in")
            width: parent.width
            fontSize: "large"
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: resultLabel
            color: "red"
        }

        Button {
            id: delauthbtn
            visible: false
            text: qsTr("Delete authentication cookie")
            onClicked: Client.deleteCookies()
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    WebView {
        id: wv
        visible: false
        anchors.fill: parent
        onTitleChanged: {
            console.log(wv.url)
            console.log(wv.title)
            if (wv.title.indexOf("Success code=")!=-1) {
                console.log("Got the code!")
                console.log(wv.title.substring(wv.title.indexOf("Success code=")+13))
                wv.visible = false
                infotext.visible = true
                loginIndicator.visible = true
                Client.sendAuthCode(wv.title.substring(wv.title.indexOf("Success code=")+13))
            }
        }
    }
}


