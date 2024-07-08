
//底部选项卡内容项
export interface TabBarItem{

  id : number;

  name : Resource;

  defaultIcon : Resource;

  selectedIcon : Resource;

}

export const TabBarInfo : TabBarItem[] = [
  {
    id : 0,
    name : $r("app.string.Home"),
    defaultIcon : $r("app.media.placeholders_default"),
    selectedIcon : $r("app.media.placeholders_selected")
  },
  {
    id : 1,
    name : $r("app.string.Undefine"),
    defaultIcon : $r("app.media.placeholders_default"),
    selectedIcon : $r("app.media.placeholders_selected")
  },
  {
    id : 2,
    name : $r("app.string.Undefine"),
    defaultIcon : $r("app.media.placeholders_default"),
    selectedIcon : $r("app.media.placeholders_selected")
  },
]