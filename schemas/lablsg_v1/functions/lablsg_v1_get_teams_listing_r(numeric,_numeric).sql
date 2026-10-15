-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_teams_listing_r(numeric, numeric)
-- Type: FUNCTION

-- Name: lablsg_v1_get_teams_listing_r(numeric, numeric); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_teams_listing_r(p_pagenumber numeric, p_itemnumber numeric, OUT p_teamcount numeric, OUT p_teamjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	-- Effective pagination inputs
	v_page numeric := greatest(coalesce(p_pagenumber, 1), 1);
	v_limit numeric := coalesce(p_itemnumber, 20);
	v_offset numeric := (v_page - 1) * v_limit;

	v_total_pages numeric;
	v_pagination jsonb;
begin
	-- Count total active clients
	select count(1)
	into p_teamcount
	from waf_master.waf_client c
	where c.is_active = 1;

	-- Page data
	execute '
		select jsonb_build_object(
			''items'', coalesce(json_agg(row_to_json(tab)), null)
		)
		from (
			select 
				client_id,
				client_name,
				client_display_name,
				client_code,
				--client_json,
				domain_url,
				created_date
			from waf_master.waf_client c
			where c.is_active = 1
			order by c.created_date desc, c.client_id desc
			limit $1
			offset $2
		) tab
	'
	into p_teamjson
	using v_limit::int, v_offset::int;

	if p_teamjson is null then
		p_teamjson := '{"items":null}'::jsonb;
	end if;

	-- Compute total pages based on page_size = v_limit
	if coalesce(p_teamcount, 0) = 0 then
		v_total_pages := 0;
	else
		v_total_pages := ceil(p_teamcount / nullif(v_limit, 0));
	end if;

	-- Pagination node (keep only these keys)
	v_pagination := jsonb_build_object(
		'page',        coalesce(p_pagenumber, 1),
		'page_size',   coalesce(v_limit, 20),
		'total',       coalesce(p_teamcount, 0),
		'total_pages', v_total_pages
	);

	p_teamjson := jsonb_set(p_teamjson, '{pagination}', v_pagination, true);

exception
	when others then
		p_teamcount := -1;
		p_teamjson := '{"items":[{"error":"no record"}]}'::jsonb;
end;
$_$;


--
