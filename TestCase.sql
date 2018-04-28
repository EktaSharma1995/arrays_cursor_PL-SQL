--Name and Student Number
set serveroutput on
begin
    dbms_output.put_line('Student Number: ' || Final_Util.my_Number);
    dbms_output.put_line('       My Name: ' || Final_Util.my_Name);
end;
/

---test cases for the function Part discontinued 
set serveroutput on
begin -- test 1 - product doesn't exist.
    slavkos2.SS_Slavko.Start_test;
    dbms_output.put_line(Final_Util.part_discontinued(176));
exception
    when others then
    if sqlcode = -20003
    then
        dbms_output.put_line('--- Success --- -20003 worked');
    else
        dbms_output.put_line('*** Failure *** -20003 did not work correctly' || sqlcode);
    end if;
end;
/

declare
    v_discontinued_status varchar2(2);
begin -- test 2 - part_discontinued 
    dbms_output.put_line('part_discontinued Product Id: 18 Test');
    dbms_output.put_line('Returned value= ' || Final_Util.part_discontinued(18));
    v_discontinued_status := Final_Util.part_discontinued(18);
    if (v_discontinued_status = 'Y' or v_discontinued_status = 'N')
    then
        dbms_output.put_line('--- Success ---' || v_discontinued_status || ' is the correct value');
    else
        dbms_output.put_line('*** Failure ***' || v_discontinued_status || 'is not the correct value');
    end if;
slavkos2.SS_Slavko.Start_test;
end;
/

--test cases for the function add item
begin -- test 1 - order doesn't exist.
    Final_Util.add_item(11,77,3,0.4);
exception
    when others then
    if sqlcode = -20011
    then
        dbms_output.put_line('--- Success --- -20011 worked');
    else
        dbms_output.put_line('*** Failure *** -20011 did not work correctly' || sqlcode);
    end if;
end;

begin -- test 2 - product doesn't exist.
    Final_Util.add_item(11034,177,3,0.44);
exception
    when others then
    if sqlcode = -20003
    then
        dbms_output.put_line('--- Success --- -20003 worked');
    else
        dbms_output.put_line('*** Failure *** -20003 did not work correctly' || sqlcode);
    end if;
end;

begin -- test 3 - quantity must be greater than 0.
    Final_Util.add_item(11034,77,-3,0.4);
exception
    when others then
    if sqlcode = -20005
    then
        dbms_output.put_line('--- Success --- -20005 worked');
    else
        dbms_output.put_line('*** Failure *** -20005 did not work correctly' || sqlcode);
    end if;
end;

begin -- test 4 - discount must be >= 0.
    Final_Util.add_item(11034,77,3,-0.4);
exception
    when others then
    if sqlcode = -20016
    then
        dbms_output.put_line('--- Success --- -20016 worked');
    else
        dbms_output.put_line('*** Failure *** -20016 did not work correctly' || sqlcode);
    end if;
end;

begin -- test 5 - unique constraint violated.
    Final_Util.add_item(11014,75,2,0.4);
exception
    when others then
    if sqlcode = -0001
    then
        dbms_output.put_line('--- Success --- -0001 worked');
    else
        dbms_output.put_line('*** Failure *** -0001 did not work correctly' || sqlcode);
    end if;
end;

begin -- test 6 - check constraint violated.
    Final_Util.add_item(11014,75,2,1.4);
exception
    when others then
    if sqlcode = -2290
    then
        dbms_output.put_line('--- Success --- -2290 worked');
    else
        dbms_output.put_line('*** Failure *** -2290 did not work correctly' || sqlcode);
    end if;
end;
slavkos2.SS_Slavko.Start_test;
/

begin -- text 7 insertion
    Final_Util.add_item(11015,12,11,0.9);

    dbms_output.put_line('Add item for Order Id : 11015, Product Id: 12, Quantity: 11, Discount: 0.9 Test');

    for v_add_item in (select * 
                         from NW_ORDER_DETAILS
                         where order_id = 11015 and
                               product_id = 12 and
                               quantity = 11 and
                               discount = 0.9
                      ) 
    loop
                    
    if (v_add_item.order_id = 11015 and v_add_item.product_id = 12 and v_add_item.quantity = 11 and v_add_item.discount = 0.9)
    then
        dbms_output.put_line('--- Success --- Insertion done');
    else
        dbms_output.put_line('*** Failure ***  Insertion Failed' );
    end if;
    end loop;
end;

--test case for the report
set serveroutput on
begin
Final_Util.report_basket_content();
end;   
