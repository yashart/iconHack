#ifndef MAPCACHE_H
#define MAPCACHE_H
#include <QObject>

class MapCache : public QObject
{
    Q_OBJECT
public slots:
    void clearCacheSlot();
public:
    void clearTiles();
};

#endif // MAPCACHE_H
