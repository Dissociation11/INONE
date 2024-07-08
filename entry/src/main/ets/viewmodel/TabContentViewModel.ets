import { TabBarInfo, TabBarItem } from '../model/TabContentModel'

export class TabContentViewModel{

  private tabList : TabBarItem[] = TabBarInfo;
  currentIndex : number = 0;

  getTabInfo() : TabBarItem[] {
    return this.tabList
  }

}

enum TabBar{

}

export default new TabContentViewModel()