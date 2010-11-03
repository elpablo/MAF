/*
 *  mafUILoaderTest.cpp
 *  mafGUITest
 *
 *  Created by Paolo Quadrani on 26/10/10.
 *  Copyright 2010 B3C. All rights reserved.
 *
 *  See Licence at: http://tiny.cc/QXJ4D
 *
 */

#include <mafTestSuite.h>
#include <mafCoreSingletons.h>
#include <mafContainerInterface.h>
#include <mafEventBusManager.h>
#include <mafUILoader.h>
#include <QDebug>

using namespace mafCore;
using namespace mafEventBus;
using namespace mafGUI;

/**
  Class Name: testmafUILoaderCustom
  Custom UILoader for testing mafUILoader interface.
*/
class testmafUILoaderCustom : public mafUILoader {
    Q_OBJECT

public:
    ///object constructor
    testmafUILoaderCustom();
    /// method for load the file
    /*virtual*/ void uiLoad(const mafString& fileName);
    /// check if gui is loaded
    bool isUILoaded(mafContainerInterfacePointer guiWidget) {
        return m_IsUILoaded;
    }

public slots:
   ///return a value when the gui is loaded
   void uiLoaded();

private:
     bool m_IsUILoaded;///< variable which represents if the ui is loaded
};

testmafUILoaderCustom::testmafUILoaderCustom() : mafUILoader(), m_IsUILoaded(false) {
    mafRegisterLocalCallback("maf.local.gui.uiloaded", this, "uiLoaded(mafCore::mafContainerInterfacePointer)");
}

void testmafUILoaderCustom::uiLoad(const mafString& fileName) {
    REQUIRE(!fileName.isEmpty());
    mafMsgDebug() << "ui loader load method...";
    mafEventBusManager::instance()->notifyEvent("maf.local.gui.uiloaded", mafEventTypeLocal);
}

void testmafUILoaderCustom::uiLoaded() {
    mafMsgDebug() << "ui loaded";
    m_IsUILoaded = true;
}

/**
 Class name: mafUILoaderTest
 This class implements the test suite for mafUILoader.
 */
class mafUILoaderTest : public QObject {
    Q_OBJECT

private slots:
    /// Initialize test variables
    void initTestCase() {
        mafMessageHandler::instance()->installMessageHandler();
        m_UILoader = new testmafUILoaderCustom();
    }

    /// Cleanup test variables memory allocation.
    void cleanupTestCase() {
        if(m_UILoader) {
            delete m_UILoader;
            m_UILoader = NULL;
        }
    }

    /// mafUILoader allocation test case.
    void mafUILoaderAllocationTest();

    /// mafUILoader allocation test case.
    void mafUILoaderUILoadTest();

private:
    testmafUILoaderCustom *m_UILoader; ///< Reference to the GUI Manager.
};

void mafUILoaderTest::mafUILoaderAllocationTest() {
    QVERIFY(m_UILoader != NULL);
}

void mafUILoaderTest::mafUILoaderUILoadTest() {
    m_UILoader->uiLoad("uiFileName");
    QVERIFY(m_UILoader->isUILoaded(NULL) == true);
}

MAF_REGISTER_TEST(mafUILoaderTest);
#include "mafUILoaderTest.moc"
