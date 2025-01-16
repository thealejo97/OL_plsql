BEGIN
   -- Create table Merchant
   EXECUTE IMMEDIATE '
      CREATE TABLE Merchant (
         id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
         business_name VARCHAR2(100) NOT NULL,
         department VARCHAR2(50) NOT NULL,
         city VARCHAR2(50) NOT NULL,
         phone VARCHAR2(20),
         email VARCHAR2(100),
         status VARCHAR2(20) CHECK (status IN (''Registered'', ''Active'', ''Inactive'', ''Suspended'', ''Cancelled'')),
         created_on DATE DEFAULT SYSDATE NOT NULL,
         created_by VARCHAR2(50),
         updated_on DATE DEFAULT SYSDATE,
         updated_by VARCHAR2(50)
      )
   ';

   -- Create table Establishment
   EXECUTE IMMEDIATE '
      CREATE TABLE Establishment (
         id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
         merchant_id NUMBER NOT NULL,
         name VARCHAR2(100) NOT NULL,
         revenue NUMBER(15, 2) DEFAULT 0 NOT NULL,
         employee_count NUMBER DEFAULT 0 NOT NULL,
         created_on DATE DEFAULT SYSDATE NOT NULL,
         created_by VARCHAR2(50),
         updated_on DATE DEFAULT SYSDATE,
         updated_by VARCHAR2(50),
         CONSTRAINT fk_merchant FOREIGN KEY (merchant_id) REFERENCES Merchant(id)
      )
   ';

   -- Create table Employee
   EXECUTE IMMEDIATE '
      CREATE TABLE Employee (
         id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
         establishment_id NUMBER NOT NULL,
         name VARCHAR2(100) NOT NULL,
         email VARCHAR2(100),
         phone VARCHAR2(20),
         position VARCHAR2(50),
         hire_date DATE DEFAULT SYSDATE NOT NULL,
         created_on DATE DEFAULT SYSDATE NOT NULL,
         created_by VARCHAR2(50),
         updated_on DATE DEFAULT SYSDATE,
         updated_by VARCHAR2(50),
         CONSTRAINT fk_establishment FOREIGN KEY (establishment_id) REFERENCES Establishment(id)
      )
   ';

   -- Confirmation message
   DBMS_OUTPUT.PUT_LINE('Tables created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error creating tables: ' || SQLERRM);
END;
