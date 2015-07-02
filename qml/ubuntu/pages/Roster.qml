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
import Ubuntu.Components  1.2

import "../delegates"

Page {
    id: page
    objectName: "roster"
    title: qsTr("Conversations")

    head {
        actions: [
            Action {
                text: qsTr("About Hangish")
                iconName: "info"
                onTriggered: pageStack.push(about)
            },
            Action {
                text: qsTr("Log out and exit")
                iconName: "close"
                onTriggered: Client.deleteCookies()
            }
        ]
    }

    //    onStatusChanged: {
    //        console.log(page.status)
    //        if (page.status==2) {
    //            Client.setFocus(conversationModel.cid, 2)
    //            console.log("Resetting conv")
    //            conversationModel.cid = ""
    //        }
    //     }

    ListView {

        id: listView
        model: rosterModel
        anchors.fill: parent
        delegate: RosterDelegate {
            onClicked: {
                console.log("Clicked " + id)
                var conversation = pageStack.push(Qt.resolvedUrl("Conversation.qml"))
                conversation.loadConversationModel(id);
                rosterModel.readConv = id;
                pageStack.push(conversation);
            }
        }
    }
    Connections {
        target: Client
        onNotificationPushed: {
            console.log("Clicked " + convId)
            if (convId!="foo") {
                conversation.loadConversationModel(convId);
                rosterModel.readConv = convId;
                if (pageStack.depth==1)
                    pageStack.push(conversation);
            }
            activate()
        }
    }

    Connections {
        target: listView.model
        onDataChanged: {
            //console.log("Changing data")
        }
    }
}



