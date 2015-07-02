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
import "pages"

MainView
{
    width: units.gu(40)
    height: units.gu(70)

    Component.onCompleted: {
        pageStack.push(Qt.resolvedUrl("pages/FirstPage.qml"))
    }

    PageStack {
        anchors.fill: parent
        id: pageStack
    }


//    Conversation {
//            id: conversation
//        }

//    Roster {
//            id: roster
//    }

//    FullscreenImage {
//            id: fsImage
//    }

//    ImagePicker {
//            id: imagepicker
//    }

//    About {
//        id: about
//    }


    Connections {
        target: Qt.application
        onActiveChanged: {
            if(!Qt.application.active) {
                // Pauze the game here
                console.log("app paused")
                if (conversationModel.cid != "")
                    Client.setFocus(conversationModel.cid, 2)
                Client.setAppPaused()
            }
            else {
                console.log("app opened")
                if (conversationModel.cid != "")
                    Client.setFocus(conversationModel.cid, 1)
                Client.setAppOpened()
            }
        }
    }

}

