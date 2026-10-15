-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: tsk_get_navigation_r(numeric, numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_get_navigation_r(p_parent_id numeric, p_template_comp_map_id numeric[], p_entity character varying, p_menu_cur refcursor, p_navigation_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

 
 declare
	     --   i record ;
	       -- p_parent_id numeric :=222;
	      --  p_template_comp_map_id numeric[] :=array[3512];
	       -- p_entity character varying := '4';
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
			
			v_template_id numeric;
			v_fetch_from numeric;
			v_tcentity numeric[];
			v_page_ent numeric[] ;
			v_tcpageenti numeric[] ;
			v_menu_id numeric ;
			v_menuentity numeric[];
			
			
			
			
			v_template_component_map_id numeric;
			
			
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
            v_lang_filter_query varchar(1000) := ' ';
            v_menu_array numeric[];
            
            v_lang_id numeric;
            v_page_entity varchar;
            
       
         v_array numeric[] ;
         v_array1 numeric[] ;
		 v_array2  numeric[];
         v_result varchar ;-- boolean ;
         v_menu_array1 numeric[];
         v_page_tc_array numeric[];
         v_menu_array2   numeric[];
         
         v_page_tc_array1 numeric[];
         v_lang_page varchar[];
         
         vcount numeric;
         
         v_userjsonarr jsonb ;
         
         v_temp numeric;
         v_menu_id1 numeric;
         
         v_query varchar(200);
		
		 v_widget_array numeric[];
		
		 v_menu_id_finel numeric;
		 v_widget_id_finel numeric;
		
    begin
    
         if p_parent_id=0 then 
                 v_query:='template_component_map_id in ( select tcmap_id from unnest($1) tcmap_id)';	  	 
         else 
	             v_query:=' page_id='||p_parent_id;
         end if ;
   
   if    p_parent_id=0 then 
   execute 'select template_id 
           from tsk.tsk_template_component_map 
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
  
 from tsk.tsk_template
 where '||v_query
 -- parent_id=p_parent_id -- 
 -- page_id = p_parent_id
--  limit 1
 
into   v_template_id
 using p_template_comp_map_id
 ;
 
 
 
 with recursive whosYourDaddy as (
  --start with the "anchor" row
  select
    *
  from tsk.tsk_template
  where
    template_id = v_template_id --parameterize me

  union all

  select
    a.*
  from tsk.tsk_template a
  join whosYourDaddy on whosYourDaddy.parent_id = a.template_id
)

select
  parent_id into v_template_id
from whosYourDaddy 
where parent_id is not null
order by
  template_id
  ;
 end if;

  raise notice '% firts check template id ' ,v_template_id;
 if v_template_id is not null then 
     
	  execute '            select 
                               template_component_map_id,
                               template_id,
                               fetch_from , 
                               tcentity ,
                               page_ent,
                               (case when fetch_from=1 
	                           then array_cat((case when tcentity =''{null}'' then null else tcentity end),page_ent::numeric[] ) 
	                           else tcentity end ) as tcpageenti,
                               menu_id,
                               case when array_length(menuentity,1)=1 then ''{null}'' else menuentity end as menuentity
                               from (
                                select 
								a.template_component_map_id,
								a.template_id,
								fetch_from ,
								array_agg(distinct b.entity_role_map_id::numeric) as tcentity,
								(  select array_agg(entity_role_map_id::text) 
 								 from tsk.tsk_asset_entity_map
 								 where asset_id= '|| p_parent_id::varchar || '
  								and asset_type_id=11)as page_ent,
								c.menu_id,
								array_agg(distinct d.entity_role_map_id::numeric) as menuentity
								from tsk.tsk_template_component_map a
								inner join tsk.tsk_template t 
								on (a.template_id = t.template_id)
                                left join tsk.tsk_asset_entity_map b on b.asset_id=a.template_component_map_id  and b.asset_type_id=13   
                                left join tsk.tsk_page_template_component_menu_map c 
                                on (c.template_component_map_id=a.template_component_map_id and c.is_active=1
	                            and c.is_deleted=0 )
                                left join tsk.tsk_asset_entity_map d on d.asset_id=c.menu_id and d.asset_type_id=22
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
                                '
              into  v_template_component_map_id,
			        v_template_id,
					v_fetch_from,
					v_tcentity,
					v_page_ent,
					v_tcpageenti,
					v_menu_id,
					v_menuentity
              using p_template_comp_map_id;
	
	  
	    raise notice '% find menu_id',v_menu_id;
	    raise notice '% Fetch From ',v_fetch_from;
		raise notice '% Menu Entity',v_menuentity;
		raise notice '% tc  Entity',v_tcentity;		
	

   
      SELECT ARRAY(SELECT DISTINCT UNNEST(v_tcpageenti) ORDER BY 1) into v_tcpageenti;
	  raise notice '% tcpage  Entity',v_tcpageenti;
	  
	
	 if (v_tcentity !='{NULL}' or v_tcentity !='{null}') and (v_menuentity is not null or  v_menuentity !='{NULL}')   then 	 
	   
	    select sort(v_menuentity::int[], 'asc') into v_menuentity;
		select sort(v_tcentity::int[], 'asc') into v_tcentity;
	  end if;
	
        if p_parent_id =0  then 
		    if v_fetch_from=0 then 
		    
			     v_menu_id_finel :=v_menu_id;
		    
		    else 
		      
			select v_menuentity=v_tcentity into v_result;
		 
		     raise notice '% Match Result ',v_result;
		      if v_result='true' then 
							     v_menu_id_finel := v_menu_id ;	
			else 
								 v_menu_id_finel := null ;						 
			end if ;

		     
           end if ;

          else 
		   -- page navigation code start 
		
		   if v_fetch_from=1 then 
		
		      select v_menuentity=v_tcpageenti into v_result;
			  raise notice '% Match Result1 ',v_result;
			
			     
				 if v_result='true' then 
							     v_menu_id_finel := v_menu_id ;	
			      else 
								 v_menu_id_finel := null ;						 
			      end if ;

			
		    else 
			 
			   select v_menuentity=v_tcentity into v_result;
			   raise notice '% Match Result2 ',v_result;
			
			      if v_result='true' then 
							     v_menu_id_finel := v_menu_id ;	
			      else 
								 v_menu_id_finel := null ;						 
			      end if ;

			  
		    end if ;
        end if; 
		
		
		
 select array(select v_menu_id_finel) into v_menu_array ;
  
 raise notice '% find final menu id ',v_menu_array;		
		
		
		
open p_menu_cur for  
select * from tsk.tsk_menu
where menu_id in (select menu_id from unnest(v_menu_array) menu_id)
and is_active=1
and is_deleted=0
and is_published=1;
    
open p_navigation_cur for      
select a.*, p.alias ,b.template_component_map_id 
from tsk.tsk_menu_page_map a
join tsk.tsk_page_template_component_menu_map b 
on (b.menu_id=a.menu_id and b.template_component_map_id in (select * from unnest(p_template_comp_map_id)tcm ) )
join tsk.tsk_page p on(a.page_id = p.page_id)
where a.menu_id  in (select menu_id from unnest(v_menu_array) menu_id)
and b.is_active=1 and b.is_deleted=0
and a.is_active=1
and a.is_deleted=0
and p.is_active=1
and p.is_deleted=0

order by a.order_number
;

open p_page_ent_cur for 
     select *,tsk.tsk_get_entity_known_as(entity_role_map_id) known_as  
	 from tsk.tsk_asset_entity_map
     where asset_type_id = 11
     and asset_id in (p_parent_id);
   
   
   
 -- end if;  ---rakesh
 --  drop table v_temp_copmdata; --pppppp
 -- drop table v_menu_data;  ---ppp
--  **** --
else  -- added by purushottam on date 20170828, to handle the condition when page id not pass 
	
    open p_menu_cur for  
select * from tsk.tsk_menu
where 1 = 0 ;
    
open p_navigation_cur for      
select a.*, p.alias ,b.template_component_map_id 
from tsk.tsk_menu_page_map a
join tsk.tsk_page_template_component_menu_map b on b.menu_id=a.menu_id 
join tsk.tsk_page p on(a.page_id = p.page_id) 
where 1 = 0
;

open p_page_ent_cur for 
     select *,tsk.tsk_get_entity_known_as(entity_role_map_id) known_as 
     from tsk.tsk_asset_entity_map
     where 1 = 0;

 end if;
 
 
 
 
end;

$_$;


--
