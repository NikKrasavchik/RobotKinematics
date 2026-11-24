#pragma once

#include <robot/RobotModel.h>
#include <robot/Vector3.h>

#include <QObject>
#include <QStringList>
#include <QVariantList>

class RobotController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList modelNames READ modelNames CONSTANT);
    Q_PROPERTY(int currentModelIndex READ currentModelIndex NOTIFY modelChanged);
    Q_PROPERTY(QVariantList jointAngles READ jointAngles NOTIFY jointAnglesChanged);
    Q_PROPERTY(double tcpX READ tcpX NOTIFY tcpChanged);
    Q_PROPERTY(double tcpY READ tcpY NOTIFY tcpChanged);
    Q_PROPERTY(double tcpZ READ tcpZ NOTIFY tcpChanged);

public:
    explicit RobotController(QObject* parent = nullptr);

    QStringList modelNames() const;
    int currentModelIndex() const {return currentModelIndex_;}
    QVariantList jointAngles() const;
    double tcpX() const {return tcp_.x;}
    double tcpY() const {return tcp_.y;}
    double tcpZ() const {return tcp_.z;}

    Q_INVOKABLE void selectModel(int index);
    Q_INVOKABLE void setJointAngle(int index, double degrees);
    Q_INVOKABLE void resetAngles();

signals:
    void modelChanged();
    void jointAnglesChanged();
    void tcpChanged();

private:
    robot::RobotModel model_;
    robot::Vector3 tcp_;
    int currentModelIndex_ = 0;

    void recalculate();
};