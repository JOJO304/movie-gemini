<template>
  <el-container>
    <el-header>
      <div class="header-inner">
        <a href="/welcome" class="logo">
        </a>
        <el-menu
            :default-active="activeUrl"
            class="nav-menu"
            mode="horizontal"
            :router="true"
            active-text-color="#409EFF"
            text-color="#000000">
          <el-menu-item :index="item.path" v-for="item in menuList" :key="item.id">{{item.name}}</el-menu-item>
        </el-menu>
        <div class="searchContainer">
          <el-input v-model="kw" class="searchBar" placeholder="搜索电影"></el-input>
          <el-button id="searchBtn" icon="el-icon-search" type="primary" circle @click="search"></el-button>
        </div>
        <el-dropdown @command="handleCommand">
          <span class="el-dropdown-link">
            <el-avatar :src="url" :size="50">{{url === '' || url === null ? 'user': ''}}</el-avatar>
            <i class="el-icon-arrow-down el-icon--right icon-arrow"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="userMenu" v-if="isToken">个人中心</el-dropdown-item>
            <el-dropdown-item command="logout" v-if="isToken">退出</el-dropdown-item>
            <el-dropdown-item command="login" v-if="!isToken">登录</el-dropdown-item>
            <el-dropdown-item command="register" v-if="!isToken">注册账号</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </el-header>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>

<script>
// 1. 引入axios，解决接口请求报错
import axios from 'axios'

export default {
  name: "Welcome",
  data() {
    return {
      isToken: '',
      cinemaInfo: '',
      url: '',
      activeUrl: this.$route.path.substring(0, this.$route.path.indexOf('/',1) === -1 ? this.$route.path.length : this.$route.path.indexOf('/',1)),
      menuList: [
        {
          id: 1,
          name: '首页',
          path: '/home'
        },
        {
          id: 4,
          name: '关于我们',
          path: '/aboutUs'
        }
      ],
      kw: '',
      // 2. 定义全局base地址，解决global.base未定义
      baseUrl: 'http://localhost:8181'
    }
  },
  created() {
    this.getCinemaInfo()
    this.isToken = window.sessionStorage.getItem("token") || ''
    // 3. 完整错误处理，解决loginUser不存在报错
    try {
      const loginUserStr = window.sessionStorage.getItem('loginUser')
      if (!loginUserStr) return
      
      const loginUser = JSON.parse(loginUserStr)
      if (!loginUser?.userPicture) return
      
      const userPicture = JSON.parse(loginUser.userPicture)
      if (userPicture === null || userPicture.length === 0) return
      
      this.url = this.baseUrl + userPicture[0]
    } catch (e) {
      console.error('解析用户头像失败:', e)
      this.url = ''
    }
  },
  watch: {
    '$route'() {
      this.activeUrl = this.$route.path.substring(0, this.$route.path.indexOf('/',1) === -1 ? this.$route.path.length : this.$route.path.indexOf('/',1))
    }
  },
  methods: {
    async getCinemaInfo(){
      try {
        // 4. 配置完整接口地址，解决axios请求失败
        const resp = await axios.get(`${this.baseUrl}/sysCinema`)
        this.cinemaInfo = resp.data?.data || ''
      } catch (e) {
        console.error('获取影院信息失败:', e)
        this.cinemaInfo = ''
      }
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    search() {
      let tmp = this.kw.trim()
      if (tmp) {
        this.$router.push(`/search/searchMovie?kw=${tmp}`)
        this.kw = ''
      }
    },
    handleCommand(command) {
      if(command === 'logout') {
        window.sessionStorage.clear();
        return this.$router.push('/login')
      }
      this.$router.push(`/${command}`)
    },
    toWelcome() {
      this.$router.push('/welcome')
    }
  }
}
</script>

<style scoped>
.el-header{
  height: 80px !important;
  border-bottom: 1px solid #e6e6e6;
}

.header-inner{
  width: 75%;
  margin: 0 12.5%;
  display: flex;
}

.logo{
  height: 80px;
  width: 200px;
}

.nav-menu{
  border-bottom: 0px solid #eee !important;
  height: 60px;
  margin: 9px auto;
}

.el-menu-item{
  font-size: 20px;
}

.el-menu-item:hover{
  color: #409EFF !important;
}

.searchContainer{
  padding: 20px 0;
  display: flex;
}

.searchBar >>> input{
  border-radius: 50px;
}

#searchBtn{
  transform: translate(-100%, 0);
}

.el-dropdown-link{
  width: 70px;
  margin: 15px 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.icon-arrow {
  transition: all 0.2s ease-in-out;
  -webkit-transition: all 0.2s ease-in-out;
  -moz-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
}

.el-dropdown-link:hover .icon-arrow{
  -webkit-transform: rotate(180deg) scale(1);
  -moz-transform: rotate(180deg) scale(1);
  -o-transform: rotate(180deg) scale(1);
  -transform: rotate(180deg) scale(1);
}

.el-main{
  padding: 0px;
}
</style>