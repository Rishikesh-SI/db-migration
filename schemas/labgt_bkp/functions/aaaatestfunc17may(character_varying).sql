-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: aaaatestfunc17may(character varying)
-- Type: FUNCTION

-- Name: aaaatestfunc17may(character varying); Type: FUNCTION; Schema: labgt_bkp; Owner: -
--

CREATE FUNCTION labgt_bkp.aaaatestfunc17may(p_schema_prefix character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE
v_role_id numeric := 1;
--p_schema_prefix character varying := 'labecn_v1';
p_data json;
jd numeric;

begin

execute 'SELECT (1) FROM information_schema.tables 
    		  WHERE table_schema = $1 AND 
              table_name = $1||''_user_role_menu_action_map2''' into jd using p_schema_prefix;
			  		  
raise notice '%',jd;

if jd = 1 then

execute 'select row_to_json(r,true) 
from (
select 
json_agg(tab) as menu,
r.role_id,
r.role_name,
r.role_desc,
r.created_by
from (
SELECT
d.user_menu_id as menu_id,   
d.menu_name as title,
d.css_class as CSSclass,
d.redirect_url as link,	
d.menu_level,
d.menu_ord,
d.is_visible,	
coalesce(d.parent_id,0) as parent_id,    
dc.role_id,
jsonb_agg(tab) AS actions
FROM siwaf.siwaf_user_menu d
INNER JOIN '||p_schema_prefix||'.'||p_schema_prefix||'_user_role_menu_action_map2 dc 
           ON (dc.user_menu_id = d.user_menu_id ) 
		   and (dc.user_action_id is null)

    left join (select user_action_id as action_id,action_name ,
			    cm.role_menu_action_id ,cm.is_active,ma.status_flg
                ,cm.user_menu_id,ordring as order_by
					from siwaf.siwaf_menu_action ma
        INNER JOIN '||p_schema_prefix||'.'||p_schema_prefix||'_user_role_menu_action_map2  cm 
		ON  (ma.menu_action_id = cm.user_action_id ) 
		  where cm.is_active=1
			and cm.role_id=$1) tab 
		on tab.user_menu_id=dc.user_menu_id
     where dc.role_id=$1
	 and dc.is_active=1
	 and d.module_flag=1
	 group by d.user_menu_id,   
      d.menu_name,d.parent_id,dc.role_id,d.css_class,
d.redirect_url,d.menu_level,menu_ord,d.is_visible
order by d.menu_level,menu_ord 	 asc
)tab 
join '||p_schema_prefix||'.'||p_schema_prefix||'_role r on r.role_id=tab.role_id
group by 
r.role_id,
r.role_name,
r.role_desc,
r.created_by
	)r' into  p_data
	using v_role_id;

raise notice '%',p_data;
end if;

return 1;

end;
$_$;


--
