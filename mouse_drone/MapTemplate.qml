import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6
import QtQuick.Controls 2.1
Map {
    id: map
    anchors.fill: parent
    plugin: mapComponent.plugin
    zoomLevel: 18
    center: QtPositioning.coordinate(32.5919, -81.8341)

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(mouse.button == Qt.LeftButton){
                if(instruments.addPolylineButton.checked == true){
                    rulerModel.addPoint(map.toCoordinate(Qt.point(mouseX, mouseY)));
                }
            }
        }
    }

    MapQuickItem {
        id: startRulerPoint
        anchorPoint.x: startRulerIcon.width / 2;
        anchorPoint.y: startRulerIcon.height / 2;
        coordinate: rulerModel.startPoint

        sourceItem: Image {
            id: startRulerIcon
            source: "qrc:/img/ruler/start.png"
        }
    }

    MapQuickItem {
        id: finishRulerPoint
        anchorPoint.x: finishRulerIcon.width / 2;
        anchorPoint.y: finishRulerIcon.height / 2;
        coordinate: rulerModel.finishPoint

        sourceItem:
            Column{
                Image {id: finishRulerIcon; source: "qrc:/img/ruler/finish.png"}
        }
    }

    MapPolyline {
        line.width: 2
        line.color: 'red'
        path: [
            rulerModel.finishPoint,
            rulerModel.startPoint
        ]
    }

    MapPolyline {
        line.width: 2
        line.color: 'red'
        path: rulerModel.rulerList
        smooth: true
    }
}
