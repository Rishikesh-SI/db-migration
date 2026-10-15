-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: tmm_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_navigation_r(p_parent_id numeric, p_template_comp_map_id numeric[], p_entity character varying, p_menu_cur refcursor, p_navigation_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
declare
	       -- i record ;
	       -- p_parent_id numeric :=222;
	        --p_template_comp_map_id numeric[] :=array[3512];
	       -- p_entity character varying := '4';
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
            v_lang_filter_query varchar(1000) := ' ';
            v_menu_array numeric[];
            v_template_id numeric;
            v_lang_id numeric;
            v_page_entity varchar;
            
         v_menu_id numeric;
         v_array numeric[] ;
          v_array1 numeric[] ;
		    v_array2  numeric[];
         v_result varchar ;-- boolean ;
         v_menu_array1 numeric[];
         v_page_tc_array numeric[];
         v_menu_array2   numeric[];
         v_menuentity numeric[];
         v_menuentity1 numeric[];
         v_page_tc_array1 numeric[];
         v_lang_page varchar[];
         
         vcount numeric;
         
         v_userjsonarr jsonb ;
         
         v_temp numeric;
         v_menu_id1 numeric;
         
         v_query varchar(200);
		v_fetch_from numeric;
		v_widget_array numeric[];
		
		v_menu_id_finel numeric;
		v_widget_id_finel numeric;
		
    begin
    
		
 if p_parent_id =0 then 
 v_lang_id:= p_entity ;
 else 
 select  entity_role_map_id into  v_lang_id
 from tmm.tmm_asset_entity_map
 where asset_type_id = 11
 and asset_id=p_parent_id
 and entity_role_map_id in (select b.entity_role_map_id
 from tmm.tmm_entity_category a
 join tmm.tmm_entity_role_map b on a.entity_role_id=b.entity_role_id 
 where category_name='Language');   
 
 end if ;
    
    
    
    if p_parent_id=0 then 
      v_query:=' template_component_map_id in ( select menu_id from unnest($1) menu_id)';
	  
	 -- select menu_id from unnest(v_menu_array) menu_id
	  
   else 
      --v_query:=' page_id='||p_parent_id;
	   v_query:=' template_component_map_id in ( select menu_id from unnest($1) menu_id)';
     end if ;
   
 if    p_parent_id=0 then 
execute 'select template_id 
  
 from tmm.tmm_template_component_map 
 where '||v_query ||'
 -- parent_id=p_parent_id -- 
 -- page_id = p_parent_id
order by 1   limit 1
'
 
 into   v_template_id
 using p_template_comp_map_id
 ;
 
 else 
 execute 'select template_id 
  
 from tmm.tmm_template_component_map 
 where '||v_query
 -- parent_id=p_parent_id -- 
 -- page_id = p_parent_id
--  limit 1
 
into   v_template_id
 using p_template_comp_map_id
 ;
 
 
 
 /*
 ----------------
 with recursive whosYourDaddy as (

  --start with the "anchor" row
  select
    *
  from tmm.tmm_template
  where
    template_id = v_template_id --parameterize me

  union all

  select
    a.*
  from tmm.tmm_template a
  join whosYourDaddy on whosYourDaddy.parent_id = a.template_id
)

select
  layout_id into v_template_id
from whosYourDaddy 
--where is_master=1
order by
  template_id
  ;
 */
 
 end if;
 --------------------------
 
 
 -- raise notice '%',v_lang_id;
 --raise notice '% test',v_template_id; 
  
 -- from tmm.tmm_template 
-- where '||v_query;
 --  select 1/0;

if (v_template_id is not null or (v_template_id is null and coalesce(p_parent_id,0) = 0)) then
raise notice '%  test 1',v_template_id ;

if p_parent_id=0 then 
select string_agg(p_entity::text,',') 
  into v_page_entity;
  else 
  select string_agg(entity_role_map_id::text,',') 
  into v_page_entity
  from tmm.tmm_asset_entity_map
  where asset_id = p_parent_id
  and asset_type_id=11;
  end if
  ;
 
    
execute '
  select array_to_json(array_agg(a))
                               	    from(
 select 
template_component_map_id,
template_id,
fetch_from , 
tcentity ,
page_ent,
(case when fetch_from=1 
	  then array_cat((case when tcentity =''{null}'' then null else tcentity end),page_ent::varchar[] ) 
	  else tcentity end ) as tcpageenti,
 menu_id,
 case when array_length(menuentity,1)=1 then null else menuentity end as menuentity
from (
select 
a.template_component_map_id,
a.template_id,
fetch_from ,
array_agg(distinct b.entity_role_map_id::varchar) as tcentity,
(  select array_agg(entity_role_map_id::text) 
  from tmm.tmm_asset_entity_map
  where asset_id= '|| p_parent_id::varchar || '
  and asset_type_id=11)as page_ent,
c.menu_id,
array_agg(distinct d.entity_role_map_id::varchar) as menuentity
from tmm.tmm_template_component_map a
inner join tmm.tmm_template t 
on (a.template_id = t.template_id)
left join tmm.tmm_asset_entity_map b on b.asset_id=a.template_component_map_id  and b.asset_type_id=13   
left join tmm.tmm_page_template_component_menu_map c 
on (c.template_component_map_id=a.template_component_map_id and c.is_active=1
	and c.is_deleted=0 )
left join tmm.tmm_asset_entity_map d on d.asset_id=c.menu_id and d.asset_type_id=22
where (a.template_id =  '||coalesce(v_template_id,0)::varchar||' or '||coalesce(v_template_id,0)::varchar||' = 0)
and coalesce(t.is_master,0) = (case when '|| p_parent_id::varchar ||' = 0 then 1 else 0 end)
and a.template_component_map_id in (select * from unnest($1)tcm ) 
and a.is_active=1
and a.is_deleted=0
and t.is_active=1
and t.is_deleted=0
group by a.template_component_map_id,
a.template_id,
a.fetch_from,
c.menu_id
)a
where menu_id is not null
)a
'
into v_userjsonarr 
using p_template_comp_map_id;
-- ** --

raise notice '% test2',v_userjsonarr;
 
select elem->>'template_component_map_id' into v_temp
from   

 json_array_elements(v_userjsonarr::json) as elem
 ;

  

    select array( 
    select elem->>'template_component_map_id' 
from   
 json_array_elements(v_userjsonarr::json) as elem
 where elem->>'menuentity' is not null
        )a into v_array 
 ;
      select array( 
      select elem->>'template_component_map_id' 
      from   
      json_array_elements(v_userjsonarr::json) as elem
      where elem->>'menuentity' is  null
       )a into v_array1 
 ;
  
  
  raise notice '% test array',v_array1;
   
   select elem->>'fetch_from' into v_fetch_from
from   
 
 json_array_elements(v_userjsonarr::json) as elem
 ;
   
   
   
 select count(1) into vcount 
from   
 json_array_elements(v_userjsonarr::json) as elem
 where (elem->>'template_component_map_id')::numeric in (select * from unnest(v_array))
 and   elem->>'menuentity' is not null
 ;
  
    
   
   
   if vcount > 0 then 
   
  --  raise notice 'in loop : 1  '  ;
    
           if array_length(v_array,1)!=0 then 
  
  -- 	raise notice 'in loop : 2 ' ;
  --select array_length(array[1,4],1)
    
  for i in 1..array_length(v_array,1)
     loop
     	-- raise notice 'in loop : 3 % ' ,v_array[i] ;
          if exists (select 1 from tmm.tmm_page_template_component_menu_map 
                    where template_component_map_id =v_array[i])
              then 
			
			       -- select fetch_from into v_fetch_from  from tmm.tmm_page_template_component_menu_map 
                    --where template_component_map_id =v_array[i];
                   
                     raise notice 'in loop : 4 % ' ,v_fetch_from ;
                    
                     select  menu_id into v_menu_id
                     from tmm.tmm_page_template_component_menu_map 
                     where  template_component_map_id = v_array[i];
                            select array_agg(entity_role_map_id order by entity_role_map_id)  into v_menu_array
                            from tmm.tmm_asset_entity_map
                            where asset_id=v_menu_id
                            and asset_type_id=22
							              and is_deleted=0
							              and is_active=1;
							
							select array_agg(entity_role_map_id order by entity_role_map_id)  into v_widget_array
                            from tmm.tmm_asset_entity_map
                            where asset_id= v_array[i]
                            and asset_type_id=13
							and is_deleted=0
							and is_active=1;
							
							raise notice 'in loop :1 % ' ,v_menu_array;
							raise notice 'in loop :12 % ' ,v_widget_array;
							--SELECT sort(v_menu_array) into v_menu_array;
							-- CREATE EXTENSION intarray;
 						   -- raise notice 'in loop :111 % ' ,v_menu_array;
							
							
							select v_menu_array=v_widget_array into v_result;
							
							if v_result='true' then 
							     v_menu_id_finel := v_menu_id ;
								 v_widget_id_finel := v_array[i] ;
								else 
								
								 v_menu_id_finel := null ;
								 v_widget_id_finel := null ;
								end if ;
	
          end if;  
   end loop;
   end if;
  
 else 
if array_length(v_array1,1)!=0 then 
 
    
  for i in 1..array_length(v_array1,1)
     loop
     	-- raise notice 'in loop : 3 % ' ,v_array[i] ;
          if exists (select 1 from tmm.tmm_page_template_component_menu_map 
                    where template_component_map_id =v_array1[i])
              then 
			
			       -- select fetch_from into v_fetch_from  from tmm.tmm_page_template_component_menu_map 
                    --where template_component_map_id =v_array[i];
                   
                     raise notice 'in loop : 4 % ' ,v_fetch_from ;
                    
                     select  menu_id into v_menu_id
                     from tmm.tmm_page_template_component_menu_map 
                     where  template_component_map_id = v_array1[i]
					 and is_deleted=0
					and is_active=1;
               
                            select array_agg(entity_role_map_id order by entity_role_map_id)  into v_menu_array
                            from tmm.tmm_asset_entity_map
                            where asset_id=v_menu_id
                            and asset_type_id=22
							              and is_deleted=0
							              and is_active=1;
							
							select array_agg(entity_role_map_id order by entity_role_map_id)  into v_widget_array
                            from tmm.tmm_asset_entity_map
                            where asset_id= v_array1[i]
                            and asset_type_id=13
							and is_deleted=0
							and is_active=1;
							
							raise notice 'in loop :1 % ' ,v_menu_array;
							raise notice 'in loop :12 % ' ,v_widget_array;
							
							
							--select v_menu_array=v_widget_array into v_result;
							
							--if v_result='true' then 
							     v_menu_id_finel := v_menu_id ;
								 v_widget_id_finel := v_array[i] ;
								--else 
								
								-- v_menu_id_finel := null ;
								-- v_widget_id_finel := null ;
								--end if ;
	
          end if;  
   end loop;
   end if;

end if ; -- pppp

if p_parent_id =0 then 

   
    if array_length(v_array,1)!=0   then 
   
      for i in 1..array_length(v_array,1)
     loop
     	-- raise notice 'in loop : 3 % ' ,v_array[i] ;
          if exists (select 1 from tmm.tmm_page_template_component_menu_map 
                    where template_component_map_id =v_array[i])
              then 
			
			       -- select fetch_from into v_fetch_from  from tmm.tmm_page_template_component_menu_map 
                    --where template_component_map_id =v_array[i];
                   
                     raise notice 'in loop : 4 % ' ,v_fetch_from ;
                    
                     select  menu_id into v_menu_id
                     from tmm.tmm_page_template_component_menu_map 
                     where  template_component_map_id = v_array[i];
               
                            select array_agg(entity_role_map_id order by entity_role_map_id)  into v_menu_array
                            from tmm.tmm_asset_entity_map
                            where asset_id=v_menu_id
                            and asset_type_id=22
							and is_deleted=0
							and is_active=1;
							
							select array_agg(entity_role_map_id order by entity_role_map_id)  into v_widget_array
                            from tmm.tmm_asset_entity_map
                            where asset_id= v_array[i]
                            and asset_type_id=13
							and is_deleted=0
							and is_active=1;
							
							raise notice 'in loop :1 % ' ,v_menu_array;
							raise notice 'in loop :12 % ' ,v_widget_array;
							--SELECT sort(v_menu_array) into v_menu_array;
							-- CREATE EXTENSION intarray;
 						   -- raise notice 'in loop :111 % ' ,v_menu_array;
							
							
							select v_menu_array=v_widget_array into v_result;
							
							if v_result='true' then 
							     v_menu_id_finel := v_menu_id ;
								 v_widget_id_finel := v_array[i] ;
								else 
								
								 v_menu_id_finel := null ;
								 v_widget_id_finel := null ;
								end if ;
	
          end if;  
   end loop;
   
  select array(select v_menu_id_finel) into v_menu_array ;
   
   else 
   ---
         select array_agg(entity_role_map_id order by entity_role_map_id)  into v_widget_array
                            from tmm.tmm_asset_entity_map
                            where asset_id in  (select * from unnest(p_template_comp_map_id)tcm )
                            and asset_type_id=13
							and is_deleted=0
							and is_active=1;
							
    if array_length(v_widget_array,1)!=0 then 
	
	       select array_agg(entity_role_map_id order by entity_role_map_id)  into v_menu_array
                            from tmm.tmm_asset_entity_map
                            where asset_id=v_menu_id1
                            and asset_type_id=22
							and is_deleted=0
							and is_active=1;
	
	      select  v_widget_array=v_menu_array into v_result;
		
		        if v_result='false' then 	
								 v_menu_array := null ;
								 v_widget_id_finel := null ;
								end if ;
								
				--raise notice '% test entity12',v_menu_array;				
			else 	   
   
   
         

select ARRAY(
SELECT elem->>'menu_id' 
FROM   
 json_array_elements(v_userjsonarr::json) AS elem
 where elem->>'menuentity' is null) into v_menu_array;
 
select array(select asset_id 
from tmm.tmm_asset_entity_map
where asset_id in (select menu_id from unnest(v_menu_array) menu_id)
and asset_type_id=22
and entity_role_map_id=p_entity::numeric
and is_deleted=0
and is_active=1 )a into v_menu_array
;
 end if ;
 end if;
 
 else 
 select array(select v_menu_id_finel) into v_menu_array ;
 
 

end if;

-------------------
                  raise notice 'v_menu_id % ' ,v_menu_id ;

 raise notice 'v_menu_array %',v_menu_array;
-- select 1/0;
open p_menu_cur for  
select * from tmm.tmm_menu
where menu_id in (select menu_id from unnest(v_menu_array) menu_id)
and is_active=1
and is_deleted=0
and is_published=1;
    
open p_navigation_cur for      
select a.*, p.alias ,b.template_component_map_id 
from tmm.tmm_menu_page_map a
join tmm.tmm_page_template_component_menu_map b 
on (b.menu_id=a.menu_id and b.template_component_map_id in (select * from unnest(p_template_comp_map_id)tcm ) )
join tmm.tmm_page p on(a.page_id = p.page_id)
where a.menu_id  in (select menu_id from unnest(v_menu_array) menu_id)
and b.is_active=1 and b.is_deleted=0
and a.is_active=1
and a.is_deleted=0
and p.is_active=1
and p.is_deleted=0

order by a.order_number
;

open p_page_ent_cur for 
     select *,tmm.tmm_get_entity_known_as(entity_role_map_id) known_as  
	 from tmm.tmm_asset_entity_map
     where asset_type_id = 11
     and asset_id in (p_parent_id);
   
   
   
 -- end if;  ---rakesh
 --  drop table v_temp_copmdata; --pppppp
 -- drop table v_menu_data;  ---ppp
--  **** --
else  -- added by purushottam on date 20170828, to handle the condition when page id not pass 
	
    open p_menu_cur for  
select * from tmm.tmm_menu
where 1 = 0 ;
    
open p_navigation_cur for      
select a.*, p.alias ,b.template_component_map_id 
from tmm.tmm_menu_page_map a
join tmm.tmm_page_template_component_menu_map b on b.menu_id=a.menu_id 
join tmm.tmm_page p on(a.page_id = p.page_id) 
where 1 = 0
;

open p_page_ent_cur for 
     select *,tmm.tmm_get_entity_known_as(entity_role_map_id) known_as 
     from tmm.tmm_asset_entity_map
     where 1 = 0;

 end if;
  --  first if close
   

end;
$_$;


--
