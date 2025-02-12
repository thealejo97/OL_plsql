BEGIN
   EXECUTE IMMEDIATE 'CREATE SEQUENCE merchant_seq START WITH 1 INCREMENT BY 1';

   EXECUTE IMMEDIATE 'CREATE SEQUENCE establishment_seq START WITH 1 INCREMENT BY 1';

   EXECUTE IMMEDIATE 'CREATE SEQUENCE employee_seq START WITH 1 INCREMENT BY 1';

   DBMS_OUTPUT.PUT_LINE('Sequences created successfully...');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating sequences: ' || SQLERRM);
END;
