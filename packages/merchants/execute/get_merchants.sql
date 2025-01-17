DECLARE
   l_cursor SYS_REFCURSOR;
   l_id NUMBER;
   l_business_name VARCHAR2(100);
   l_department VARCHAR2(50);
   l_city VARCHAR2(50);
   l_phone VARCHAR2(20);
   l_email VARCHAR2(100);
   l_created_on DATE;
   l_status VARCHAR2(20);
   l_total_revenue NUMBER;
   l_total_employees NUMBER;
   l_counter NUMBER := 0;
BEGIN
   l_cursor := C##OL_SCHEMA.PKG_MERCHANT.get_merchants(
                  p_name_filter => 'Merchant',
                  p_city_filter => 'Cali',
                  p_status_filter => 'Active',
                  p_offset => 0,
                  p_limit => 10);

    DBMS_OUTPUT.PUT_LINE('--- Merchant Full Data ---');

   LOOP
      FETCH l_cursor INTO 
         l_id, l_business_name, l_department, l_city, 
         l_phone, l_email, l_created_on, l_status, 
         l_total_revenue, l_total_employees;
      EXIT WHEN l_cursor%NOTFOUND;
      
      l_counter := l_counter + 1;
      DBMS_OUTPUT.PUT_LINE('-------- ' || l_counter || ' --------');
      DBMS_OUTPUT.PUT_LINE('ID: ' || l_id);
      DBMS_OUTPUT.PUT_LINE('Business Name: ' || l_business_name);
      DBMS_OUTPUT.PUT_LINE('Department: ' || l_department);
      DBMS_OUTPUT.PUT_LINE('City: ' || l_city);
      DBMS_OUTPUT.PUT_LINE('Phone: ' || l_phone);
      DBMS_OUTPUT.PUT_LINE('Email: ' || l_email);
      DBMS_OUTPUT.PUT_LINE('Created On: ' || l_created_on);
      DBMS_OUTPUT.PUT_LINE('Status: ' || l_status);
      DBMS_OUTPUT.PUT_LINE('Total Revenue: ' || l_total_revenue);
      DBMS_OUTPUT.PUT_LINE('Total Employees: ' || l_total_employees);
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('--- End full data ---');

   CLOSE l_cursor;
END;
