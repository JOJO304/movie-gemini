package com.movie.system.service.impl;

import com.movie.system.domin.SysCinema;
import com.movie.system.mapper.SysCinemaMapper;
import com.movie.system.service.SysCinemaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class SysCinemaServiceImpl implements SysCinemaService {

    @Autowired
    private SysCinemaMapper sysCinemaMapper;

    @Override
    public SysCinema findCinema() {
        return sysCinemaMapper.findCinema();
    }

    @Override
    public int updateCinema(SysCinema sysCinema) {
        return sysCinemaMapper.updateCinema(sysCinema);
    }

    @Override
    public SysCinema findCinemaById(Long id) {
        return sysCinemaMapper.findCinemaById(id);
    }
}
