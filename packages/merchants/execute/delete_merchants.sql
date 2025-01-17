DECLARE
   v_error_code NUMBER;
   v_error_message VARCHAR2(200);
BEGIN
   C##OL_SCHEMA.PKG_MERCHANT.delete_merchant(
      p_id => 21,
      o_error_code => v_error_code,
      o_error_message => v_error_message
   );

   DBMS_OUTPUT.PUT_LINE('Error Code: ' || v_error_code);
   DBMS_OUTPUT.PUT_LINE('Error Message: ' || v_error_message);
END;

