#ifndef MAINVIEW_H
#define MAINVIEW_H
#define APP_NAME "Express Python"

#include <cmath>
#include "Python.h"

// fremework
#include <QMessageBox>
#include <QTextStream>
#include <QFileDialog>
#include <QMainWindow>
#include <QInputDialog>
#include <QThread>
// internal
#include "CodeEditor/pythonsyntaxhighlighter.h"
#include "CodeEditor/codeeditor.h"
#include "Features/snippets.h"

namespace Ui {
class MainView;
}

class MainView : public QMainWindow {

    Q_OBJECT

public:
    explicit MainView(QWidget* parent = 0);
    ~MainView();
    QString GetInput();
    QString GetOutput();
    QString GetCode();
    void SetSnippets(Snippets* snip);
private slots:
    void on_btnRun_clicked();
    void on_fntCombo_currentFontChanged(const QFont& font);
    void on_cmbFontSize_currentIndexChanged(const QString& fontSize);
    void on_btnCodeClear_clicked();
    void on_btnInputClear_clicked();
    void on_btnOutputClear_clicked();
    void on_btnOutputOpen_clicked();
    void on_btnInputOpen_clicked();
    void on_btnCodeOpen_clicked();
    void on_btnOutputSave_clicked();
    void on_btnInputSave_clicked();
    void on_btnCodeSave_clicked();
    void on_btnCodeDatabase_clicked();
    void on_btnRunSnippet_clicked();
    void on_btnLoadSnippet_clicked();
    void on_btnRemoveSnippet_clicked();
    void on_btnAddSnippet_clicked();
    void on_btnAbout_clicked();
    void SetInput(QString txt);
    void SetOutput(QString txt);
    void SetCode(QString txt);
    void SetSearchRegex(QString txt);
    void WriteOutput(QString output);
    void StartPythonRun();
    void EndPythonRun();
    void on_btnUpdateSnippet_clicked();
    void on_btnRunOneLiner_clicked();

private:
    const QString FILETYPES_PYTHON = tr("Python Code (*.py);;All files (*.*)");
    const QString FILETYPES_OTHER = tr("Text files (*.txt);;All files (*.*)");
    QThread workerThread;
    Ui::MainView* ui;
    PythonSyntaxHighlighter* mHighlighter;
    PythonSyntaxHighlighter* mHighlighterOneLiner;
    QString mStartMe;
    QString mAbout;
    Snippets* mSnippets;
    void ChangeFontSize(QFont font, int size);
    void SetupHighlighter();
    void SaveFile(CodeEditor* codeEditor, const bool isPython = false);
    void BrowseAndLoadFile(CodeEditor* codeEditor, const bool isPython = false);
    QString LoadFile(const QString& fileName, bool& success);
    void LoadResources();
    void LoadSnippetsToCombo();
    void RunPythonCode(const QString& code);
    void LoadSettings();
    void SetupPython();
    bool Confirm(const QString& what);

signals:
    void operate(const QString&, const QString&);
};

#endif // MAINVIEW_H
