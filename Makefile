include $(THEOS)/makefiles/common.mk

DEBUG = 0



ARCHS=arm64
TARGET=iphone:clang:10.2:9.0

TWEAK_NAME = YUNoPauseAudio
YUNoPauseAudio_FILES = Tweak.xm
YUNoPauseAudio_CFLAGS += -Wundeclared-selector

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
