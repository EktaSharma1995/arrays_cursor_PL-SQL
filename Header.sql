create or replace package Final_Util as


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
    function my_Number return varchar;
 
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
    function my_Name   return varchar;
 
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
    procedure my_application_error(p_err_code   in  number);
 
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
            return varchar2;
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
                        );
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
    procedure report_basket_content;

    --
 
end Final_Util;
/
show errors



