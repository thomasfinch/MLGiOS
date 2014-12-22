ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = MLGiOS
MLGiOS_FILES = MLGiOS.mm
MLGiOS_INSTALL_PATH = /Library/PreferenceBundles
MLGiOS_FRAMEWORKS = UIKit
MLGiOS_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MLGiOS.plist$(ECHO_END)
