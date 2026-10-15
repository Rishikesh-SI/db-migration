-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_ins_entity_language_map(character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labecn_ins_entity_language_map(character varying, numeric, numeric); Type: FUNCTION; Schema: labecn_ruf; Owner: -
--

CREATE FUNCTION labecn_ruf.labecn_ins_entity_language_map(p_hindientitytext character varying, p_entitymasterid numeric, p_languagemasterid numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
begin
	
     if not exists(select 1 from labecn.labecn_entity_language_map where trim(entity_name) = trim(p_hindientitytext)) then
     	
          insert into labecn.labecn_entity_language_map
          values(nextval('labecn.seq_labecn_entity_language_map_id'), p_entitymasterid, p_languagemasterid, p_hindientitytext, p_hindientitytext, null, current_timestamp,
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
