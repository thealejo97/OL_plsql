CREATE OR REPLACE PACKAGE BODY C##OL_SCHEMA.PKG_MERCHANT IS
   FUNCTION get_merchant_by_id(p_id IN NUMBER) RETURN SYS_REFCURSOR IS
      l_cursor SYS_REFCURSOR;
   BEGIN
      OPEN l_cursor FOR
         SELECT 
            m.business_name,
            m.department,
            m.city,
            m.phone,
            m.email,
            m.created_on,
            m.status,
            NVL(SUM(e.revenue), 0) AS total_revenue,
            NVL(SUM(e.employee_count), 0) AS total_employees,
            LISTAGG(e.name, ', ') WITHIN GROUP (ORDER BY e.name) AS establishment_names 
         FROM Merchant m
         LEFT JOIN Establishment e ON e.merchant_id = m.id
         WHERE m.id = p_id
         GROUP BY 
            m.business_name, m.department, m.city, 
            m.phone, m.email, m.created_on, m.status;

      RETURN l_cursor;
   END get_merchant_by_id;
END PKG_MERCHANT;
/
