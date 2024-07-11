import relationStore from '@ohos.data.relationalStore'
import { ValueType, ValuesBucket } from '@kit.ArkData'
import { RelationStoreConstant as constant } from '../constants/RelationStoreConstant'
import { User } from '../../model/UserModel'

class RelationStoreUtil{

  //数据库实例
  private relationDB : relationStore.RdbStore | null = null

  //载入关系型数据库示例
  async loadRdbStore(context: Context){
    let config: relationStore.StoreConfig = {
      name: constant.RELATION_STORE_NAME,
      securityLevel: constant.RELATION_STORE_SECURITY_LEVEL
    }
    try{
      this.relationDB = await relationStore.getRdbStore(context,config);
      console.log(`log:  数据库实例创建成功`)
    }catch(err){
      console.log(`log: 数据库实例创建失败`)
      console.error('error :',JSON.stringify(err))
    }
  }

  async createTable(SQL:string){
    if(!this.relationDB){
      console.log('log: 数据库未初始化,建表失败')
      return
    }
    try{
      await this.relationDB.executeSql(SQL)
      console.log(`log: 执行 \'${SQL}\'成功`)
    }catch(err){
      console.log(`执行 \'${SQL}\'失败`)
      console.error('log: error: ',JSON.stringify(err))
    }
  }

  //向表中插入数据
  async insertTable(tableName: string,value: ValuesBucket): Promise<relationStore.ValueType>{
    let id : relationStore.ValueType = -1
    if(!this.relationDB){
      console.log('log: 数据库未初始化')
      return id
    }
    try{
      id = await this.relationDB.insert(tableName,value)
      console.log('log: insert执行成功')
    }catch(err){
      console.log('log: insert执行失败')
      console.error('log: error: ',JSON.stringify(err))
    }
    return id
  }

  //获取表中的用户
  async queryUser(tableName: string): Promise<User[]>{
    let predicate = new relationStore.RdbPredicates(tableName)
    let users: User[] = []
    if (!this.relationDB) {
      console.log('log: 数据库未初始化')
      return users
    }
    try{
      let result = await this.relationDB?.query(predicate)
      console.log("log: 查询成功")
      while(result?.goToNextRow()){
        let id = result.getLong(result.getColumnIndex(constant.ID))
        let userName = result.getString(result.getColumnIndex(constant.USERNAME))
        let passWord = result.getString(result.getColumnIndex(constant.PASSWORD))
        let name = result.getString(result.getColumnIndex(constant.NAME))
        let phone = result.getString(result.getColumnIndex(constant.PHONE))
        let role = result.getLong(result.getColumnIndex(constant.ROLE))
        users.push({id,userName,passWord,name,phone,role})
        console.info(`date: ${id},${userName},${passWord},${name},${phone},${role}`)
      }
    }catch(err){
      console.log('log: 查询失败')
      console.error('error: ', JSON.stringify(err))
    }
    return users
  }

  //更新表中的数据
  async updateValue(tableName: string,id: number,value: ValuesBucket){
    let predicate = new relationStore.RdbPredicates(tableName)
    predicate.equalTo("ID",id);
    if (!this.relationDB) {
      console.log('log: 数据库未初始化')
      return
    }
    try{
      await this.relationDB.update(value,predicate)
      console.log('log: 更新数据成功')
    }catch(err){
      console.log('log: 更新数据失败')
      console.error('err: ',JSON.stringify(err))
    }
  }

  //根据ID删除表中对应数据
  async deleteValue(tableName: string,id: number){
    let predicate = new relationStore.RdbPredicates(tableName)
    predicate.equalTo("ID",id)
    if(!this.relationDB) {
      console.log('log: 数据库未初始化')
      return
    }
    try{
      this.relationDB.delete(predicate)
      console.log('log: 删除数据成功')
    }catch(err){
      console.log('log: 删除数据失败')
      console.error('err: ',JSON.stringify(err))
    }
  }

  databaseTableInfo(tableName: string){
    let predicate = new relationStore.RdbPredicates(tableName)
    if (!this.relationDB) {
      console.log('log: 数据库未初始化')
      return
    }
    try{
      this.relationDB.query(predicate).then((result) => {
        console.log('log: 单表数据获取成功')
        console.info(`info: 列数：${result.columnCount},行数: ${result.rowCount}`)
        console.info(`info: 列名：${result.columnNames}`)
      })
    }catch(err){
      console.log('log: 单表数据获取失败')
      console.error('error: ',JSON.stringify(err))
    }
  }

}

const relationStoreUtil : RelationStoreUtil = new RelationStoreUtil()
export default relationStoreUtil as RelationStoreUtil