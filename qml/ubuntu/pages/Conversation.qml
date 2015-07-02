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
import QtQuick.Layouts 1.1

import "../delegates"

Page {
    id: page
    objectName: "conversation"
    title: page.conversationName

    property string conversationId: ""
    property string conversationName: ""
    property string selfChatId;

    //    InfoBanner {
    //        id: ibanner
    //    }
    Item {
        id: ibanner
    }

    function loadConversationModel(cid) {
        Client.updateWatermark(cid)
        Client.setFocus(cid, 1)
        page.conversationName = Client.getConversationName(cid)
        page.selfChatId = Client.getSelfChatId()
        page.conversationId = cid;
        conversationModel.cid = cid;
        listView.positionViewAtEnd()
    }
    function openKeyboard() {
        listView.footerItem.openKeyboard()
    }

    ListView {
        //            PullDownMenu {
        //                MenuItem {
        //                    text: qsTr("Load more...")
        //                    onClicked: Client.retrieveConversationLog(page.conversationId)
        //                    }
        //            }

        id: listView
        model: conversationModel
        anchors {
            fill: parent
            bottomMargin: sendRow.height + units.gu(1)
            leftMargin: units.gu(1)
            rightMargin: units.gu(1)
        }
        clip: true
        delegate: ListItem {
            height: units.gu(6)
            Message { anchors.fill: parent }
        }
        /*
            PushUpMenu {
                    Text {
                        color: Theme.highlightColor
                        font.family: "cursive"
                        text: "Hello, Sailor!"
                    }
            }
        }
        */
    }

    RowLayout {
        id: sendRow
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: sendBox.height

        TextArea {
            objectName: "sendTextArea"
            id: sendBox
            focus: true
            font.family: "cursive"
            placeholderText: qsTr("Reply")
            property int typingStatus: 3
            onTextChanged: {
                //console.log("Text changed!")
                if (sendBox.text!=="" && typingStatus === 3) {
                    typingStatus = 1
                    Client.setTyping(page.conversationId, typingStatus)
                }
                if (sendBox.text==="" && typingStatus !== 3) {
                    typingStatus = 3
                    Client.setTyping(page.conversationId, typingStatus)
                }
            }

            function sendMessage() {
                if (sendBox.text.trim()==="") {
                    console.log("Empty message")
                    ibanner.displayError(qsTr("Can't send empty message"))
                    return
                }

                Client.sendChatMessage(sendBox.text.trim(), page.conversationId);
                sendBox.deselect();
                sendBox.text = "";
                sendBox.placeholderText = qsTr("Sending message...");
            }
            function sendImage(path) {
                sendButton.enabled = false
                Client.sendImage("foo", page.conversationId, path)
                sendBox.placeholderText = qsTr("Sending image...");
                sendBox.text = "";
                imagepicker.selected.disconnect(sendBox.sendImage)
            }
            function setOffline() {
                sendButton.enabled = false
                sendBox.placeholderText = "Offline"
            }
            function setOnline() {
                sendButton.enabled = true
                sendBox.placeholderText = "Reply"
            }
            function setSendError() {
                ibanner.displayError("Error sending msg")
                sendBox.placeholderText = "Reply"
            }
            function setIsTyping(id, convId, status) {
                console.log("is typing")
                console.log(id)
                console.log(convId)
                if (page.conversationId === convId) {
                    if (status === 1)
                        sendBox.placeholderText = id + qsTr(" is typing")
                    else if (status === 2)
                        sendBox.placeholderText = id + qsTr(" paused")
                    else if (status === 3)
                        sendBox.placeholderText = qsTr("Reply")
                }
            }


        }
        AbstractButton {
            id: sendButton
            //text: "send"
            Layout.preferredHeight: units.gu(6)
            Layout.preferredWidth: units.gu(6)
            Icon {
                anchors.fill: parent
                name: "go-next"
            }
            onClicked: sendBox.sendMessage()
            onPressAndHold: {
                //Workaround for rpm validator
                fileModel.searchPath = "foo"
                pageStack.push(imagepicker)
                imagepicker.selected.connect(sendBox.sendImage)
            }
        }
        Connections
        {
            target: Client
            onChannelLost: sendBox.setOffline()
            onChannelRestored: sendBox.setOnline()
            onIsTyping: sendBox.setIsTyping(uname, convid, status)
            onMessageSent: sendBox.setOnline()
            onMessageNotSent: sendBox.setSendError()
        }
        function openKeyboard() {
            sendBox.forceActiveFocus()
        }
    }
}
