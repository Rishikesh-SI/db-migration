-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_role_listing(text, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_role_listing(text, numeric, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_role_listing(p_schema text, p_status numeric, p_pagenumber numeric, p_itemnumber numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
v_fromrownumber numeric;
v_torownumber numeric;
begin

	    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    	v_torownumber   := (p_pagenumber * p_itemnumber);

execute 'with cte as (select 
cnt as row_cnt,
json_agg(row) as items
from 
(
select 
role_id,
role_name,
role_display_name,
role_desc,
rno,
cnt
from (
select count(1) over() as cnt,
role_id,
role_name,
role_display_name,
role_desc,
row_number() over (order by created_date desc) AS rno
from '||$1||'.'||$1||'_role
where is_active=$2 
and is_deleted=0
and is_super_admin=0
)tab
where rno between $3 and $4
)row
group by cnt
) select to_json(cte) 
from cte
'
into p_data 
using p_schema,p_status,v_fromrownumber,v_torownumber
;

end ;

$_$;


--
