#include <QApplication>
#include <QMainWindow>
#include <QLabel>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QMainWindow window;
    window.setWindowTitle("DataTool");
    window.setCentralWidget(new QLabel("DataTool", &window));
    window.resize(800, 600);
    window.show();

    return app.exec();
}
