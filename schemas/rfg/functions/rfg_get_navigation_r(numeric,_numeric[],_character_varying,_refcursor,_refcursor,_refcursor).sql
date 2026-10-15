-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: rfg_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_get_navigation_r(p_parent_id numeric, p_template_comp_map_id numeric[], p_entity character varying, p_menu_cur refcursor, p_navigation_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
 

    

    declare
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
    begin
    
	
	if p_parent_id =0 then 
	v_lang_id:= p_entity ;
   else 
 select  entity_role_map_id into  v_lang_id
 from rfg.rfg_asset_entity_map
 where asset_type_id = 11
 and asset_id=p_parent_id
 and entity_role_map_id in (select b.entity_role_map_id
 from rfg.rfg_entity_category a
 join rfg.rfg_entity_role_map b on a.entity_role_id=b.entity_role_id 
 where category_name='language');   
 
 end if ;
    
    
    
    if p_parent_id=0 then 
   v_query:=' parent_id='||p_parent_id ;
   else 
     v_query:=' page_id='||p_parent_id;
     end if ;
   
 if    p_parent_id=0 then 
execute 'select template_id 
  
 from rfg.rfg_template 
 where '||v_query ||'
 -- parent_id=p_parent_id -- 
 -- page_id = p_parent_id
order by 1   limit 1'
 
 into   v_template_id
 ;
 
 else 
 execute 'select parent_id 
  
 from rfg.rfg_template 
 where '||v_query
 -- parent_id=p_parent_id -- 
 -- page_id = p_parent_id
--  limit 1
 
 into   v_template_id
 ;
 end if;
 
 -- raise notice '%',v_lang_id;
 raise notice '% test',v_template_id; 
  
 -- from rfg.rfg_template 
-- where '||v_query;
 --  select 1/0;

if (v_template_id is not null or (v_template_id is null and coalesce(p_parent_id,0) = 0)) then

raise notice 'value 1  ' ;

if p_parent_id=0 then 
select string_agg(p_entity::text,',') 
  into v_page_entity;
  else 
  select string_agg(entity_role_map_id::text,',') 
  into v_page_entity
  from rfg.rfg_asset_entity_map
  where asset_id = p_parent_id
  and asset_type_id=11;
  end if
  ;
 
-- select 1/0;

 /*create temp table  v_temp_copmdata
	(
        template_component_map_id     numeric,
        template_id      numeric,
        fetch_from   numeric    ,
        temp_entity_data varchar ,
        page_entity_data varchar,
        tcpageenti  varchar,
        menu_id numeric,
        menuentity varchar
    );
   */ 
    raise notice 'value 2 ' ; 
   
    
execute '-- insert into v_temp_copmdata
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
  from rfg.rfg_asset_entity_map
  where asset_id= '|| p_parent_id::varchar || '
  and asset_type_id=11)as page_ent,
c.menu_id,
array_agg(distinct d.entity_role_map_id::varchar) as menuentity
from rfg.rfg_template_component_map a
inner join rfg.rfg_template t 
on (a.template_id = t.template_id)
left join rfg.rfg_asset_entity_map b on b.asset_id=a.template_component_map_id  and b.asset_type_id=13   
left join rfg.rfg_page_template_component_menu_map c 
on (c.template_component_map_id=a.template_component_map_id and c.is_active=1
	and c.is_deleted=0 )
left join rfg.rfg_asset_entity_map d on d.asset_id=c.menu_id and d.asset_type_id=22
where (a.template_id = '||coalesce(v_template_id,0)::varchar||' or '||coalesce(v_template_id,0)::varchar||' = 0)
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

raise notice '% test array ',v_userjsonarr;
 --  select 1/0;
select elem->>'template_component_map_id' into v_temp
from   
 -- json_array_elements('[{"menu_id": 1, "page_ent": null, "tcentity": [null], "fetch_from": 1, "menuentity": null, "tcpageenti": null, "template_id": 1, "template_component_map_id": 731}]') as elem
