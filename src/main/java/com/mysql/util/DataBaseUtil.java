package com.mysql.util;

import cn.hutool.core.collection.CollectionUtil;
import com.mysql.bean.ClassInfo;
import com.mysql.bean.FieldInfo;
import com.mysql.bean.GlobleConfig;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ******************************
 * author：      柯贤铭
 * createTime:   2020/1/9 18:03
 * description:  库解析工具类
 *               解析表和字段
 * version:      V1.0
 * ******************************
 */
public class DataBaseUtil {

    /***
     * 根据指定库获取单表相关参数
     * @param tableName   表名
     */
    public static ClassInfo parseClassInfo(String tableName) throws SQLException {
        // tableSql
        String tableInfoSql = getTableInfoSql(tableName);

        Statement statement = DBUtil.getConnection().createStatement();

        ResultSet tableResult = statement.executeQuery(tableInfoSql);

        // 构建ClassInfo信息
        ClassInfo classInfo = new ClassInfo();
        classInfo.setTableName(tableName);

        // className信息
        String className = StringUtils.upperCaseFirst(StringUtils.underlineToCamelCase(tableName));
        classInfo.setClassName(className);
        classInfo.setModelName(StringUtils.lowerCaseFirst(className));
        classInfo.setClassComment(className);

        List<FieldInfo> fieldList = new ArrayList<>();

        // 1 column_name, 2 data_type 3 column_comment
        while (tableResult.next()) {
            FieldInfo fieldInfo = new FieldInfo();
            fieldInfo.setColumnName(tableResult.getString(1));
            fieldInfo.setFieldClass(typeMapping.get(tableResult.getString(2)));

            String fieldName = StringUtils.underlineToCamelCase(tableResult.getString(1));
            fieldInfo.setFieldName(fieldName);
            fieldInfo.setFieldComment(tableResult.getString(3));
            fieldList.add(fieldInfo);
        }

        classInfo.setFieldList(fieldList);

        // 设置主键字段
        if (CollectionUtil.isEmpty(fieldList)) {
            classInfo.setKey(new FieldInfo());
        } else {
            classInfo.setKey(fieldList.get(0));
        }

        tableResult.close();
        statement.close();
        return classInfo;
    }

    /***
     * 根据指定库获取所有表名
     */
    public static List<String> getAllTableNames () throws SQLException {
        // result
        List<String> result = new ArrayList<>();

        // sql
        String sql = getTables();

        Statement statement = DBUtil.getConnection().createStatement();

        ResultSet rs = statement.executeQuery(sql);

        while (rs.next()) {
            result.add(rs.getString(1));
        }
        return result;
    }

    /***
     * TableInfo SQL
     * @param tableName tableName
     */
    private static String getTableInfoSql(String tableName) {
        return MessageFormat.format("select column_name,data_type,column_comment,numeric_precision," +
                "numeric_scale,character_maximum_length,is_nullable nullable from information_schema.columns " +
                "where table_name = \"{0}\" and table_schema = \"{1}\"", tableName, GlobleConfig.getGlobleConfig().getDataBase());
    }


    /***
     * 获取所有Tables SQL
     */
    private static String getTables() {
        return MessageFormat.format("select table_name from information_schema.tables where table_schema=\"{0}\" and table_type=\"{1}\";",
                GlobleConfig.getGlobleConfig().getDataBase(), "base table");
    }

    private static Map<String, String> typeMapping = new HashMap<>();

    static {
        typeMapping.put("int"       , "Integer");
        typeMapping.put("char"      , "String");
        typeMapping.put("varchar"   , "String");
        typeMapping.put("datetime"  , "Date");
        typeMapping.put("timestamp" , "Date");
        typeMapping.put("bit"       , "Integer");
        typeMapping.put("tinyint"   , "Integer");
        typeMapping.put("smallint"  , "Integer");
        typeMapping.put("year"      , "Date");
        typeMapping.put("date"      , "Date");
        typeMapping.put("bigint"    , "Long");
        typeMapping.put("decimal"   , "BigDecimal");
        typeMapping.put("double"    , "Double");
        typeMapping.put("float"     , "Float");
        typeMapping.put("numeric"   , "Integer");
        typeMapping.put("text"      , "String");
        typeMapping.put("longtext"  , "String");
        typeMapping.put("time"      , "Date");
    }

