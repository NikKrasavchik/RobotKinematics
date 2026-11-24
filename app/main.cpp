#include "RobotController.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    RobotController controller;
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("controller", &controller);
    engine.loadFromModule("RobotKinematics", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}