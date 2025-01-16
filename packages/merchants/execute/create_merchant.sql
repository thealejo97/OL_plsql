DECLARE
   v_error_code NUMBER;
   v_error_message VARCHAR2(200);
BEGIN
   C##OL_SCHEMA.PKG_MERCHANT.create_merchant(
      p_business_name => 'New Merchant by CRUD',
      p_department => 'Valle del Cauca',
      p_city => 'Cali',
      p_phone => '3101234567',
      p_email => 'merchant@gmail.com',
      p_status => 'Active',
      p_created_by => 'admin',
      o_error_code => v_error_code,
      o_error_message => v_error_message
   );

   DBMS_OUTPUT.PUT_LINE('Error Code: ' || v_error_code);
   DBMS_OUTPUT.PUT_LINE('Error Message: ' || v_error_message);
END;
/
