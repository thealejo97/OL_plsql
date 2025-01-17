CREATE OR REPLACE PACKAGE C##OL_SCHEMA.PKG_MERCHANT IS
   FUNCTION get_merchant_by_id(p_id IN NUMBER) RETURN SYS_REFCURSOR;
   FUNCTION get_merchants(p_name_filter IN VARCHAR2 DEFAULT NULL, 
                          p_city_filter IN VARCHAR2 DEFAULT NULL, 
                          p_status_filter IN VARCHAR2 DEFAULT NULL,
                          p_offset IN NUMBER DEFAULT 0, 
                          p_limit IN NUMBER DEFAULT 10) RETURN SYS_REFCURSOR;
   PROCEDURE create_merchant(p_business_name IN VARCHAR2, 
                             p_department IN VARCHAR2, 
                             p_city IN VARCHAR2, 
                             p_phone IN VARCHAR2, 
                             p_email IN VARCHAR2, 
                             p_status IN VARCHAR2, 
                             p_created_by IN VARCHAR2,
                             o_error_code OUT NUMBER, 
                             o_error_message OUT VARCHAR2);
   PROCEDURE update_merchant(p_id IN NUMBER,
                          p_business_name IN VARCHAR2, 
                          p_department IN VARCHAR2, 
                          p_city IN VARCHAR2, 
                          p_phone IN VARCHAR2, 
                          p_email IN VARCHAR2, 
                          p_status IN VARCHAR2, 
                          p_updated_by IN VARCHAR2,
                          o_error_code OUT NUMBER, 
                          o_error_message OUT VARCHAR2);
   PROCEDURE delete_merchant(p_id IN NUMBER, 
                          o_error_code OUT NUMBER, 
                          o_error_message OUT VARCHAR2);

   FUNCTION get_report_registered_active_merchants RETURN SYS_REFCURSOR;

END PKG_MERCHANT;
