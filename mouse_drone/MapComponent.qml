import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Item {
    id: mapComponent
    property var plugin: Qt.createComponent("MapPlugin.qml").createObject(mapComponent)
    property var map: Qt.createComponent("MapTemplate.qml").createObject(mapComponent)
    property alias detalisationSlider: detalisationSlider

    Rectangle {
        height: parent.height * 0.12
        width: parent.width * 0.12
        x: parent.width * 0.04
        y: parent.height * 0.24
        z: 2
        color: "#3465ba"
        ColumnLayout {
            anchors.fill: parent
            Label {
                id: debugLonText
                text: qsTr("detalization level:")
                font.bold: false
                font.family: "Times New Roman"
                font.pointSize: 14
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                elide: Text.ElideMiddle
                color: "#000000"

            }
            Slider {
                id: detalisationSlider
                maximumValue: 1.0
                stepSize: 0.05
                value: 0.65
                height: mapComponent.height * 0.1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                width: mapComponent.width * 0.1
            }
        }
    }

    Instruments {
        id: instruments
        height: parent.height * 0.1
        width: parent.width * 0.1
        z: 2
        x: parent.width * 0.05
        y: parent.height * 0.75
    }

    function refresh_map() {
        var zoomLevel = null;
        var center = null;
        if (map) {
            zoomLevel = map.zoomLevel;
            center = map.center;
            map.destroy();
        }
        map = Qt.createComponent("MapTemplate.qml");
        map = map.createObject(mapComponent);
        console.log(map);

        if (zoomLevel != null) {
            map.zoomLevel = zoomLevel
            map.center = center
        } else {
            map.zoomLevel = (map.maximumZoomLevel - map.minimumZoomLevel)/2
        }

        map.forceActiveFocus();
    }

    function refresh_plugin() {
        if(plugin){
            plugin.destroy();
        }
        plugin = Qt.createComponent("MapPlugin.qml").createObject(mapComponent)
    }
}