    /***
     * MySQL 关键字及保留字
     */
    private final String KER_WORD = "ADD;ALL;ALTER;ANALYZE;AND;AS;ASC;ASENSITIVE;BEFORE;BETWEEN;BIGINT;BINARY;BLOB;BOTH;BY;CALL;CASCADE;CASE;CHANGE;CHAR;CHARACTER;CHECK;COLLATE;COLUMN;CONDITION;CONNECTION;CONSTRAINT;CONTINUE;CONVERT;CREATE;CROSS;CURRENT_DATE;CURRENT_TIME;CURRENT_TIMESTAMP;CURRENT_USER;CURSOR;DATABASE;DATABASES;DAY_HOUR;DAY_MICROSECOND;DAY_MINUTE;DAY_SECOND;DEC;DECIMAL;DECLARE;DEFAULT;DELAYED;DELETE;DESC;DESCRIBE;DETERMINISTIC;DISTINCT;DISTINCTROW;DIV;DOUBLE;DROP;DUAL;EACH;ELSE;ELSEIF;ENCLOSED;ESCAPED;EXISTS;EXIT;EXPLAIN;FALSE;FETCH;FLOAT;FLOAT4;FLOAT8;FOR;FORCE;FOREIGN;FROM;FULLTEXT;GOTO;GRANT;GROUP;HAVING;HIGH_PRIORITY;HOUR_MICROSECOND;HOUR_MINUTE;HOUR_SECOND;IF;IGNORE;IN;INDEX;INFILE;INNER;INOUT;INSENSITIVE;INSERT;INT;INT1;INT2;INT3;INT4;INT8;INTEGER;INTERVAL;INTO;IS;ITERATE;JOIN;KEY;KEYS;KILL;LABEL;LEADING;LEAVE;LEFT;LIKE;LIMIT;LINEAR;LINES;LOAD;LOCALTIME;LOCALTIMESTAMP;LOCK;LONG;LONGBLOB;LONGTEXT;LOOP;LOW_PRIORITY;MATCH;MEDIUMBLOB;MEDIUMINT;MEDIUMTEXT;MIDDLEINT;MINUTE_MICROSECOND;MINUTE_SECOND;MOD;MODIFIES;NATURAL;NOT;NO_WRITE_TO_BINLOG;NULL;NUMERIC;ON;OPTIMIZE;OPTION;OPTIONALLY;OR;ORDER;OUT;OUTER;OUTFILE;PRECISION;PRIMARY;PROCEDURE;PURGE;RAID0;RANGE;READ;READS;REAL;REFERENCES;REGEXP;RELEASE;RENAME;REPEAT;REPLACE;REQUIRE;RESTRICT;RETURN;REVOKE;RIGHT;RLIKE;SCHEMA;SCHEMAS;SECOND_MICROSECOND;SELECT;SENSITIVE;SEPARATOR;SET;SHOW;SMALLINT;SPATIAL;SPECIFIC;SQL;SQLEXCEPTION;SQLSTATE;SQLWARNING;SQL_BIG_RESULT;SQL_CALC_FOUND_ROWS;SQL_SMALL_RESULT;SSL;STARTING;STRAIGHT_JOIN;TABLE;TERMINATED;THEN;TINYBLOB;TINYINT;TINYTEXT;TO;TRAILING;TRIGGER;TRUE;UNDO;UNION;UNIQUE;UNLOCK;UNSIGNED;UPDATE;USAGE;USE;USING;UTC_DATE;UTC_TIME;UTC_TIMESTAMP;VALUES;VARBINARY;VARCHAR;VARCHARACTER;VARYING;WHEN;WHERE;WHILE;WITH;WRITE;X509;XOR;YEAR_MONTH;ZEROFILL;";
}
