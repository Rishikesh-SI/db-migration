-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ins_ttgl_entity_role(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: ins_ttgl_entity_role(numeric, numeric, numeric); Type: FUNCTION; Schema: ttgl; Owner: -
--

CREATE FUNCTION ttgl.ins_ttgl_entity_role(p_type_id numeric, p_group_id numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$   

declare
v_current_timestamp timestamp;
v_entity_role_id numeric;
begin
v_current_timestamp:= current_timestamp at time zone 'utc';
v_entity_role_id := nextval('ttgl.seq_ttgl_entity_role_id');
insert into ttgl.ttgl_entity_role
(
entity_role_id,
entity_type_id,
entity_group_id,
created_date,
updated_date,
created_by,
updated_by,
is_active,
is_deleted
)
Values 
(
v_entity_role_id,
p_type_id,
p_group_id,
v_current_timestamp,
v_current_timestamp,
p_updated_by,
p_updated_by,
1,
0
)
;
p_result :=1;

end ;

   $$;


--
