package com.mysql.util;

import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * String Tool
 */
public class StringUtil {

    /***
     * MySQL 关键字及保留字
     */
    private final static String KEY_WORD = "ADD;ALL;ALTER;ANALYZE;AND;AS;ASC;ASENSITIVE;BEFORE;BETWEEN;BIGINT;BINARY;BLOB;BOTH;BY;CALL;CASCADE;CASE;CHANGE;CHAR;CHARACTER;CHECK;COLLATE;COLUMN;CONDITION;CONNECTION;CONSTRAINT;CONTINUE;CONVERT;CREATE;CROSS;CURRENT_DATE;CURRENT_TIME;CURRENT_TIMESTAMP;CURRENT_USER;CURSOR;DATABASE;DATABASES;DAY_HOUR;DAY_MICROSECOND;DAY_MINUTE;DAY_SECOND;DEC;DECIMAL;DECLARE;DEFAULT;DELAYED;DELETE;DESC;DESCRIBE;DETERMINISTIC;DISTINCT;DISTINCTROW;DIV;DOUBLE;DROP;DUAL;EACH;ELSE;ELSEIF;ENCLOSED;ESCAPED;EXISTS;EXIT;EXPLAIN;FALSE;FETCH;FLOAT;FLOAT4;FLOAT8;FOR;FORCE;FOREIGN;FROM;FULLTEXT;GOTO;GRANT;GROUP;HAVING;HIGH_PRIORITY;HOUR_MICROSECOND;HOUR_MINUTE;HOUR_SECOND;IF;IGNORE;IN;INDEX;INFILE;INNER;INOUT;INSENSITIVE;INSERT;INT;INT1;INT2;INT3;INT4;INT8;INTEGER;INTERVAL;INTO;IS;ITERATE;JOIN;KEY;KEYS;KILL;LABEL;LEADING;LEAVE;LEFT;LIKE;LIMIT;LINEAR;LINES;LOAD;LOCALTIME;LOCALTIMESTAMP;LOCK;LONG;LONGBLOB;LONGTEXT;LOOP;LOW_PRIORITY;MATCH;MEDIUMBLOB;MEDIUMINT;MEDIUMTEXT;MIDDLEINT;MINUTE_MICROSECOND;MINUTE_SECOND;MOD;MODIFIES;NATURAL;NOT;NO_WRITE_TO_BINLOG;NULL;NUMERIC;ON;OPTIMIZE;OPTION;OPTIONALLY;OR;ORDER;OUT;OUTER;OUTFILE;PRECISION;PRIMARY;PROCEDURE;PURGE;RAID0;RANGE;READ;READS;REAL;REFERENCES;REGEXP;RELEASE;RENAME;REPEAT;REPLACE;REQUIRE;RESTRICT;RETURN;REVOKE;RIGHT;RLIKE;SCHEMA;SCHEMAS;SECOND_MICROSECOND;SELECT;SENSITIVE;SEPARATOR;SET;SHOW;SMALLINT;SPATIAL;SPECIFIC;SQL;SQLEXCEPTION;SQLSTATE;SQLWARNING;SQL_BIG_RESULT;SQL_CALC_FOUND_ROWS;SQL_SMALL_RESULT;SSL;STARTING;STRAIGHT_JOIN;TABLE;TERMINATED;THEN;TINYBLOB;TINYINT;TINYTEXT;TO;TRAILING;TRIGGER;TRUE;UNDO;UNION;UNIQUE;UNLOCK;UNSIGNED;UPDATE;USAGE;USE;USING;UTC_DATE;UTC_TIME;UTC_TIMESTAMP;VALUES;VARBINARY;VARCHAR;VARCHARACTER;VARYING;WHEN;WHERE;WHILE;WITH;WRITE;X509;XOR;YEAR_MONTH;ZEROFILL";

    private final static Map<String, String> KEY_MAP = new HashMap<>(256);

    /***
     * 解析MySQL 关键字
     */
    private static void parseKeyWords() {
        String[] keys = KEY_WORD.split(";");
        for (String key : keys) {
            KEY_MAP.put(key.toUpperCase(), key);
        }
    }

    /**
     * 首字母大写
     *
     * @param str
     * @return
     */
    public static String upperCaseFirst(String str) {
        return str.substring(0, 1).toUpperCase() + str.substring(1);
    }

    /**
     * 首字母小写
     *
     * @param str
     * @return
     */
    public static String lowerCaseFirst(String str) {
        return (str != null && str.length() > 1) ? str.substring(0, 1).toLowerCase() + str.substring(1) : "";
    }

    /**
     * 下划线，转换为驼峰式
     *
     * @param fieldName
     * @return
     */
    public static String underlineToCamelCase(String fieldName) {

        // 加载MySQL 关键字
        if (KEY_MAP.size() == 0) {
            synchronized (StringUtil.class) {
                if (KEY_MAP.size() == 0) {
                    parseKeyWords();
                }
            }
        }

        if (StringUtils.isBlank(fieldName)) {
            return fieldName;
        }

        StringBuilder result = new StringBuilder();
        boolean flag = false;
        for (int i = 0; i < fieldName.length(); i++) {
            char ch = fieldName.charAt(i);
            if ("_".charAt(0) == ch) {
                flag = true;
            } else {
                if (flag) {
                    result.append(Character.toUpperCase(ch));
                    flag = false;
                } else {
                    result.append(ch);
                }
            }
        }

        // 返回值
        String key = result.toString();

        // 处理字段为关键字的情况  isdelete -> isDeleteKey
        if (KEY_MAP.containsKey(key.toUpperCase())) {
            return key + "Key";
        }

        return key;
    }
}
