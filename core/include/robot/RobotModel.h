#pragma once

#include "robot/DHParameters.h"

#include <cstddef>
#include <string>
#include <vector>

namespace robot
{
class RobotModel
{
public:
    RobotModel(std::string name, std::vector<DHParameters> joints);

    const std::string& name() const {return name_;}
    std::size_t jointCount() const {return joints_.size();}
    const std::vector<DHParameters>& joints() const {return joints_;}
    double jointAngle(std::size_t index) const;
    void setJointAngle(std::size_t index, double angle);
    void resetAngles();

    static RobotModel createRB6A();
    static RobotModel createRB6B();
    static RobotModel createRB6C();

private:
    std::string name_;
    std::vector<DHParameters> joints_;
    std::vector<double> initialAngles_;
};
}