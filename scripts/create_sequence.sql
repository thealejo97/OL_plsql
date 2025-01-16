BEGIN
   -- Crear secuencia para Merchant
   EXECUTE IMMEDIATE 'CREATE SEQUENCE merchant_seq START WITH 1 INCREMENT BY 1';

   -- Crear secuencia para Establishment
   EXECUTE IMMEDIATE 'CREATE SEQUENCE establishment_seq START WITH 1 INCREMENT BY 1';

   -- Crear secuencia para Employee
   EXECUTE IMMEDIATE 'CREATE SEQUENCE employee_seq START WITH 1 INCREMENT BY 1';

   DBMS_OUTPUT.PUT_LINE('Sequences created successfully...');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating sequences: ' || SQLERRM);
END;
