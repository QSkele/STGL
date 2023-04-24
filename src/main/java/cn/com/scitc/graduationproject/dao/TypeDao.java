package cn.com.scitc.graduationproject.dao;

import cn.com.scitc.graduationproject.model.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface TypeDao extends CrudRepository<Type,Integer> {
    //查询题目类型
    @Query(value ="select * from type where stype =?", nativeQuery = true)
    Page<Type> findByType(@Param("stype") Integer stype, Pageable pageable);
}
