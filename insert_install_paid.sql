CREATE OR REPLACE procedure insert_install_paid
is
cursor cont_cursor is
                select * from contracts;
v_date date ;
v_amount number;
v_paid number :=0;  
i number ; 
             
begin
for cont_record in cont_cursor loop  

        v_date :=CONT_RECORD.CONTRACT_STARTDATE;
        
         v_amount := ((cont_record.CONTRACT_TOTAL_FEES - NVL(cont_record.CONTRACT_DEPOSIT_FEES,0)) / cont_record.PAYMENTS_INSTALLMENTS_NO);
         
         INSERT INTO installments_paid (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE,INSTALLMENT_AMOUNT, PAID)
         VALUES (inst_paid_seq.nextval ,cont_record.CONTRACT_ID, v_date ,v_amount, v_paid);

      for i in 2..cont_record.PAYMENTS_INSTALLMENTS_NO loop
       
            if cont_record.CONTRACT_PAYMENT_TYPE = 'ANNUAL' then
                 v_date := add_months(v_date,12);
      
            elsif cont_record.CONTRACT_PAYMENT_TYPE = 'QUARTER'  then
                 v_date := add_months (v_date ,3);
                           
            elsif cont_record.CONTRACT_PAYMENT_TYPE = 'HALF_ANNUAL'  then
                v_date := add_months (v_date ,6);
                      
            ELSIF cont_record.CONTRACT_PAYMENT_TYPE = 'MONTHLY'  THEN
                 v_date := add_months (v_date ,1);
                  
            end if;
            
             
           INSERT INTO installments_paid (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE,INSTALLMENT_AMOUNT, PAID)
           VALUES (inst_paid_seq.nextval ,cont_record.CONTRACT_ID, v_date,v_amount, v_paid);
           
   
   end loop;
   

END LOOP;
end;