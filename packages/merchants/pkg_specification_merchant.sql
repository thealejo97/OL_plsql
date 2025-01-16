CREATE OR REPLACE PACKAGE C##OL_SCHEMA.PKG_MERCHANT IS
   FUNCTION get_merchant_by_id(p_id IN NUMBER) RETURN SYS_REFCURSOR;
   FUNCTION get_merchants(p_name_filter IN VARCHAR2 DEFAULT NULL, 
                          p_city_filter IN VARCHAR2 DEFAULT NULL, 
                          p_status_filter IN VARCHAR2 DEFAULT NULL,
                          p_offset IN NUMBER DEFAULT 0, 
                          p_limit IN NUMBER DEFAULT 10) RETURN SYS_REFCURSOR;
END PKG_MERCHANT;
