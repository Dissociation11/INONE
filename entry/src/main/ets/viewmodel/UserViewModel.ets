import PreferenceUtil from '../commons/utils/preferenceUtil'
import { PreferenceConstant } from '../commons/constants/PreferenceConstant'
import { User } from '../model/UserModel'
import { ValuesBucket } from '@kit.ArkData'
import RelationStoreUtil from '../commons/utils/RelationStoreUtil'
import { RelationStoreConstant }from '../commons/constants/RelationStoreConstant'
import { Prompt } from '@kit.ArkUI'

export class UserViewModel{

  //用户是否登录
  isLogin : boolean = false

  currentUser: User|null = null

  initViewModel(){
    PreferenceUtil.hasKey(PreferenceConstant.ISLOGIN).then((isExist) => {
      if(isExist){
        PreferenceUtil.getPreferenceValue(PreferenceConstant.ISLOGIN, false).then((value) => {
          this.isLogin = value as boolean
          console.info(`info: isLogin is ${value.toString()}`)
        })
      }else{
        PreferenceUtil.putPreferenceValue(PreferenceConstant.ISLOGIN,false)
        console.info('info: create isLogin preference')
      }
    })
  }

  async signOut(){
    this.isLogin = !this.isLogin
    console.debug(`debug: ${this.isLogin}`)
    PreferenceUtil.putPreferenceValue(PreferenceConstant.ISLOGIN,this.isLogin)
  }


  async login(username: string, password: string){
    let user = await RelationStoreUtil.queryUserByUsername(RelationStoreConstant.USER_TABLE_NAME,username)
    if(user.phone.length == 0){
      Prompt.showToast({message: `登录失败，用户${user.userName}不存在`})
      console.log('log: 登录失败，用户不存在')
      return false
    }else if(user.passWord == password){
      this.isLogin = true
      this.currentUser = user
      PreferenceUtil.putPreferenceValue(PreferenceConstant.ISLOGIN,this.isLogin)
      console.log('log: 登录成功')
      return true
    }else{
      Prompt.showToast({message: '登录失败,密码错误'})
      console.log('log: 登录失败,密码错误')
      return false
    }
  }

  async register(value: ValuesBucket){
    RelationStoreUtil.insertTable(RelationStoreConstant.USER_TABLE_NAME,value).then(()=> {
      console.log('log: 注册成功')
    })
  }

}

const userModel : UserViewModel = new UserViewModel()
export default userModel