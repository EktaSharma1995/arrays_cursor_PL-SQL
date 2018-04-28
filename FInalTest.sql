--     Name: Ekta Sharma
-- Student#: N01231869
--    Class: ITE-5220-0NA
--Assignment:Final 
--Question:01
-- Create a stand-alone stored procedure called my_application_error_v1 procedure with
-- one numeric parameter named p_err_code – an error number in the range -20000 to -20998.

-- The procedure will raise the error in p_err_code with the appropriate message text (see below to get the list of error code/message pairs).

-- If p_err_code is not in the list, raise an exception with the number -20999 and text containing the invalid error number followed by the text ' - Invalid error code'.

-- Implementation method:
-- 1.	Define an associative array to hold the messages
-- 2.	Initialize  the array with the messages information
-- 3.	Write code to extract the message text from the array into a variable
-- 4.	Raise the error using the raise_application_error with the message you just extracted from the array.

create or replace 
procedure my_application_error_v1(p_err_code number) is  
         
        type exceptions_table_type 
            is table of varchar2(50) 
            index by pls_integer;
            
        exceptions_table exceptions_table_type;
        v_message varchar2(50);

begin
    exceptions_table(-20001):= 'Not assigned';
    exceptions_table(-20002):= 'Shipper does not exist';
    exceptions_table(-20003):= 'Product does not exist';
    exceptions_table(-20004):= 'Required Date not at least 15 days in the future';
    exceptions_table(-20005):= 'Quantity must be > 0';
    exceptions_table(-20006):= 'Product description cannot be null';
    exceptions_table(-20007):= 'Basket id does not exist';
    exceptions_table(-20008):= 'Customer does not exist';
    exceptions_table(-20009):= 'Product id does not exist';
    exceptions_table(-20010):= 'Not assigned';
    exceptions_table(-20011):= 'Order does not exist';
    exceptions_table(-20012):= 'Employee does not exist';
    exceptions_table(-20013):= 'Order has not been shipped';
    exceptions_table(-20014):= 'Not assigned';
    exceptions_table(-20015):= 'Not assigned';
    exceptions_table(-20016):= 'Discount must be >= 0';
    exceptions_table(-20017):= 'Order already exists';
    exceptions_table(-20018):= 'Quantity > 99 not allowed';
    exceptions_table(-20019):= 'Product in use - cannot delete';
    exceptions_table(-20020):= 'Not assigned';
    
    if (exceptions_table.EXISTS(p_err_code))
    then 
        v_message:= exceptions_table(p_err_code);
        raise_application_error(p_err_code, v_message);

    else
        raise_application_error(-20999, p_err_code || 'Invalid error code');   
    end if;
end my_application_error_v1;            
/


--     Name: Ekta Sharma
-- Student#: N01231869
--    Class: ITE-5220-0NA
--Assignment:Final 
--Question:02
-- Create a stand-alone stored procedure called my_application_error_v2 procedure with
-- one numeric parameter named p_err_code – an error number in the range -20000 to -20998.

-- The procedure will raise the error in p_err_code with the appropriate message text (see below to get the list of error code/message pairs).

-- If p_err_code is not in the list, raise an exception with the number -20999 and text containing the invalid error number followed by the text ' - Invalid error code'.

-- Implementation method:
-- 1.	Use the if/elsif structure to put the message text into a variable

create or replace 
procedure my_application_error_v2 (p_err_code number) is
           
        v_message varchar2(50);

begin
    if(p_err_code = -20001)
    then
        v_message:= 'Not assigned';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20002)
    then
        v_message:= 'Shipper does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20003)
    then
        v_message:= 'Product does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20004)
    then
        v_message:= 'Required Date not at least 15 days in the future';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20005)
    then
        v_message:= 'Quantity must be > 0';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20006)
    then
        v_message:= 'Product description cannot be null';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20007)
    then
        v_message:= 'Basket id does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20008)
    then
        v_message:= 'Customer does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20009)
    then
        v_message:= 'Product id does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20010)
    then
        v_message:= 'Not assigned';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20011)
    then
        v_message:= 'Order does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20012)
    then
        v_message:= 'Employee does not exist';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20013)
    then
        v_message:= 'Order has not been shipped';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20014)
    then
        v_message:= 'Not assigned';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20015)
    then
        v_message:= 'Not assigned';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20016)
    then
        v_message:= 'Discount must be >= 0';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20017)
    then
        v_message:= 'Order already exists';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20018)
    then
        v_message:= 'Quantity > 99 not allowed';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20019)
    then
        v_message:= 'Product in use - cannot delete';
        raise_application_error(p_err_code, v_message);

    elsif(p_err_code = -20020)
    then
        v_message:= 'Not assigned';
        raise_application_error(p_err_code, v_message);
    
    else
        raise_application_error(-20999, p_err_code || 'Invalid error code');   
    end if;
end my_application_error_v2;            
/




set serveroutput on
begin -- test 1 - known error code
    my_application_error_v2(-20001);
exception
    when others then
    if sqlcode = -20001
    then
        dbms_output.put_line('--- Success --- -20001 worked');
    else
        dbms_output.put_line('*** Failure *** -20001 did not work correctly' || sqlcode);
    end if;
end;
/


begin -- test 2 - unknown error code
        my_application_error_v1(-20997);
exception
    when others then
    if sqlcode = -20999
    then
        dbms_output.put_line('--- Success --- -20997 is not a valid code');
    else
        dbms_output.put_line('*** Failure *** -20997 did not work correctly');
    end if;
end;
/



set serveroutput on
begin
    slavkos2.SS_Slavko.ss_list_errors('N01231869');
 end;
/

set serveroutput on
begin
    slavkos2.SS_Slavko.Start_test;
    begin -- test 1 - known error code
        my_application_error_v1(-20001);
    exception
        when others then
            if sqlcode = -20001
            then
                dbms_output.put_line('--- Success --- -20001 worked');
            else
                dbms_output.put_line('*** Failure *** -20001 did not work correctly');
            end if;
    end;

    begin -- test 2 - unknown error code
        my_application_error_v1(-20997);
    exception
        when others then
            if sqlcode = -20999
            then
                dbms_output.put_line('--- Success --- -20997 is not a valid code');
            else
                dbms_output.put_line('*** Failure *** -20997 did not work correctly');
            end if;
    end;
    slavkos2.SS_Slavko.End_test;
end;
/

set serveroutput on
begin
    slavkos2.SS_Slavko.Start_test;
    begin -- test 1 - known error code
        my_application_error_v2(-20001);
    exception
        when others then
            if sqlcode = -20001
            then
                dbms_output.put_line('--- Success --- -20001 worked');
            else
                dbms_output.put_line('*** Failure *** -20001 did not work correctly');
            end if;
    end;

    begin -- test 2 - unknown error code
        my_application_error_v2(-20997);
    exception
        when others then
            if sqlcode = -20999
            then
                dbms_output.put_line('--- Success --- -20997 is not a valid code');
            else
                dbms_output.put_line('*** Failure *** -20997 did not work correctly');
            end if;
    end;
    slavkos2.SS_Slavko.End_test;
end;
/



