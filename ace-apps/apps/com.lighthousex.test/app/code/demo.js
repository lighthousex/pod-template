import Wat from '@zitao/lighthousex-ios-core';

const UIViewController = Wat.getNativeClass('UIViewController');
export class Demo extends UIViewController {
  viewDidLoad() {}

  static get creationOptions() {
    return {
      storyboardName: 'Main',
      storyboardIdentifier: 'Demo',
    };
  }
}
