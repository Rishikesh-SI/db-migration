-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_settlement_data(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_settlement_data(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_settlement_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_json_data jsonb;
v_pay_id numeric;
v_type character varying;
v_sd_id numeric;
v_transaction_ref_no numeric;
begin

for v_json_data in select * from jsonb_array_elements(p_json)
      loop
        select v_json_data->>'pay_id',
       v_json_data->>'type',
	   v_json_data->>'ccavenue_ref_no'
	   into
	   v_pay_id,
	   v_type,
	   v_transaction_ref_no;

v_sd_id :=nextval('labbsc_dev.seq_labbsc_dev_sd_id');

insert into labbsc_dev.labbsc_dev_settlement_data(sd_id,pay_id,pay_id_txn_details,type,created_date,updated_date,transaction_ref_no)
select v_sd_id,v_pay_id,v_json_data,v_type,current_timestamp at time zone 'utc',current_timestamp at time zone 'utc',v_transaction_ref_no::text;

end loop;

p_result :=1;
end;
$$;


--
