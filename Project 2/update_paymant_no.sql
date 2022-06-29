CREATE OR REPLACE procedure update_paymant_no
is
      pay_inst_no number;
           cursor cont_cursor is
                select *
                from contracts;
begin

    for cont_record in cont_cursor loop  
         if cont_record.CONTRACT_PAYMENT_TYPE = 'ANNUAL' then
            update contracts
            set PAYMENTS_INSTALLMENTS_NO= months_between(cont_record.CONTRACT_ENDDATE, cont_record.CONTRACT_STARTDATE) /12
            where contract_id = cont_record.contract_id ;
            
         elsif cont_record.CONTRACT_PAYMENT_TYPE = 'QUARTER' then
            pay_inst_no := months_between(cont_record.CONTRACT_ENDDATE, cont_record.CONTRACT_STARTDATE) /3;
                    update contracts
            set  PAYMENTS_INSTALLMENTS_NO= pay_inst_no
             where contract_id = cont_record.contract_id ;
           
         elsif cont_record.CONTRACT_PAYMENT_TYPE = 'HALF_ANNUAL' then
            pay_inst_no := months_between(cont_record.CONTRACT_ENDDATE, cont_record.CONTRACT_STARTDATE) /6;
                    update contracts
            set PAYMENTS_INSTALLMENTS_NO= pay_inst_no
             where contract_id = cont_record.contract_id ;
              
         ELSIF cont_record.CONTRACT_PAYMENT_TYPE = 'MONTHLY' THEN
            pay_inst_no := months_between(cont_record.CONTRACT_ENDDATE, cont_record.CONTRACT_STARTDATE) /1;
                    update contracts
            set PAYMENTS_INSTALLMENTS_NO= pay_inst_no
             where contract_id = cont_record.contract_id ;
                
          end if;         
     
                
    end loop;
end;
show error