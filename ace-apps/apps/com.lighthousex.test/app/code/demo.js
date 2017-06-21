import { UIViewController } from '@zitao/lighthousex-ios';

export class Demo extends UIViewController {
  viewDidLoad() {

  }

  static get creationOptions() {
    return {
      storyboardName: 'Main',
      storyboardIdentifier: 'Demo',
    };
  }
}
