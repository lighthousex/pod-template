import { default as Wat, setNativeLogLevel } from '@zitao/lighthousex-ios-core';
import { UIWindow } from '@zitao/lighthousex-ios';

import { Demo } from './demo';

async function AppAsyncInit() {
  const demo = new Demo();

  await UIWindow.hideAllModalPresentationViewController();
  const mainWindow = await UIWindow.mainWindow();
  await mainWindow.setRootViewController(demo);

  Wat.setupMenu();

  console.info('Load Finished');
}

export const AppInit = () => {
  console.log('initing');
  setNativeLogLevel('info');

  try {
    AppAsyncInit();
  } catch (err) {
    console.error(`init error: ${err}`);
  }
};

Wat.AppInit = AppInit;
