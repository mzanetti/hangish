# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
QT += dbus network quick qml
#include(notifications.pri)
#include(keepalive.pri)

TARGET = harbour-hangish

CONFIG += sailfishapp c++11

system(qdbusxml2cpp harbour.hangish.xml -i notifier.h -a adaptor)

SOURCES += src/Hangish.cpp \
    #authenticator.cpp \
    client.cpp \
    channel.cpp \
    conversationmodel.cpp \
    rostermodel.cpp \
    utils.cpp \
    contactsmodel.cpp \
    notifier.cpp \
    filemodel.cpp \
    messagefield.cpp \
    adaptor.cpp \
    oauth2auth.cpp

OTHER_FILES += \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    translations/*.ts \
    qml/pages/Conversation.qml \
    qml/pages/Roster.qml \
    qml/pages/FullscreenImage.qml \
    qml/pages/ImagePicker.qml \
    qml/pages/InfoBanner.qml \
    qml/delegates/Message.qml \
    qml/delegates/RosterDelegate.qml \
    harbour.hangish.xml \
    harbour-hangish.desktop \
    rpm/harbour-hangish.spec \
    rpm/harbour-hangish.yaml \
    qml/harbour-hangish.qml \
    qml/pages/About.qml \
    rpm/harbour-hangish.changes

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
#TRANSLATIONS += translations/Hangish-de.ts

HEADERS += \
    #authenticator.h \
    client.h \
    channel.h \
    qtimports.h \
    conversationmodel.h \
    rostermodel.h \
    utils.h \
    structs.h \
    contactsmodel.h \
    notifier.h \
    filemodel.h \
    messagefield.h \
    adaptor.h \
    oauth2auth.h

RESOURCES += \
    harbour-hangish.qrc \
    ubuntu-hangish.qrc
