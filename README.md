# Программные требования
- Компилятор с поддержкой g++20
- Cmake 3.21 или новее
- Qt 6.8 или новее
- Модули Qt: Core, Gui, Quick, QuickControl, Quick3D

# Сборка и запуск
- cmake -S . -B build -DBUILD_GUI=ON -DCMAKE_PREFIX_PATH="$HOME/Qt/6.12.1/gcc_64" , где $HOME/Qt/6.12.1/gcc_64 - путь до установленного Qt
- cmake --build build --parallel
- ./build/app/robot_app

# Структура проекта
- /core - Математическое ядро
- /app - Графическое приложение