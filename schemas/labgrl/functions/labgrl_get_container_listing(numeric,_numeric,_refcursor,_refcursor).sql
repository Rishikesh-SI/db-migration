-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_get_container_listing(numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labgrl_get_container_listing(numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_get_container_listing(p_cont_id numeric, p_is_mobile numeric, p_container_list refcursor, p_divice_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

   

declare 
v_cont_id varchar(200) :=' ';
begin 

if p_cont_id is not null then 
 
   v_cont_id :='and parent_id = '||p_cont_id ;

end if; 

open p_container_list for
select * from labgrl.labgrl_container
where is_active=1
and is_published=1
and is_deleted=0
-- and is_mobile = p_is_mobile
and parent_id is null;

open p_divice_list for execute '
select * from labgrl.labgrl_container
where is_active=1
and is_published=1
and is_deleted=0
 and is_mobile = '||p_is_mobile||'
' ||v_cont_id || ' order by order_number'
;

end

   

 $$;


--
