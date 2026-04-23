package com.movie.system.service;

import com.movie.system.domin.SysSession;
import com.movie.system.domin.vo.SysSessionVo;

import java.util.List;


public interface SysSessionService {

    List<SysSession> findByVo(SysSessionVo sysSessionVo);

    List<SysSession> findSessionByMovieIdOrHallId(SysSession sysSession);

    SysSession findSessionById(Long id);

    SysSession findOneSession(Long id);

    int addSession(SysSession sysSession);

    int updateSession(SysSession sysSession);

    int deleteSession(Long[] id);

    List<SysSession> findSessionByMovieId(Long movieId);

}
