begin
    
  for pk in (select a.constraint_name, b.column_name, a.table_name
               from user_constraints a, user_cons_columns b
              where (a.constraint_type = 'P' 
                and a.constraint_name = b.constraint_name)
                and b.POSITION=1)
  loop

    execute immediate 'create sequence key_' ||pk.table_name || ' start with 3000 increment by 5 minvalue 1';                

    execute immediate 'create or replace trigger trg_pk_' || pk.table_name ||
                      '  before insert on ' || pk.table_name ||
                      '  for each row ' || 
                      'begin ' ||
                      '  :new.' || pk.column_name || ' := key_' || pk.table_name || ' .nextval; ' ||
                      'end; ';
  end loop;
end;
show error
--select * from user_errors;
