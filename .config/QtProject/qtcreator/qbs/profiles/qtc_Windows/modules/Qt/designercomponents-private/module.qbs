import qbs 1.0
import '../QtModule.qbs' as QtModule

QtModule {
    qtModuleName: "DesignerComponents"
    Depends { name: "Qt"; submodules: ["core", "gui-private", "widgets-private", "designer-private"]}

    hasLibrary: true
    staticLibsDebug: []
    staticLibsRelease: []
    dynamicLibsDebug: []
    dynamicLibsRelease: ["/usr/lib/libQt5Designer.so.5.4.1", "/usr/lib/libQt5Widgets.so.5.4.1", "/usr/lib/libQt5Gui.so.5.4.1", "/usr/lib/libQt5Xml.so.5.4.1", "/usr/lib/libQt5Core.so.5.4.1", "pthread"]
    linkerFlagsDebug: []
    linkerFlagsRelease: []
    frameworksDebug: []
    frameworksRelease: []
    frameworkPathsDebug: []
    frameworkPathsRelease: []
    libNameForLinkerDebug: "Qt5DesignerComponents"
    libNameForLinkerRelease: "Qt5DesignerComponents"
    libFilePathDebug: ""
    libFilePathRelease: "/usr/lib/libQt5DesignerComponents.so.5.4.1"
    cpp.defines: ["QT_DESIGNERCOMPONENTS_LIB"]
    cpp.includePaths: ["/usr/include/qt", "/usr/include/qt/QtDesignerComponents", "/usr/include/qt/QtDesignerComponents/5.4.1", "/usr/include/qt/QtDesignerComponents/5.4.1/QtDesignerComponents"]
    cpp.libraryPaths: []
    
}