-- ;
 json_array_elements(v_userjsonarr::json) as elem
 ;
raise notice '% test array2 ',v_temp;

--  select 1/0;

-- create temp table v_menu_data
 -- (
  -- menu_id   numeric
 --  );

-- insert into v_menu_data
-- select menu_id from v_temp_copmdata
-- where menuentity is null ;

select elem->>'menu_id' into v_menu_id1
from   
 -- json_array_elements('[{"menu_id": 1, "page_ent": null, "tcentity": [null], "fetch_from": 1, "menuentity": null, "tcpageenti": null, "template_id": 1, "template_component_map_id": 731}]') as elem
-- ;
 json_array_elements(v_userjsonarr::json) as elem
 where elem->>'menuentity' is null
 ;

-- select array( 
-- select template_component_map_id from v_temp_copmdata
-- where (menuentity is not null )
  --  )a
    
    
  --   into v_array ;
    
    
    select array( 
    select elem->>'template_component_map_id' 
from   
 -- json_array_elements('[{"menu_id": 1, "page_ent": null, "tcentity": [null], "fetch_from": 1, "menuentity": null, "tcpageenti": null, "template_id": 1, "template_component_map_id": 731}]') as elem
-- ;
 json_array_elements(v_userjsonarr::json) as elem
 where elem->>'menuentity' is not null
        )a into v_array 
 ;
    
    raise notice 'array : % 1',v_array;
  --   select 1/0;
   raise notice '%',v_array;
    -- {7368,7369}
    
   -- select count(1) into vcount 
	-- from v_temp_copmdata
	-- where template_component_map_id in (select * from unnest(v_array))
	-- and (menuentity is not null );
   
   
 select count(1) into vcount 
from   
 json_array_elements(v_userjsonarr::json) as elem
 where (elem->>'template_component_map_id')::numeric in (select * from unnest(v_array))
 and   elem->>'menuentity' is not null
 ;
   
   
   
   
   
   if vcount >0 then 
   
  --  raise notice 'in loop : 1  '  ;
    
  if v_array is not null or v_array='{ }' then 
  
  -- 	raise notice 'in loop : 2 ' ;
    
  for i in 1..array_length(v_array,1)
     loop
     	-- raise notice 'in loop : 3 % ' ,v_array[i] ;
          if exists (select 1 from rfg.rfg_page_template_component_menu_map 
                    where template_component_map_id =v_array[i])
              then 
                   
          --          raise notice 'in loop : 4 % ' ,v_array[i] ;
                    
                     select  menu_id into v_menu_id
                     from rfg.rfg_page_template_component_menu_map 
                     where  template_component_map_id = v_array[i];
               
                           -- select array_agg(entity_role_map_id) into v_menu_array
                           -- from rfg.rfg_asset_entity_map
                            -- where asset_id=v_menu_id
                          --  and asset_type_id=22;
 					--	raise notice 'in loop : % ' ,v_array[i] ;
                        
                           select tcpageenti into v_page_tc_array
                           from  v_temp_copmdata
                           where template_component_map_id=v_array[i]
                           ;
                           
                           select menuentity into v_menuentity
                           from  v_temp_copmdata
                           where template_component_map_id=v_array[i];
                      
               -- select unnest(v_menuentity) into v_menuentity1
               -- order by 1;
               select array_agg(ab) into v_menuentity1 
               from
               (
               select distinct coalesce(a,'0')ab from unnest(v_menuentity)u(a) 
                order by 1
               )abc;
              
              	-- select unnest(v_page_tc_array) into v_page_tc_array1
                -- order by 1;
                select array_agg(ab) into v_page_tc_array1
                from 
                (
             	 select distinct coalesce(b,'0')ab from unnest(v_page_tc_array)u(b)  
                 union
                 select v_lang_id
                 order by 1
                )x;
                 
              -- raise notice 'page yc array : %',v_page_tc_array;
              -- raise notice 'menuentity : %',v_menuentity;
              
             -- select 1 / 0 ;
                 
                      
             select v_menuentity1=v_page_tc_array1 into v_result;
             
               if v_result='true'
               then                

                                             insert into v_menu_data
                                             select v_menu_id;

                                 --  drop table v_menu_data;
               end if;
     		
          end if;  
   end loop;
   end if;
   /*
 select array(select menu_id from v_menu_data) into v_menu_array;

open p_menu_cur for  
select * from rfg.rfg_menu
where menu_id in (select menu_id from unnest(v_menu_array) menu_id);
    
open p_navigation_cur for      
select a.*,b.template_component_map_id from rfg.rfg_menu_page_map a
join rfg.rfg_page_template_component_menu_map b on b.menu_id=a.menu_id 
where a.menu_id  
in (select menu_id from unnest(v_menu_array) menu_id)
and b.is_active=1 and b.is_deleted=0
and a.is_active=1
and a.is_deleted=0
;

open p_page_ent_cur for 
     select *,rfg.rfg_get_entity_known_as(entity_role_map_id) known_as  from rfg.rfg_asset_entity_map
     where asset_type_id = 11
     and asset_id in (p_parent_id);
   */
  -- else  rekesh 

