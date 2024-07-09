
//空行组件
@Component
export struct Spacer{

  spaceHeight : Length = 0
  spaceWidth : Length = 0

  build(){
    Blank().size({ height : this.spaceHeight, width : this.spaceWidth })
  }
}