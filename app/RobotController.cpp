#include "RobotController.h"

#include <robot/ForwardKinematics.h>
#include <robot/MathUtils.h>

#include <cmath>
#include <QVector3D>
#include <QQuaternion>
#include <QMatrix3x3>
#include <QVariant>

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
    
    for (const robot::DHParameters& joint : model_.joints())
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
    emit framesChanged();
}

void RobotController::setJointAngle(int index, double degrees)
{
    if (index < 0 || static_cast<std::size_t>(index) >= model_.jointCount() || !std::isfinite(degrees))
        return;

    const double radians = robot::degreesToRadians(degrees);

    if (!std::isfinite(radians))
        return;

    if (model_.jointAngle(index) == radians)
        return;

    model_.setJointAngle(index, radians);

    recalculate();

    emit jointAnglesChanged();
    emit tcpChanged();
    emit framesChanged();
}

void RobotController::resetAngles()
{
    model_.resetAngles();

    recalculate();

    emit jointAnglesChanged();
    emit tcpChanged();
    emit resetAngles();
}

void RobotController::recalculate()
{
    const std::vector<robot::Matrix4> transforms = robot::ForwardKinematics::calculateTransforms(model_.joints());
    tcp_ = transforms.back().translation();

    framePositions_.clear();
    frameRotations_.clear();

    framePositions_.reserve(transforms.size());
    frameRotations_.reserve(transforms.size());

    for (const robot::Matrix4& transform : transforms)
    {
        const robot::Vector3 position = transform.translation();

        const QVector3D qtPosition(
            static_cast<float>(position.x),
            static_cast<float>(position.y),
            static_cast<float>(position.z)
        );

        QMatrix3x3 rotationMatrix;
        for (int row = 0; row < 3; row++)
            for (int col = 0; col < 3; col++)
                rotationMatrix(row, col) = static_cast<float>(transform(row, col));
        
        const QQuaternion rotation = QQuaternion::fromRotationMatrix(rotationMatrix).normalized();

        framePositions_.append(QVariant::fromValue(qtPosition));
        frameRotations_.append(QVariant::fromValue(rotation));
    }
}