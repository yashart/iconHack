#include "mapCache.h"
#include <QDebug>
#include <QDir>

void MapCache::clearCacheSlot(){
    clearTiles();
}

void MapCache::clearTiles(){
    QString path = "/home/yashart/.cache/QtLocation/5.8/tiles/mapbox";
    QDir dir(path);
    dir.setNameFilters(QStringList() << "*.*");
    dir.setFilter(QDir::Files);
    foreach(QString dirFile, dir.entryList())
    {
        dir.remove(dirFile);
    }
}
