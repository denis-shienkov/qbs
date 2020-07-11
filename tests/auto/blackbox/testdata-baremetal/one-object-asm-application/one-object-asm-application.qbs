import "../BareMetalApplication.qbs" as BareMetalApplication

BareMetalApplication {
    condition: {
        if (qbs.toolchainType === "keil") {
            if (qbs.architecture.startsWith("arm"))
                return true;
            if (qbs.architecture === "mcs51")
                return true;
        } else if (qbs.toolchainType === "iar") {
            if (qbs.architecture === "mcs51")
                return true;
        } else if (qbs.toolchainType === "sdcc") {
            if (qbs.architecture === "mcs51")
                return true;
            if (qbs.architecture === "stm8")
                return true;
        } else if (qbs.toolchainType === "gcc") {
            if (qbs.architecture.startsWith("arm"))
                return true;
            if (qbs.architecture === "avr")
                return true;
            if (qbs.architecture === "msp430")
                return true;
        }
        console.info("unsupported toolset: %%"
            + qbs.toolchainType + "%%, %%" + qbs.architecture + "%%");
        return false;
    }

    Properties {
        condition: qbs.toolchainType === "gcc"
            && qbs.architecture === "msp430"
        // We need to use this workaround to enable
        // the cpp.driverFlags property.
        cpp.linkerPath: cpp.compilerPathByLanguage["c"]
    }

    files: [(qbs.architecture.startsWith("arm") ? "arm" : qbs.architecture)
                + "-" + qbs.toolchainType + ".s"]
}