package cn.com.scitc.graduationproject.service;
import cn.com.scitc.graduationproject.model.Course;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @version 1.0
 * @Author 邱新亮
 * @Date 2023/4/14 14:55
 * @注释
 */

public interface CourseService {
    List<Course> page(Integer cno, Pageable pageable);
}
