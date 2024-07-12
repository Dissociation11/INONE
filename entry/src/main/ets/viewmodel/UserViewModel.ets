import PreferenceUtil from '../commons/utils/preferenceUtil'
import { PreferenceConstant } from '../commons/constants/PreferenceConstant'
import { User } from '../model/UserModel'
import http from '@ohos.net.http';
import { ValuesBucket } from '@kit.ArkData'
import RelationStoreUtil from '../commons/utils/RelationStoreUtil'
import { RelationStoreConstant }from '../commons/constants/RelationStoreConstant'
import { Prompt } from '@kit.ArkUI'

export class UserViewModel {

  //用户是否登录
  isLogin: boolean = false
  currentUser: User | null = null
  currentUserId : number = -1
  private baseUrl = 'http://10.33.34.177:8800/admin/sysUser'
  private loginUrl = '/login'
  private registerUrl = '/register'

  initViewModel() {
    PreferenceUtil.hasKey(PreferenceConstant.IS_LOGIN).then((isExist) => {
      if (isExist) {
        PreferenceUtil.getPreferenceValue(PreferenceConstant.IS_LOGIN, false).then((value) => {
          this.isLogin = value as boolean
          console.info(`info: isLogin is ${value.toString()}`)
        })
      } else {
        PreferenceUtil.putPreferenceValue(PreferenceConstant.IS_LOGIN, false)
        console.info('info: create isLogin preference')
      }
    })
    PreferenceUtil.hasKey(PreferenceConstant.USER_ID).then((isExist) => {
      if (isExist) {
        PreferenceUtil.getPreferenceValue(PreferenceConstant.USER_ID, -1).then((value) => {
          this.currentUserId = value as number
          console.info(`info: currentUserId is ${value.toString()}`)
          try{
            RelationStoreUtil.queryUserById(RelationStoreConstant.USER_TABLE_NAME, this.currentUserId).then((user) => {
              this.currentUser = user
            })
          }catch(err){
            console.log('err: ',JSON.stringify(err))
          }
        })
      } else {
        PreferenceUtil.putPreferenceValue(PreferenceConstant.USER_ID, -1)
        console.info('info: create isLogin preference')
      }
    })
  }

  async signOut() {
    this.isLogin = false
    this.currentUserId = -1
    this.currentUser = null
    console.debug(`debug: ${this.isLogin}`)
    PreferenceUtil.putPreferenceValue(PreferenceConstant.IS_LOGIN, this.isLogin)
    PreferenceUtil.putPreferenceValue(PreferenceConstant.USER_ID,this.currentUserId)
  }


  async login(username: string, password: string) {
    let user = await RelationStoreUtil.queryUserByUsername(RelationStoreConstant.USER_TABLE_NAME, username)
    if (user.phone.length == 0) {
      Prompt.showToast({ message: `登录失败，用户${user.userName}不存在` })
      console.log('log: 登录失败，用户不存在')
      return false
    } else if (user.passWord == password) {
      this.isLogin = true
      this.currentUserId = user.id
      this.currentUser = user
      PreferenceUtil.putPreferenceValue(PreferenceConstant.IS_LOGIN, this.isLogin)
      PreferenceUtil.putPreferenceValue(PreferenceConstant.USER_ID, this.currentUserId)
      console.log('log: 登录成功')
      return true
    } else {
      Prompt.showToast({ message: '登录失败,密码错误' })
      console.log('log: 登录失败,密码错误')
      return false
    }
  }

  async remoteLogin(username: string, password: string) {
    let flag = false;
    try {
      let httpResponse = await http.createHttp().request(
        this.baseUrl + this.loginUrl,
        {
          method: http.RequestMethod.POST,
          header: { 'Content-Type': 'application/json' },
          extraData: {
            'username': username,
            'password': password
          }
        })
      if (httpResponse.responseCode == 200) {
        flag = true
        console.log('log: 正确响应' + httpResponse.responseCode)
      } else {
        console.log('log: 错误响应' + httpResponse.responseCode)
      }
    } catch (err) {
      console.error('err: ', JSON.stringify(err))
    }
    console.log('log: ' + flag)
    return flag
  }

  async register(value: ValuesBucket) {
    RelationStoreUtil.insertTable(RelationStoreConstant.USER_TABLE_NAME, value).then(() => {
      console.log('log: 注册成功')
    })
  }

  async remoteRegister(username: string, password: string, phone: string) {
    let flag = false
    try {
      let httpResponse = await http.createHttp().request(
        this.baseUrl + this.registerUrl,
        {
          method: http.RequestMethod.POST,
          header: { 'Content-Type': 'application/json' },
          extraData: {
            'username': username,
            'password': password,
            'name': username,
            'phone': phone,
            'role': 1
          }
        })
      if (httpResponse.responseCode == 200) {
        flag = true
        console.log('log: 正确响应' + httpResponse.responseCode)
      } else {
        console.log('log: 错误响应' + httpResponse.responseCode)
      }
    } catch (err) {
      console.error('err: ', JSON.stringify(err))
    }
    console.log('log: ' + flag)
    return flag
  }
  
}

const userModel : UserViewModel = new UserViewModel()
export default userModel