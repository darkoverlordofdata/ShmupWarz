include $(GNUSTEP_MAKEFILES)/common.make

FRAMEWORK_NAME = Artemis
VERSION = 1.0

Artemis_OBJC_FILES = ArtemisAspect.m \
						ArtemisBag.m \
						ArtemisBitSet.m \
						ArtemisComponent.m \
						ArtemisComponentManager.m \
						ArtemisComponentMapper.m \
						ArtemisComponentType.m \
						ArtemisEntity.m \
						ArtemisEntityManager.m \
						ArtemisEntitySystem.m \
						ArtemisManager.m \
						ArtemisWorld.m \
						systems/ArtemisEntityProcessingSystem.m 

Artemis_HEADER_FILES = ArtemisAspect.h \
						ArtemisBag.h \
						ArtemisBitSet.h \
						ArtemisComponent.h \
						ArtemisComponentManager.h \
						ArtemisComponentMapper.h \
						ArtemisComponentType.h \
						ArtemisEntity.h \
						ArtemisEntityManager.h \
						ArtemisEntityObserver.h \
						ArtemisEntitySystem.h \
						ArtemisImmutableBag.h \
						ArtemisManager.h \
						ArtemisWorld.h \
						systems/ArtemisEntityProcessingSystem.h \
						ObjectiveCExtensions/ArtemisWorld_Debug.h \
						ObjectiveCExtensions/ObjectiveCGenerics.h


GUI_LIB =

-include GNUmakefile.preamble

include $(GNUSTEP_MAKEFILES)/framework.make

-include GNUmakefile.postamble