end if ; -- pppp

select array(
select elem->>'menu_id' 
from   
 json_array_elements(v_userjsonarr::json) as elem
 where elem->>'menuentity' is null) into v_menu_array;
 
  
 if p_parent_id =0 then 
select array(select asset_id 
from rfg.rfg_asset_entity_map
where asset_id in (select menu_id from unnest(v_menu_array) menu_id)
and asset_type_id=22
and entity_role_map_id=p_entity::numeric
and is_deleted=0
and is_active=1 )a into v_menu_array
;
end if;
 
 -- raise notice '%','1212';
-- select 1/0;
open p_menu_cur for  
select * from rfg.rfg_menu
where menu_id in (select menu_id from unnest(v_menu_array) menu_id)
and is_active=1
and is_deleted=0
and is_published=1;
    
open p_navigation_cur for      
select a.*, p.alias ,b.template_component_map_id 
from rfg.rfg_menu_page_map a
join rfg.rfg_page_template_component_menu_map b 
on (b.menu_id=a.menu_id and b.template_component_map_id in (select * from unnest(p_template_comp_map_id)tcm ) )
join rfg.rfg_page p on(a.page_id = p.page_id)
where a.menu_id  in (select menu_id from unnest(v_menu_array) menu_id)
and b.is_active=1 and b.is_deleted=0
and a.is_active=1
and a.is_deleted=0
and p.is_active=1
and p.is_deleted=0

order by a.order_number
;

open p_page_ent_cur for 
     select *,rfg.rfg_get_entity_known_as(entity_role_map_id) known_as  
	 from rfg.rfg_asset_entity_map
     where asset_type_id = 11
     and asset_id in (p_parent_id);
   
   
   
 -- end if;  ---rakesh
 --  drop table v_temp_copmdata; --pppppp
 -- drop table v_menu_data;  ---ppp
--  **** --
else  -- added by purushottam on date 20170828, to handle the condition when page id not pass 
	
    open p_menu_cur for  
select * from rfg.rfg_menu
where 1 = 0 ;
    
open p_navigation_cur for      
select a.*, p.alias ,b.template_component_map_id 
from rfg.rfg_menu_page_map a
join rfg.rfg_page_template_component_menu_map b on b.menu_id=a.menu_id 
join rfg.rfg_page p on(a.page_id = p.page_id) 
where 1 = 0
;

open p_page_ent_cur for 
     select *,rfg.rfg_get_entity_known_as(entity_role_map_id) known_as 
     from rfg.rfg_asset_entity_map
     where 1 = 0;

 end if;
  --  first if close
   

end;
    

 
$_$;


--
