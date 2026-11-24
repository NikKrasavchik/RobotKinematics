#include "RobotController.h"

#include <robot/ForwardKinematics.h>
#include <robot/MathUtils.h>

#include <cmath>

RobotController::RobotController(QObject* parent)
    : QObject(parent), model_(robot::RobotModel::createRB6A())
{
    recalculate();
}

QStringList RobotController::modelNames() const
{
    return {"RB-6A", "RB-6B", "RB-6C"};
}

QVariantList RobotController::jointAngles() const
{
    QVariantList angles;
    
    for (const auto& joint : model_.joints())
        angles.append(robot::radiansToDegrees(joint.theta));

    return angles;
}

void RobotController::selectModel(int index)
{
    if (index == currentModelIndex_)
        return;

    switch (index)
    {
    case 0:
        model_ = robot::RobotModel::createRB6A();
        break;

    case 1:
        model_ = robot::RobotModel::createRB6B();
        break;

    case 2:
        model_ = robot::RobotModel::createRB6C();
        break;

    default:
        return;
    }

    currentModelIndex_ = index;

    recalculate();

    emit modelChanged();
    emit jointAnglesChanged();
    emit tcpChanged();
}

void RobotController::setJointAngle(int index, double degrees)
{
    if (index < 0 || static_cast<std::size_t>(index) >= model_.jointCount() || !std::isfinite(degrees))
        return;

    const double radians = robot::degreesToRadians(degrees);

    if (model_.jointAngle(index) == radians)
        return;

    model_.setJointAngle(index, radians);

    recalculate();

    emit jointAnglesChanged();
    emit tcpChanged();
}

void RobotController::resetAngles()
{
    model_.resetAngles();

    recalculate();

    emit jointAnglesChanged();
    emit tcpChanged();
}

void RobotController::recalculate()
{
    tcp_ = robot::ForwardKinematics::calculateTCP(model_.joints());
}