ARCHS = armv7 armv7s arm64
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.0
THEOS_BUILD_DIR = debs
THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
GO_EASY_ON_ME = 1

DEBUG = 1

include theos/makefiles/common.mk

TWEAK_NAME = MLGiOS
MLGiOS_FILES = Tweak.xm VLMHarlemShake.m DankstormController.m VENSnowOverlayView.m FLAnimatedImage.m FLAnimatedImageView.m
MLGiOS_FRAMEWORKS = UIKit CoreGraphics QuartzCore AVFoundation ImageIO MobileCoreServices
MLGiOS_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += preferences

after-install::
	install.exec "killall -9 backboardd"
include $(THEOS_MAKE_PATH)/aggregate.mk
