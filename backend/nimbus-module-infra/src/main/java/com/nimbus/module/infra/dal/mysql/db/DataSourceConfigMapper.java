package com.nimbus.module.infra.dal.mysql.db;

import com.nimbus.framework.mybatis.core.mapper.BaseMapperX;
import com.nimbus.module.infra.dal.dataobject.db.DataSourceConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 数据源配置 Mapper
 *
 * @author Nimbus Framework
 */
@Mapper
public interface DataSourceConfigMapper extends BaseMapperX<DataSourceConfigDO> {
}
