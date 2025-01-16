   -------------------------------- Generar Merchant --------------------------------
BEGIN
   FOR i IN 1..10 LOOP
      INSERT INTO Merchant (business_name, department, city, phone, email, status)
      VALUES (
         'Merchant_' || i,                                
         CASE                                             
            WHEN MOD(i, 4) = 0 THEN 'Valle del Cauca'
            WHEN MOD(i, 4) = 1 THEN 'Nariño'
            WHEN MOD(i, 4) = 2 THEN 'Cundinamarca'
            ELSE 'Antioquia'
         END,
         CASE                                             
            WHEN MOD(i, 4) = 0 THEN 'Cali'
            WHEN MOD(i, 4) = 1 THEN 'Pasto'
            WHEN MOD(i, 4) = 2 THEN 'Bogotá'
            ELSE 'Medellín'
         END,
         '310' || TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999)), 
         'merchant' || i || '@gmail.com',                
         CASE                                             
            WHEN MOD(i, 4) = 0 THEN 'Registered'
            WHEN MOD(i, 4) = 1 THEN 'Active'
            WHEN MOD(i, 4) = 2 THEN 'Suspended'
            ELSE 'Cancelled'
         END
      );
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('Merchants seeds created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating merchants seed: ' || SQLERRM);
END;
   -------------------------------- Generar Establishment --------------------------------
BEGIN
   FOR i IN 1..30 LOOP
      INSERT INTO Establishment (merchant_id, name, revenue, employee_count)
      VALUES (
         MOD(i, 10) + 1,                               
         'Establishment_' || i,                        
         TRUNC(DBMS_RANDOM.VALUE(5000, 100000), 2),    
         TRUNC(DBMS_RANDOM.VALUE(1, 50))               
      );
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('Establishment seeds created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating Establishments seed: ' || SQLERRM);
END;
   -------------------------------- Generar Employee --------------------------------
BEGIN
   FOR i IN 1..100 LOOP
      INSERT INTO Employee (establishment_id, name, email, phone, position, hire_date)
      VALUES (
         MOD(i, 30) + 1,                              
         'Employee_' || i,                            
         'employee' || i || '@example.com',           
         '312' || TRUNC(DBMS_RANDOM.VALUE(1000000, 9999999)), 
         CASE                                         
            WHEN MOD(i, 4) = 0 THEN 'Manager'
            WHEN MOD(i, 4) = 1 THEN 'Cashier'
            WHEN MOD(i, 4) = 2 THEN 'Cook'
            ELSE 'Waiter'
         END,
         SYSDATE - TRUNC(DBMS_RANDOM.VALUE(1, 365))  
      );
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('Employee seeds created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating Employee seeds: ' || SQLERRM);
END;