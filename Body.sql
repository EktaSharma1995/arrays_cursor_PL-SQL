create or replace package body Final_Util as


    --
    -- ---------------------------------------------------
    --
    -- Function: my_Number
    --  Modify this function to return your student number
    --  Make sure the letter is capitalized
    --
    -- Marks: 1
    -- ---------------------------------------------------
    --
    function my_Number return varchar is
    begin
        return 'N01231869';
    end my_Number;
 
    --
    -- ---------------------------------------------------
    --
    -- Function: my_name
    --  Modify this function to return your first name followed
    --  by a comma followed by your last name
    --
    -- Marks: 1
    -- ---------------------------------------------------
    --
    function my_Name   return varchar is
    begin
        return 'Ekta,Sharma';
    end my_Name;
 
    --
    -- ---------------------------------------------------
    --
    -- Procedure: my_application_error
    --  Replace the body of this function by one of my_application_error_v1
    --  or my_application_error_v2 (from Q1/Q2)
    --
    -- Marks: 1
    -- ---------------------------------------------------
    --
    procedure my_application_error(p_err_code   in  number) is
    begin
        --
        -- replace the following code by the body of your my_application_error_v1
        -- or my_application_error_v2 code
        --
        if(p_err_code = -20001)
        then
            raise_application_error(p_err_code, 'Not assigned');
        
        elsif(p_err_code = -20002)
        then
            raise_application_error(p_err_code, 'Shipper does not exist');
        
        elsif(p_err_code = -20003)
        then
            raise_application_error(p_err_code, 'Product does not exist');
        
        elsif(p_err_code = -20004)
        then
            raise_application_error(p_err_code, 'Required Date not at least 15 days in the future');
        
        elsif(p_err_code = -20005)
        then
            raise_application_error(p_err_code, 'Quantity must be > 0');
        
        elsif(p_err_code = -20006)
        then
            raise_application_error(p_err_code, 'Product description cannot be null');
        
        elsif(p_err_code = -20007)
        then
            raise_application_error(p_err_code, 'Basket id does not exist');
        
        elsif(p_err_code = -20008)
        then
            raise_application_error(p_err_code, 'Customer does not exist');
        
        elsif(p_err_code = -20009)
        then
            raise_application_error(p_err_code, 'Product id does not exist');
        
        elsif(p_err_code = -20010)
        then
            raise_application_error(p_err_code, 'Not assigned');
        
        elsif(p_err_code = -20011)
        then
            raise_application_error(p_err_code, 'Order does not exist');
        
        elsif(p_err_code = -20012)
        then
            raise_application_error(p_err_code, 'Employee does not exist');
        
        elsif(p_err_code = -20013)
        then
            raise_application_error(p_err_code, 'Order has not been shipped');
        
        elsif(p_err_code = -20014)
        then
            raise_application_error(p_err_code, 'Not assigned');
        
        elsif(p_err_code = -20015)
        then
            raise_application_error(p_err_code, 'Not assigned');
        
        elsif(p_err_code = -20016)
        then
            raise_application_error(p_err_code, 'Discount must be >= 0');
        
        elsif(p_err_code = -20017)
        then
            raise_application_error(p_err_code, 'Order already exists');
        
        elsif(p_err_code = -20018)
        then
            raise_application_error(p_err_code, 'Quantity > 99 not allowed');
        
        elsif(p_err_code = -20019)
        then
            raise_application_error(p_err_code, 'Product in use - cannot delete');
        
        elsif(p_err_code = -20020)
        then
            raise_application_error(p_err_code, 'Not assigned');
        
        else
            raise_application_error(-20999, p_err_code || 'Invalid error code');
        end if;
    end my_application_error;
 
    --
    -- ---------------------------------------------------
    --
    -- Function: part_discontinued
    --    input: p_product_id
    --  Returns: a string containing the discontinued flag of the specified products
    --   Schema: North Wind
    -- Exceptions
    --      "Product does not exist" if the product does not exist
    -- Note: You MUST use explicit cursor(s) to implement this function
    --
    -- Marks: 2
    -- ---------------------------------------------------
    --
    function part_discontinued(p_product_id NW_PRODUCTS.PRODUCT_ID%TYPE) 
        return varchar2 is

        cursor c_nw_products is 
            select *
              from NW_PRODUCTS
            where p_product_id = product_id;
             v_prod NW_PRODUCTS%ROWTYPE;

        NO_PRODUCT_FOUND EXCEPTION;
        PRAGMA EXCEPTION_INIT(NO_PRODUCT_FOUND, -20003);
     begin
        open c_nw_products;
            fetch c_nw_products into v_prod;
        if(c_nw_products%NOTFOUND)
        then
            close c_nw_products;    
        raise NO_PRODUCT_FOUND;
        end if;

        close c_nw_products;
        return v_prod.discontinued;
            
     exception
     when NO_PRODUCT_FOUND 
     then
        my_application_error(-20003);   
       
     end part_discontinued;
    --
    --
    -- ---------------------------------------------------
    --
    -- Procedure: add_item
    --     Input: p_order_id    - the order id that this item belongs to
    --            p_product_id  - The product id of the product that id being ordered
    --            p_quantity    - the quantity of the product that is being ordered
    --            p_discount    - the amount of the discount being applied to this item
    --    Schema: North Wind
    --
    -- Create a new order detail record in the NW_ORDER_DETAILS table
    -- Exceptions:
    --      "Order does not exist" - if the order does not exist
    --      "Product does not exist" - if the product does not exist
    --      "Quantity must be > 0" - if the quantity is null or < 0
    --      "Discount must be >= 0" - if the discount is null or < zero
    --
    -- Marks: 5
    -- ---------------------------------------------------
    --
    procedure add_item(
                       p_order_id  NW_ORDER_DETAILS.ORDER_ID%TYPE,
                       p_product_id NW_ORDER_DETAILS.PRODUCT_ID%TYPE,  
                       p_quantity NW_ORDER_DETAILS.QUANTITY%TYPE,
                       p_discount NW_ORDER_DETAILS.DISCOUNT%TYPE
                      ) is
        cursor c_order is
            select *
              from NW_ORDER_DETAILS
             where p_order_id = order_id;
        v_order NW_ORDER_DETAILS%ROWTYPE;         
        
        cursor c_product is
            select *
              from NW_ORDER_DETAILS
             where p_product_id = product_id;
        v_product NW_ORDER_DETAILS%ROWTYPE; 
        
        NO_ORDER_FOUND EXCEPTION;
        PRAGMA EXCEPTION_INIT(NO_ORDER_FOUND, -20011);
    
        NO_PRODUCT_FOUND EXCEPTION;
        PRAGMA EXCEPTION_INIT(NO_PRODUCT_FOUND, -20003);
    
        INVALID_QUANTITY EXCEPTION;
        PRAGMA EXCEPTION_INIT(INVALID_QUANTITY, -20005);
    
        INVALID_DISCOUNT EXCEPTION;
        PRAGMA EXCEPTION_INIT(INVALID_DISCOUNT, -20016);
    
        CHECK_CONSTRAINT_VIOLATED EXCEPTION;
        PRAGMA EXCEPTION_INIT(CHECK_CONSTRAINT_VIOLATED, -2290);
    
        UNIQUE_CONSTRAINT_VIOLATION EXCEPTION; 
        PRAGMA EXCEPTION_INIT(UNIQUE_CONSTRAINT_VIOLATION, -0001); 

    begin
        open c_order;
          fetch c_order into v_order;
        if(c_order%NOTFOUND)
        then
            close c_order;
        raise NO_ORDER_FOUND;
        end if;
    
        open c_product;
          fetch c_product into v_product;
        if(c_product%NOTFOUND)
        then
            close c_product;
        raise NO_PRODUCT_FOUND;
        end if;
        
        if(p_quantity < 0 or p_quantity is null)
        then
            raise INVALID_QUANTITY;
        end if;
        
        if(p_discount < 0 or p_discount is null)
        then
            raise INVALID_DISCOUNT;
        end if;
        close c_product;
        close c_order;
    
        insert into NW_ORDER_DETAILS(
                                    order_id,
                                    product_id,
                                    quantity,
                                    discount
                                    )
        values (p_order_id, 
                p_product_id, 
                p_quantity,
                p_discount
                );
        
    exception
    when CHECK_CONSTRAINT_VIOLATED
    then
        DBMS_OUTPUT.PUT_LINE('INSERT failed due to check constraint violation');
    
    when NO_ORDER_FOUND 
    then
        my_application_error(-20011); 
    
    when NO_PRODUCT_FOUND
    then
        my_application_error(-20003);

    when INVALID_QUANTITY 
    then
        my_application_error(-20005);

    when INVALID_DISCOUNT 
    then
        my_application_error(-20016);

    when UNIQUE_CONSTRAINT_VIOLATION
    then
        dbms_output.put_line( 'Unique constraint violation' );      
    end add_item;
    --
    --
    -- ---------------------------------------------------
    --
    -- Procedure: report_basket_content
    --    Input: None
    --    Schema: BrewerBean
    -- Report on basket content
    --  For every basket
    --      Display the basket id
    --      Display the shoppers first name followed by a comma followed by the lst name
    --      For every basket item
    --          List the basket item
    --          The quantity
    --          The Price
    --          The description
    --      After the baket items
    --          Display the total quantity
    --          Display the total prices
    --
    -- Sample Report
    --
    -- Basket Shopper Name
    -- ------ ----------------------------------
    --      4 John, Carter
    --        Item # Qty   Price   Total Product Description
    --        ------ --- ------- ------- ----------------------------------
    --            17   1   28.50   28.50 Avoid blade grinders! This mill grinder allows you to choose a fine grind to a coarse grind.
    --        ------ --- ------- ------- ----------------------------------
    --                 1           28.50
    --  
    -- Basket Shopper Name
    -- ------ ----------------------------------
    --      3 John, Carter
    --        Item # Qty   Price   Total Product Description
    --        ------ --- ------- ------- ----------------------------------
    --            15   1    5.00    5.00 heavy body, spicy twist, aromatic and smokey flavor.
    --            16   2   10.80   21.60 well-balanced mellow flavor, a medium body with hints of cocoa and a mild, nut-like aftertaste
    --        ------ --- ------- ------- ----------------------------------
    --                 3           26.60
    --
    -- Marks: 5
    -- ---------------------------------------------------
    --
    procedure report_basket_content is
         cursor c_basket_shopper is 
            select BB_BASKET.idbasket,
                   BB_SHOPPER.firstname,
                   BB_SHOPPER.lastname
              from BB_BASKET,
                   BB_SHOPPER
       
            where BB_BASKET.IDSHOPPER = BB_SHOPPER.IDSHOPPER;
     
            basket_shopper_rec c_basket_shopper%ROWTYPE;
            v_total_price number(10,2);
            v_total_qty number(10);
    begin
        open c_basket_shopper;
        loop
            fetch c_basket_shopper into basket_shopper_rec;
        exit when c_basket_shopper%NOTFOUND;

        dbms_output.put_line('Basket ' || 'Shopper Name' );
        dbms_output.put_line('------ ' || '------------');
        dbms_output.put_line(to_char(basket_shopper_rec.idbasket,'99999') || 
                                                              ' ' || basket_shopper_rec.firstname 
                                                                  || ', ' || basket_shopper_rec.lastname);
        
        dbms_output.put_line('       ' || 'Item#  ' || 'Qty  ' || 'Price  '  ||  'Total  ' || 'Product Description');
        dbms_output.put_line('       ' || '-----  ' || '---  ' || '-----  '  ||  '-----  ' || '------------------- ');
        
        v_total_price:=0;
        v_total_qty:= 0;

            for v_items in (select BB_BASKETITEM.idbasketitem,
                                   BB_BASKETITEM.quantity,
                                   BB_BASKETITEM.price,
                                   BB_PRODUCT.description
                              from BB_BASKETITEM,BB_PRODUCT 
                             where idbasket = basket_shopper_rec.idbasket and
                                   BB_BASKETITEM.idproduct = BB_PRODUCT.idproduct
                        )
            loop
            dbms_output.put_line('       ' || to_char(v_items.idbasketitem,'9999') 
                                           || to_char(v_items.quantity,'9999')
                                           || to_char(v_items.price,'999.99')
                                           ||to_char(v_items.price * v_items.quantity,'999.99')
                                           ||'  ' 
                                           || v_items.description
                                ); 

            v_total_price := (v_items.price * v_items.quantity) + v_total_price;
            v_total_qty := v_items.quantity + v_total_qty;  
    
            end loop;

            dbms_output.put_line('       ' || '-----  ' || '---  ' || '-----  '  ||  '-----  ' || '-------------------');

            dbms_output.put_line('       ' || '       ' 
                                           || to_char(v_total_qty,'99') 
                                           || '     '  
                                           ||  to_char(v_total_price,'99999.99')
                                );
       end loop;
    end report_basket_content;
        

begin
    slavkos2.SS_Slavko.ss_set_user('Loopnova_Boaconic_Modeflick', my_number);
end Final_Util;
/
show errors

