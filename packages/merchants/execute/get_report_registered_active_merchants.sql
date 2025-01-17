DECLARE
   l_cursor SYS_REFCURSOR;
   l_name VARCHAR2(100);
   l_department VARCHAR2(50);
   l_municipality VARCHAR2(50);
   l_phone VARCHAR2(20);
   l_email VARCHAR2(100);
   l_registration_date DATE;
   l_status VARCHAR2(20);
   l_total_establishments NUMBER;
   l_total_active NUMBER;
   l_total_employees NUMBER;
BEGIN
   l_cursor := C##OL_SCHEMA.PKG_MERCHANT.get_report_registered_active_merchants;

   LOOP
      FETCH l_cursor INTO 
         l_name, l_department, l_municipality, l_phone, 
         l_email, l_registration_date, l_status, 
         l_total_establishments, l_total_active, l_total_employees;
      EXIT WHEN l_cursor%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Merchant Name: ' || l_name);
      DBMS_OUTPUT.PUT_LINE('Department: ' || l_department);
      DBMS_OUTPUT.PUT_LINE('Municipality: ' || l_municipality);
      DBMS_OUTPUT.PUT_LINE('Phone: ' || l_phone);
      DBMS_OUTPUT.PUT_LINE('Email: ' || l_email);
      DBMS_OUTPUT.PUT_LINE('Registration Date: ' || l_registration_date);
      DBMS_OUTPUT.PUT_LINE('Status: ' || l_status);
      DBMS_OUTPUT.PUT_LINE('Total Establishments: ' || l_total_establishments);
      DBMS_OUTPUT.PUT_LINE('Total Active: ' || l_total_active);
      DBMS_OUTPUT.PUT_LINE('Total Employees: ' || l_total_employees);
   END LOOP;
   CLOSE l_cursor;
END;
