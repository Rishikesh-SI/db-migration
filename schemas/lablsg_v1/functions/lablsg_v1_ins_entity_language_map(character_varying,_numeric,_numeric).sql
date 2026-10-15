-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_ins_entity_language_map(character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: lablsg_v1_ins_entity_language_map(character varying, numeric, numeric); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_ins_entity_language_map(p_hindientitytext character varying, p_entitymasterid numeric, p_languagemasterid numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
begin
	
     if not exists(select 1 from lablsg_v1.lablsg_v1_entity_language_map where trim(entity_name) = trim(p_hindientitytext)) then
     	
          insert into lablsg_v1.lablsg_v1_entity_language_map
          values(nextval('lablsg_v1.seq_lablsg_v1_entity_language_map_id'), p_entitymasterid, p_languagemasterid, p_hindientitytext, p_hindientitytext, null, current_timestamp,
                 current_timestamp, 41, 41, 1, 0, 1, p_hindientitytext, p_hindientitytext);
          
          p_result := 1;
	
     else
     	
          p_result := 0;
          
     end if;

exception
	
     when others then
     	p_result := -1;
     
end;

 $$;


--
