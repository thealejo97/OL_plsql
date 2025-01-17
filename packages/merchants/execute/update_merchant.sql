DECLARE
   v_error_code NUMBER;
   v_error_message VARCHAR2(200);
BEGIN
   C##OL_SCHEMA.PKG_MERCHANT.update_merchant(
      p_id => 1,
      p_business_name => 'Updated Merchant Name',
      p_department => 'Updated Department',
      p_city => 'Updated City',
      p_phone => '3109876543',
      p_email => 'updated_merchant@example.com',
      p_status => 'Active',
      p_updated_by => 'admin',
      o_error_code => v_error_code,
      o_error_message => v_error_message
   );

   DBMS_OUTPUT.PUT_LINE('Error Code: ' || v_error_code);
   DBMS_OUTPUT.PUT_LINE('Error Message: ' || v_error_message);
END;