package com.movie.system.service;

import com.movie.system.domin.SysCinema;


public interface SysCinemaService {

    SysCinema findCinema();

    int updateCinema(SysCinema sysCinema);

    SysCinema findCinemaById(Long id);

}
