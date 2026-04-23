package com.movie.system.mapper;

import com.movie.system.domin.SysBill;

import java.util.List;


public interface SysBillMapper {

    List<SysBill> findAllBills(SysBill sysBill);

    SysBill findBillById(Long id);

    int addBill(SysBill sysBill);

    int updateBill(SysBill sysBill);

    int deleteBill(Long id);

    List<SysBill> findTimeoutBill();

}
