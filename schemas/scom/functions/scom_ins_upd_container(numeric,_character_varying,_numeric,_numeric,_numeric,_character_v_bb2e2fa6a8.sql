-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_ins_upd_container(numeric, character varying, numeric, numeric, numeric, character varying, character varying)
-- Type: FUNCTION

-- Name: scom_ins_upd_container(numeric, character varying, numeric, numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: scom; Owner: -
--

CREATE FUNCTION scom.scom_ins_upd_container(p_cont_id numeric, p_column_ratio character varying, p_updated_by numeric, p_status numeric, p_is_custom numeric, p_img_file_name character varying, p_image_path character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

  

declare
v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
v_container_guid varchar;
v_cont_id numeric;
v_cont_scomle character varying;
p_ord_number numeric ;
v_cont_scom text[]:=array['xl','lg','md','sm','xsl','xs'];
v_ord_num numeric[]:=array[1,2,3,4,5,6];
begin
      
       v_cont_scomle := replace(p_column_ratio, ':', '_');
       
       select max(order_number) into p_ord_number
       from scom.scom_container ;
       
       -- if p_order_number is not null 
       -- then 
     --  p_order_number:=p_ord_number+1;
     -- end if ;
       
       
      if p_cont_id is  null  then 
      
      
           v_cont_id :=nextval('scom.seq_scom_container_id');
           v_container_guid:=uuid_generate_v4();
            
          insert into scom.scom_container 
             (  container_id,
                container_label,
                column_ratio,
                created_date,
                updated_date,
                created_by,
                updated_by,
                is_active,
                is_deleted,
                is_published,
                published_date,
                container_guid,
                order_number,
                image_file_name,
                image_path,
              waf_component_type_id,
              client_id,
              is_custom,
              parent_id,
              is_mobile
                )
                values
                (
                v_cont_id,
                v_cont_scomle,
                p_column_ratio ,  
                v_currenttimestamp,
                v_currenttimestamp,
                p_updated_by,
                p_updated_by,
                    1,
                    0,
                 p_status,
                 v_currenttimestamp,
                 v_container_guid,
                 p_ord_number +1,
                 p_img_file_name,
                 p_image_path,
                    1,
                    1,
                 p_is_custom,
                 null,
                 null
                );
                
                p_result:=v_cont_id
                
                ;

insert into scom.scom_container 
select nextval('scom.seq_scom_container_id'), 
container_scomel,
column_ratio,
created_date,
updated_date,
created_by,
updated_by,
is_active,
is_deleted,
is_published,
published_date,
container_guid,
order_number,
image_file_name,
image_path,
 waf_component_type_id,
 client_id,
 is_custom,
 parent_id,
 is_mobile
from
(
select unnest(v_cont_scom) container_scomel, 
   p_column_ratio column_ratio,
	   v_currenttimestamp created_date, v_currenttimestamp updated_date, p_updated_by created_by, p_updated_by updated_by, p_status is_active,
	   0 is_deleted, 1 is_published, v_currenttimestamp published_date, v_container_guid container_guid,unnest(v_ord_num) order_number,
	   null image_file_name, null image_path, 1 waf_component_type_id, 1 client_id, p_is_custom is_custom, v_cont_id parent_id, 0 is_mobile
union
select unnest(v_cont_scom) container_scomel,
    p_column_ratio column_ratio,
	   v_currenttimestamp created_date, v_currenttimestamp updated_date, p_updated_by created_by, p_updated_by updated_by, p_status is_active,
	   0 is_deleted, 1 is_published, v_currenttimestamp published_date, v_container_guid container_guid, unnest(v_ord_num) order_number,
	   null image_file_name, null image_path, 1 waf_component_type_id, 1 client_id, p_is_custom is_custom, v_cont_id parent_id, 1 is_mobile
) as tab;
             
       
 else 
    update scom.scom_container
      set column_ratio=p_column_ratio,
          updated_by =p_updated_by,
          updated_date=v_currenttimestamp,
          is_custom =p_is_custom
      where container_id=p_cont_id
  
      ;
          p_result:=p_cont_id; 
        
        end if ;

exception 
when others then p_result:=-1;
end

  

 $$;


--
