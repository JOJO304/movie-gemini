<template xmlns:c="http://www.w3.org/1999/html">
  <div>
    <div class="whole">
      <div class="left">
        <div class="panel">
          <div class="panel-header">
            <h2 style="color: #ef4238">正在热映</h2>
          </div>
          <div class="panel-content">
            <movie-item :movieItem="item" v-for="(item, index) in ongoingMovieList" :key="item.movieId" v-if="index<4"></movie-item>
          </div>
        </div>
        <div class="panel">
          <div class="panel-header">
            <h2 style="color: #2d98f3">即将上映</h2>
          </div>
          <div class="panel-content">
            <movie-item :movieItem="item" v-for="(item,index) in upcomingMovieList" :key="item.movieId" v-if="index<4"></movie-item>
          </div>
        </div>
      </div>
      <div class="right">
        <div class="panel">
          <div class="panel-header">
            <h2 style="color: #ffb400">票房榜</h2>
          </div>
          <div class="panel-content">
            <div class="board" v-for="(item, index) in totalBoxOfficeList" :key="item.movieId">
                <div class="board-left" v-if="index <10">
                  <i class="board-index">{{index+1}}</i>
                </div>
                <div class="board-middle" v-if="index < 10">
                  <a :href="'/movieInfo/' + item.movieId">
                    <p class="name">{{ item.movieName }}</p>
                  </a>
                </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import movieItem from '../../components/movie/movie-item'
import moment from 'moment'
import axios from 'axios'

// 全局配置axios
axios.defaults.baseURL = 'http://localhost:8181'
axios.defaults.withCredentials = false

export default {
  name: "Home",
  components: {
    movieItem
  },
  data() {
    return {
      queryInfo1: {
        pageSize: 8,
        pageNum: 1
      },
      queryInfo2: {
        pageSize: 8,
        pageNum: 1
      },
      queryInfo4: {
        pageSize: 10,
        pageNum: 1
      },
      ongoingMovieList: [],
      upcomingMovieList: [],
      totalBoxOfficeList: [],
      carouselHeight: ''
    }
  },
  created() {
    this.getOngoingMovieList()
    this.getUpcomingMovieList()
    this.getTotalBoxOfficeList()
  },
  mounted() {
    this.getHeight()
  },
  methods:{
    // 获取正在热映
    async getOngoingMovieList() {
      try {
        // 👇 核心修改 1：告诉后端，只查“上映时间 <= 今天（23:59:59结束）”的电影
        this.queryInfo1.endDate = moment().format('YYYY-MM-DD 23:59:59')
        
        const { data : res } = await axios.get('/sysMovie/find', {params: this.queryInfo1})
        this.ongoingMovieList = res.data || []
        console.log('正在热映数据:', this.ongoingMovieList)
      } catch (e) {
        console.error('获取正在热映失败:', e)
        this.ongoingMovieList = []
      }
    },
    
    // 获取即将上映
    async getUpcomingMovieList() {
      try {
        // 👇 核心修改 2：告诉后端，只查“上映时间 >= 明天（00:00:00开始）”的电影
        this.queryInfo2.startDate = moment().add(1, 'days').format('YYYY-MM-DD 00:00:00')
        
        const {data: res} = await axios.get('/sysMovie/find', {params: this.queryInfo2})
        this.upcomingMovieList = res.data || []
        console.log('即将上映数据:', this.upcomingMovieList)
      } catch (e) {
        console.error('获取即将上映失败:', e)
        this.upcomingMovieList = []
      }
    },
    
    // 计算轮播图高度
    getHeight() {
      try {
        let clientWidth = document.documentElement?.clientWidth || window.innerWidth
        clientWidth *= 0.8
        this.carouselHeight = `${clientWidth / 1700 * 520}px`
      } catch (e) {
        this.carouselHeight = '400px'
      }
    },
    // 获取票房榜
    async getTotalBoxOfficeList(){
      try {
        const {data: resp} = await axios.get('/sysMovie/find/rankingList/1', {params: this.queryInfo4})
        if(resp.code !== 200) throw new Error(resp.msg || '获取票房榜失败')
        this.totalBoxOfficeList = resp.data || []
      } catch (e) {
        console.error('获取票房榜失败:', e)
        this.totalBoxOfficeList = []
      }
    }
  }
}
</script>

<style scoped>
.whole{
  width: 1200px;
  margin: 30px auto;
  display: flex;
}

.left{
  width: 70%;
}

.right{
  width: 30%;
  margin-left: 100px;
}

h2{
  font-size: 26px;
}

.panel-header{
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.movie-item{
  margin-left: 0;
  margin-right: 30px;
}

.movie-item:nth-child(4n){
  margin-right: 0;
}

.board{
  display: flex;
  margin: 10px 10px;
}

.board-left{
  display: flex;
  align-items: center;
}

.board-middle{
  display: flex;
  margin-left: 10px;
  width: 150px;
  font-size: 18px;
}

.board-middle > a{
  text-decoration: none;
  color: #333;
}

.board-index{
  color: #ffb400;
  display: inline-block;
  width: 50px;
  height: 50px;
  line-height: 50px;
  text-align: center;
  font-size: 18px;
}

.panel-content{
  margin: 0px 0px 50px 0px;
}
</style>