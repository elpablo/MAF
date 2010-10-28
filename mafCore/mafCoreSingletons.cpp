/*
 *  mafCoreSingletons.cpp
 *  mafCore
 *
 *  Created by Paolo Quadrani on 27/03/09.
 *  Copyright 2009 B3C. All rights reserved.
 *
 *  See Licence at: http://tiny.cc/QXJ4D
 *
 */

#include "mafCoreSingletons.h"
#include "mafCoreRegistration.h"


using namespace mafCore;

void mafCoreSingletons::mafSingletonsInitialize() {
    mafObjectRegistry::instance();
    mafIdProvider::instance();
    mafObjectFactory::instance();
    mafMessageHandler::instance();
    mafCoreRegistration::registerCoreObjects();
}

void mafCoreSingletons::mafSingletonsShutdown() {
    mafMessageHandler::instance()->shutdown();
    mafObjectRegistry::instance()->shutdown();
    mafObjectFactory::instance()->shutdown();
    mafIdProvider::instance()->shutdown();
}

bool mafInitializeModule(mafString module_library) {
    typedef void mafFnInitModule();
    mafFnInitModule *initModule;

    mafLibrary *libraryHandler;

    libraryHandler = new mafLibrary(module_library);
    if(!libraryHandler->load()) {
        mafString err_msg(mafTr("Could not load '%1'").arg(module_library));
        mafMsgCritical("%s", err_msg.toAscii().constData());
        return false;
    }

    // Get the handle to the 'initializeModule' function
    initModule = reinterpret_cast<mafFnInitModule *>(libraryHandler->resolve("initializeModule"));
    if(!initModule) {
        mafString err_msg(mafTr("'%1' module can not be initialized!!").arg(module_library));
        mafMsgCritical("%s", err_msg.toAscii().constData());
        return false;
    }

    // ...and if no errors occourred, call the module initialization.
    initModule();
    return true;
}
