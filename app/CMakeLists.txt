find_package(Qt6 6.8 REQUIRED COMPONENTS
    Core
    Gui
    Qml
    Quick
    QuickControls2
    QuickLayouts
)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(robot_app
    main.cpp
    RobotController.h
    RobotController.cpp
)

target_link_libraries(robot_app
    PRIVATE
    robot_core
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::QuickLayouts
)

qt_add_qml_module(robot_app
    URI RobotKinematics
    VERSION 1.0

    QML_FILES
        qml/Main.qml
)