#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "models/rulerModel.h"
#include "models/mapCache.h"

int main(int argc, char *argv[])
{
    RulerModel rulerModel;
    MapCache mapCache;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext* ctx = engine.rootContext();


    ctx->setContextProperty("rulerModel", &rulerModel);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *root = engine.rootObjects()[0];
    QObject::connect(root, SIGNAL(clearCache()),
                        &mapCache, SLOT(clearCacheSlot()));

    return app.exec();
}
