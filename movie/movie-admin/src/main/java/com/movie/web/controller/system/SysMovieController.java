package com.movie.web.controller.system;

import com.movie.common.constant.MovieRankingList;
import com.movie.common.response.ResponseResult;
import com.movie.system.domin.SysMovie;
import com.movie.system.domin.vo.SysMovieVo;
import com.movie.system.service.impl.SysMovieServiceImpl;
import com.movie.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
//电影信息
@RestController
@RequestMapping("/sysMovie") // 新增：统一接口前缀，避免路径匹配问题
public class SysMovieController extends BaseController {

    @Autowired
    private SysMovieServiceImpl sysMovieService;

    /**
     * 修复：先调用分页，再查数据，确保分页和筛选生效
     */
    @GetMapping("/find")
    public ResponseResult findAllMovies(SysMovieVo sysMovieVo) {
        // 1. 先启动分页（必须在查询前调用）
        startPage();
        // 2. 再查询数据
        List<SysMovie> data = sysMovieService.findAllMovies(sysMovieVo);
        // 3. 封装分页结果返回
        return getResult(data);
    }

    @GetMapping("/find/{id}")
    public ResponseResult findMovieById(@PathVariable Long id) {
        return getResult(sysMovieService.findMovieById(id));
    }

    @PostMapping
    public ResponseResult addMovie(@Validated @RequestBody SysMovie sysMovie) {
        return getResult(sysMovieService.addMovie(sysMovie));
    }

    @PutMapping
    public ResponseResult updateMovie(@Validated @RequestBody SysMovie sysMovie) {
        return getResult(sysMovieService.updateMovie(sysMovie));
    }

    @DeleteMapping("/{ids}")
    public ResponseResult deleteMovie(@PathVariable Long[] ids) {
        return getResult(sysMovieService.deleteMovie(ids));
    }

    @GetMapping("/find/rankingList/{listId}")
    public ResponseResult findRankingList(@PathVariable Integer listId) throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        if (listId <= 0 || listId > 4) {
            return ResponseResult.error("抱歉，暂时只支持3种榜单，id为[1,3]");
        }
        Method getList = sysMovieService.getClass().getMethod(MovieRankingList.listNames[listId - 1]);
        startPage();
        List<SysMovie> data = (List<SysMovie>) getList.invoke(sysMovieService);
        return getResult(data);
    }

}