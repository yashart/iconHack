import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Item {
    id: instruments
    property alias addPolylineButton: addPolylineButton
    property alias delPolylineButton: delPolylineButton
    property var http: 0

    ToolBar {
        ColumnLayout {
            anchors.fill: parent

            ToolButton {
                id: addPolylineButton
                text: qsTr("Paint border")
                checkable: true
                checked: false
                onClicked: {
                    if (checked == true){
                        text = qsTr("Cancel paint")
                    }else {
                        text = qsTr("Paint border")
                    }
                }
            }

            ToolButton {
                id: delPolylineButton
                text: qsTr("Delete point")
                checkable: false
                onClicked: {
                    rulerModel.delPoint();
                }
            }

            Timer {
                id: timerCache
                interval: 1500; running: false; repeat: false
                property var pointIndex: 0
                onTriggered: {
                    mapComponent.refresh_plugin();
                    mapComponent.refresh_map();
                }
            }

            Timer {
                id: movingTimer
                interval: 1500; running: false; repeat: true
                property var pointIndex: 0
                onTriggered: {
                    map.zoomLevel = 18
                    if (pointIndex == rulerModel.rulerList.length){
                        pointIndex = 0;
                        running = false;
                        http.send();
                    }
                    map.center = rulerModel.rulerList[pointIndex]
                    pointIndex += 1
                }

            }

            ToolButton {
                id: calcTrackButton
                text: qsTr("Find wholes")
                checkable: false
                onClicked: {
                    movingTimer.restart()
                    var latList = [];
                    var lonList = [];
                    for (var i=0; i < rulerModel.rulerList.length; i++){
                        latList.push(rulerModel.rulerList[i].latitude)
                        lonList.push(rulerModel.rulerList[i].longitude)
                    }

                    http = new XMLHttpRequest()
                    var url = "http://0.0.0.0:5000/";
                    var paramLats = "lat=[" + latList + "]"
                    var paramLongs = "lon=[" + lonList + "]"
                    var paramDetalisation = "detalisation=" + detalisationSlider.value
                    url = url + '?' + paramLats + '&' + paramLongs + '&' + paramDetalisation
                    http.open("GET", url, true);

                    http.onreadystatechange = function() { // Call a function when the state changes.
                                if (http.readyState == 4) {
                                    if (http.status == 200) {
                                        console.log("ok")
                                        timerCache.restart();
                                    } else {
                                        console.log("error: " + http.status)
                                    }
                                }
                            }
                }
            }



            ToolButton {
                id: freeCache
                text: qsTr("Clear map")
                checkable: false
                onClicked: {
                    clearCache();
                    timerCache.restart();
                }
            }

            ToolButton {
                id: refreshMap
                text: qsTr("Refresh map")
                checkable: false
                onClicked: {
                    timerCache.restart();
                }

            }
        }
    }

}
