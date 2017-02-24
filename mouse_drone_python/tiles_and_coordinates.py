import glob

ZOOM_DEFAULT = 18

def make_tiles_list(latList, lonList):
    filePath = "/home/yashart/.cache/QtLocation/5.8/tiles/mapbox/"
    namesList = glob.glob(filePath + "*.png")

    minLon = min(lonList)
    maxLon = max(lonList)
    minLat = min(latList)
    maxLat = max(latList)


    tilesList = []

    rowList = []
    columnList = []

    for name in namesList:
        oneNameList = name.split('-')
        if(int(oneNameList[2]) != ZOOM_DEFAULT):
            continue
        lon = (int(oneNameList[3])) * 360.0 / (2 ** ZOOM_DEFAULT) - 180
        lat = 180 - int(oneNameList[4]) * 360.0 / (2 ** ZOOM_DEFAULT) - 1.9155

        print lat, lon

        if(lon > minLon and lon < maxLon and lat > minLat and lat < maxLat):

            tilesList.append(name)

    return tilesList