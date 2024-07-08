
//底部选项卡内容项
export interface TabBarItem{

  mode : TabBarMode;

  name : Resource;

  defaultIcon : Resource;

  selectedIcon : Resource;

}

export enum TabBarMode{
  Home,
  ShortForm,
  Mine
}

export const TabBarInfo : TabBarItem[] = [
  {
    mode : TabBarMode.Home,
    name : $r("app.string.Home"),
    defaultIcon : $r("app.media.home_default"),
    selectedIcon : $r("app.media.home_selected_pink")
  },
  {
    mode : TabBarMode.ShortForm,
    name : $r("app.string.ShortForm"),
    defaultIcon : $r("app.media.shortForm_default"),
    selectedIcon : $r("app.media.shortForm_selected_pink")
  },
  {
    mode : TabBarMode.Mine,
    name : $r("app.string.Mine"),
    defaultIcon : $r("app.media.mine_default"),
    selectedIcon : $r("app.media.mine_selected_pink")
  },
]