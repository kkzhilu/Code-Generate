package ${packageName}.service.impl;

import ${packageName}.entity.*;
import ${packageName}.common.PageList;
import ${packageName}.dao.*;
import ${packageName}.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务层实现类
 * ${classInfo.classComment}ServiceImpl
 * @author ${authorName}
 * @date ${.now?string('yyyy/MM/dd')}
 */
@Service
public class ${classInfo.className}ServiceImpl implements ${classInfo.className}Service {

    @Autowired
	${classInfo.className}Dao dao;

    @Override
    public int insert(${classInfo.className} ${classInfo.modelName}) {
        return dao.insert(${classInfo.modelName});
    }

    @Override
    public int batchInsert(List<${classInfo.className}> list) {
    	return dao.batchInsert(list);
    }

    @Override
    public int update(${classInfo.className} ${classInfo.modelName}) {
    	return dao.update(${classInfo.modelName});
    }

    @Override
    public int delete(Object key) {
    	return dao.delete(key);
    }

    @Override
    public int batchDelete(List<Object> keys) {
        return dao.batchDelete(keys);
    }

	@Override
	public ${classInfo.className} selectByKey(Object key) {
		return dao.selectByKey(key);
	}

	@Override
	public List<${classInfo.className}> selectList(${classInfo.className} ${classInfo.modelName}) {
		return dao.selectList(${classInfo.modelName});
	}

	@Override
	public PageList<${classInfo.className}> selectPage(${classInfo.className} ${classInfo.modelName}, Integer offset, Integer pageSize) {
		PageList<${classInfo.className}> pageList = new PageList<>();

		int total = this.total(${classInfo.modelName});

		Integer totalPage;
		if (total % pageSize != 0) {
			totalPage = (total /pageSize) + 1;
		} else {
			totalPage = total /pageSize;
		}

		int page = (offset - 1) * pageSize;

		List<${classInfo.className}> list = dao.selectPage(${classInfo.modelName}, page, pageSize);

		pageList.setList(list);
		pageList.setStartPageNo(offset);
		pageList.setPageSize(pageSize);
		pageList.setTotalCount(total);
		pageList.setTotalPageCount(totalPage);
		return pageList;
	}

	@Override
	public int total(${classInfo.className} ${classInfo.modelName}) {
		return dao.total(${classInfo.modelName});
	}
}