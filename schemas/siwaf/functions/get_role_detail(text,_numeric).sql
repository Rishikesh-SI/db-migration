-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_role_detail(text, numeric)
-- Type: FUNCTION

-- Name: _get_role_detail(text, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_role_detail(p_schema text, p_role_id numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare

begin
/*
select ('{"data":'||row_to_json(r,true)||'}') into p_data
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
d.menu_name,
dc.role_id,
jsonb_agg(c_row) AS sub_menus
FROM lb_dev.lb_dev_user_menu d
INNER JOIN lb_dev.lb_dev_user_role_menu_action_map2 dc 
           ON (dc.user_menu_id = d.user_menu_id ) 
		   and (dc.user_action_id is null)
inner join (SELECT c.parent_id,cm.role_id,
            c.user_menu_id as sub_menu_id ,       
            c.menu_name as sub_menu_name  , 
           json_agg(tab) AS actions
        FROM lb_dev.lb_dev_user_menu c
        INNER JOIN lb_dev.lb_dev_user_role_menu_action_map2  cm 
		ON  (cm.user_menu_id = c.user_menu_id )  and (cm.user_action_id is not null)
        inner join (select user_action_id as action_id,action_name ,cm.role_menu_action_id ,cm.is_active
					from lb_dev.lb_dev_menu_action d
        INNER JOIN lb_dev.lb_dev_user_role_menu_action_map2  cm 
		ON  (d.menu_action_id = cm.user_action_id ) ) tab 
		on tab.role_menu_action_id=cm.role_menu_action_id	
       GROUP BY c.user_menu_id ,c.menu_name,c.parent_id,cm.role_id) c_row 
	 on c_row.parent_id=dc.user_menu_id and dc.role_id=c_row.role_id
     where dc.role_id=p_role_id
	 group by d.user_menu_id,   
      d.menu_name,dc.role_id
)tab 
join lb_dev.lb_dev_role r on r.role_id=tab.role_id
group by r.role_id,
r.role_name,
r.role_desc,
r.created_by
	)r
;
*/

execute 'select role_json  
from '||p_schema||'.'||p_schema||'_role
where role_id=$2'
into p_data
using p_schema,p_role_id;
p_result:=1;
exception when others
          then p_data := ('{"menu":[]}')::jsonb;
end ;

$_$;


--
