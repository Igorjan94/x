import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "QuickWidgets"
    Depends { name: "Qt"; submodules: ["core", "gui", "qml", "quick", "widgets"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Quick.so.5.4.0", "/usr/lib/libQt5Widgets.so.5.4.0", "/usr/lib/libQt5Gui.so.5.4.0", "/usr/lib/libQt5Qml.so.5.4.0", "/usr/lib/libQt5Network.so.5.4.0", "/usr/lib/libQt5Core.so.5.4.0", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5QuickWidgets"
    libNameForLinkerRelease: "Qt5QuickWidgets"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5QuickWidgets.so.5.4.0"
    cpp.defines: ["QT_QUICKWIDGETS_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtQuickWidgets"]
    cpp.libraryPaths: []
    
}
