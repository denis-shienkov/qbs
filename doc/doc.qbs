import qbs 1.0

Product {
    name: "qbs documentation"
    builtByDefault: false
    type: "qch"
    Depends { name: "Qt.core" }
    Depends { name: "qbsbuildconfig" }
    Depends { name: "qbsversion" }

    files: [
        "../README",
        "classic.css",
        "external-resources.qdoc",
        "fixnavi.pl",
        "howtos.qdoc",
        "qbs.qdoc",
        "qbs-online.qdocconf",
        "config/*.qdocconf",
        "config/style/qt5-sidebar.html",
        "reference/**/*",
        "templates/**/*",
        "images/**",
    ]
    Group {
        name: "main qdocconf file"
        files: "qbs.qdocconf"
        fileTags: "qdocconf-main"
    }

    property string versionTag: qbsversion.version.replace(/\.|-/g, "")
    Qt.core.qdocEnvironment: [
        "QBS_VERSION=" + qbsversion.version,
        "SRCDIR=" + path,
        "QT_INSTALL_DOCS=" + Qt.core.docPath,
        "QBS_VERSION_TAG=" + versionTag
    ]

    Group {
        fileTagsFilter: ["qdoc-output"]
        qbs.install: qbsbuildconfig.installHtml
        qbs.installDir: qbsbuildconfig.docInstallDir
        qbs.installSourceBase: Qt.core.qdocOutputDir
    }
    Group {
        fileTagsFilter: ["qch"]
        qbs.install: qbsbuildconfig.installQch
        qbs.installDir: qbsbuildconfig.docInstallDir
    }
}
