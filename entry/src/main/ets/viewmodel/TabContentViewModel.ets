import { TabBarInfo, TabBarItem } from '../model/TabContentModel'

export class TabContentViewModel {

  //底部导航栏信息
  private tabList: TabBarItem[] = TabBarInfo;

  //当前导航栏项
  currentIndex: number = 0;

  getTabInfo(): TabBarItem[] {
    return this.tabList
  }
}

export default new TabContentViewModel()