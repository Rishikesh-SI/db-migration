-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_sales_force_payment_data(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_get_sales_force_payment_data(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_sales_force_payment_data(p_input_json jsonb, OUT p_user_data jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

/*{
  "start_date_time": "2019-04-08 20:00:00",
  "end_date_time": "2019-04-08 23:59:59",
  "page_number" : 1,
  "item_number" : 10
}*/

    v_start_date_time timestamp;
    v_end_date_time timestamp;
	v_user_data jsonb;
	v_fromrownumber numeric;
	v_torownumber numeric;
	v_pagenumber numeric;
    v_itemnumber numeric;
	
	
begin
   select p_input_json->>'start_date_time', 
   		  p_input_json->>'end_date_time',
		  p_input_json->>'page_number',
		  p_input_json->>'item_number'
    into v_start_date_time, 
		 v_end_date_time,
		 v_pagenumber,
		 v_itemnumber;
	
	
	v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
    v_torownumber   := (v_pagenumber * v_itemnumber);

	select count(1) over() as cnt,'{ "data" :'|| json_agg(raw)||'}'
		from
(select lid.invoice_detail_id as invoiceid,lop.payment_details,lid.transaction_id,lid.bill_no,
lid.total_amount,lid.taxable_amount,lid.tax_rate, 
		case when coalesce(lid.is_state,0)=1 then lja.igst else null end as igst,
		case when coalesce(lid.is_state,0)=0 then lja.cgst else null end as cgst,
		case when coalesce(lid.is_state,0)=0 then lja.sgst else null end as sgst,
		 lid.sac_code,lid.created_date,lid.invoice_detail_id,
			case when coalesce(lid.is_state,0)=1 then lja.igst_amount else null end as igst_amount,
		case when coalesce(lid.is_state,0)=0 then lja.cgst_amount else null end as cgst_amount,
		case when coalesce(lid.is_state,0)=0 then lja.sgst_amount else null end as sgst_amount
		,row_number() over(order by lop.created_date  desc) slno
from labbsc_dev.labbsc_dev_invoice_detail lid
inner join labbsc_dev.labbsc_dev_order_payment lop
on  lop.transaction_id=lid.transaction_id
left join labbsc_dev.labbsc_dev_journey_activity  lja
			on lja.product_display_name=lid.service_type
	--		and lid.activity_id=lja.activity_id
 where (lop.created_date + '5.5 hours'::interval)::date between v_start_date_time::date and v_end_date_time::date and lid.transaction_status='Success')raw
where slno between v_fromrownumber and v_torownumber 
	into p_count,v_user_data 	 ;
  
   
    p_user_data := v_user_data;
   
   -- raise notice '%' , p_user_data;

	end;
$$;


--
