<template>
  <div class="movie-item">
    <div v-on:mouseover="isHover = true" v-on:mouseleave="isHover = false">
      <a :href="movieInfoUrl">
        <img class="poster" :src="getPosterUrl()" alt="电影海报">
      </a>
      <div class="movie-item-hover" v-if="isHover">
        <a :href="movieInfoUrl">
          <img class="poster-hover" :src="getPosterUrl()" alt="电影海报">
          <div class="movie-hover-info">
            <div class="title-hover">
              <span class="name-tags">{{movieItem.movieName || '未知影片'}}</span>
            </div>
            <div class="title-hover">
              <span class="name-tags">类型: </span>{{formatCategory()}}
            </div>
            <div class="title-hover">
              <span class="name-tags">上映时间: </span>{{formatDate()}}
            </div>
          </div>
        </a>
      </div>
    </div>
    <div class="title-style">
      <a :href="movieInfoUrl">{{movieItem.movieName || '未知影片'}}</a>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
export default {
  name: "movie-item",
  props: {
    movieItem: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      isHover: false,
      movieInfoUrl: '',
      baseUrl: 'http://localhost:8181'
    }
  },
  created(){
    this.movieInfoUrl = this.movieItem.movieId ? `/movieInfo/${this.movieItem.movieId}` : '#';
  },
  methods: {
    getPosterUrl() {
      try {
        if (!this.movieItem.moviePoster) return '';
        const posterList = JSON.parse(this.movieItem.moviePoster);
        const poster = Array.isArray(posterList) ? posterList[0] : posterList;
        return poster ? `${this.baseUrl}${poster}` : '';
      } catch (e) {
        console.error('解析海报路径失败:', e);
        return '';
      }
    },
    formatCategory() {
      try {
        if (!this.movieItem.movieCategoryList) return '未知类型';
        return this.movieItem.movieCategoryList.map(obj => obj.movieCategoryName).join("/");
      } catch (e) {
        return '未知类型';
      }
    },
    formatDate() {
      try {
        if (!this.movieItem.releaseDate) return '未知时间';
        return moment(this.movieItem.releaseDate).format('YYYY-MM-DD');
      } catch (e) {
        return '未知时间';
      }
    }
  },
  watch: {
    'movieItem': {
      immediate: true,
      handler() {
        this.movieInfoUrl = this.movieItem.movieId ? `/movieInfo/${this.movieItem.movieId}` : '#';
      }
    }
  }
}
</script>

<style scoped>
.movie-item{
  margin-top: 30px;
  margin-left: 30px;
  display: inline-block;
  vertical-align: top;
  position: relative;
}

.poster{
  width: 160px;
  height: 220px;
  background: #f5f5f5;
}

.title-style{
  width: 160px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  text-align: center;
  font-size: 16px;
  color: #333;
  margin-top: 10px;
}

.score{
  color: #ffb400;
  font-size: 24px;
  font-style: italic;
}

a{
  text-decoration: none;
  color: #333;
}

.movie-item-hover{
  position: absolute;
  width: 218px;
  height: 300px;
  z-index: 10;
  top: -40px;
  left: -29px;
  overflow: hidden;
  background: #fff;
  box-shadow: 0 0 16px #fff, 0 0 6px rgba(0,0,0,.2);
}

.poster-hover{
  width: 218px;
  height: 300px;
  background: #f5f5f5;
}

.movie-hover-info{
  padding: 16px;
  height: 150px;
  box-sizing: border-box;
  position: absolute;
  z-index: 11;
  top: 150px;
  background: #fff;
  width: 218px;
  color: #999;
}

.title-hover:first-child{
  font-size: 20px;
  line-height: 20px;
  margin-top: 6px;
}

.title-hover{
  font-size: 16px;
  line-height: 16px;
  margin-top: 12px;
  width: 100%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.name-tags{
  color: #333;
}
</style>