import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "MultimediaWidgets"
    Depends { name: "Qt"; submodules: ["core", "gui", "multimedia", "widgets"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Multimedia.so.5.4.0", "/usr/lib/libQt5Widgets.so.5.4.0", "/usr/lib/libQt5Gui.so.5.4.0", "/usr/lib/libQt5Network.so.5.4.0", "/usr/lib/libQt5Core.so.5.4.0", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5MultimediaWidgets"
    libNameForLinkerRelease: "Qt5MultimediaWidgets"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5MultimediaWidgets.so.5.4.0"
    cpp.defines: ["QT_MULTIMEDIAWIDGETS_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtMultimediaWidgets"]
    cpp.libraryPaths: []
    
}
