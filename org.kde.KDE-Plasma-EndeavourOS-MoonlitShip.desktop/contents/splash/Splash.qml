import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {
    id: root
    source: "images/background.png"
    fillMode: Image.PreserveAspectCrop
    
    property int stage
    
    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
            preOpacityAnimation.from = 0;
            preOpacityAnimation.to = 1;
            preOpacityAnimation.running = true;
        }
        if (stage == 4) {
            preOpacityAnimation.from = 1;
            preOpacityAnimation.to = 0;
            preOpacityAnimation.running = true;
            pausa.start();
        }
    }

    Item {
        id: content
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        opacity: 1
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            property real size: units.gridUnit * 12
            anchors.centerIn: parent
            source: "images/KDE_Plasma_5_banner.png"
            sourceSize.width: size
            sourceSize.height: size
        }
    }

        Text {
            id: date
            text:Qt.formatDateTime(new Date(),"dddd, hh:mm")
            font.pointSize: 32
            color: "#50BAD0"
            opacity:0.85
            font { family: "OpenSans Light"; weight: Font.Light ;capitalization: Font.Capitalize}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 2.7
        }
        
    Image {
        id: topRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height
        source: "images/rectangle.svg"
        Rectangle {
            y: 232
            radius: 0
            anchors.horizontalCenterOffset: 0
            color: "#006A80"
            anchors {
                bottom: parent.bottom
                bottomMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
            height: 2
            width: height*150
            Rectangle {
                id: topRectRectangle
                radius: 1
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 0.01)
                color: "#e3faff"
                Behavior on width {
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    SequentialAnimation {
        id: introAnimation
        running: false

        ParallelAnimation {
            PropertyAnimation {
                property: "y"
                target: topRect
                to: ((root.height / 3) * 2) - 170
                duration: 1500
                easing.type: Easing.InOutBack
                easing.overshoot: 1.0
            }
            
        }
    }

    Text {
        id: preLoadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "EndeavourOS"
        color: "#e3faff"
        font.family: webFont.name
        font.weight: Font.ExtraLight

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: (root.height / 3) * 2
    }
    
    OpacityAnimator {
        id: preOpacityAnimation
        running: false
        target: preLoadingText
        from: 0
        to: 1
        duration: 700
        easing.type: Easing.InOutQuad
    }
    
    Text {
        id: loadingText
        height: 30
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        text: "KDE Plasma"
        color: "#e3faff"
        font.family: webFont.name
        font.weight: Font.ExtraLight

        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
        x: (root.width - width) / 2
        y: (root.height / 3) * 2
    }

    OpacityAnimator {
        id: opacityAnimation
        running: false
        target: loadingText
        from: 0
        to: 1
        duration: 1500
        easing.type: Easing.InOutQuad
        paused: true
    }

    Timer {
        id: pausa
        interval: 1500; running: false; repeat: false;
        onTriggered: root.viewLoadingText();
    }

    function viewLoadingText() {
        opacityAnimation.from = 0;
        opacityAnimation.to = 1;
        opacityAnimation.running = true;
    }

}
