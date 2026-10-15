-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_membership_mail_data()
-- Type: FUNCTION

-- Name: labmi_membership_mail_data(); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_membership_mail_data(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE
	v_json jsonb;
	v_new_user_data jsonb;
	v_verified_blue_memberships numeric;
	v_total_blue_memberships numeric;
	v_verified_blue_memberships_previos numeric;
	v_total_blue_memberships_previos numeric;
	v_overall_verified_blue_memberships numeric;
	v_overall_blue_memberships numeric;
	v_total_membershp jsonb;
BEGIN

	-- MI Membership Live date changes 2024-02-23 19:30:00 on 26-02-2024
	TRUNCATE TABLE labmi.labmi_membership_data_temp;

	INSERT INTO labmi.labmi_membership_data_temp
	SELECT  
		CASE COALESCE(old_campaign_id,1)
			WHEN 1 THEN 'Blue'
			WHEN 3 THEN 'Silver'
			WHEN 4 THEN 'Gold'
			WHEN 5 THEN 'Junior'
		END AS old,
		CASE LEFT(p.invoice_id,3)
			WHEN 'GTM' THEN 'Gold'
			WHEN 'STM' THEN 'Silver'
			WHEN 'JTM' THEN 'Junior'
		END AS new,
		wu.created_date AS user_created_date,
		p.created_date AS membership_created_date,
		COALESCE(old_campaign_id,1) AS old_no,
		CASE LEFT(p.invoice_id,3)
			WHEN 'GTM' THEN 4
			WHEN 'STM' THEN 3
			WHEN 'JTM' THEN 5
		END AS new_no
	FROM labmi.labmi_web_user wu
	LEFT JOIN labmi.labmi_product_cart_paydetails p 
		ON wu.user_guid = p.user_guid
	WHERE p.order_status = 'SUCCESS';

	-- OLD USER DATA
	SELECT ('{ "old_user" : ' || json_agg(row_to_json(row)) || '}')::jsonb
	INTO v_json
	FROM (
		(
			SELECT type, total_membership_till_day, last_day,
				   (total_membership_till_day - last_day) AS total_membership
			FROM (
				SELECT type,
					   SUM(total_membership) AS total_membership_till_day,
					   SUM(last_day) AS last_day
				FROM (
					SELECT old || '_' || new AS type,
						   COUNT(1) AS total_membership,
						   0 AS last_day
					FROM labmi.labmi_membership_data_temp
					WHERE user_created_date < ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
					GROUP BY 1,3

					UNION ALL

					SELECT old || '_' || new,
						   0 AS total_membership,
						   COUNT(1) AS last_day
					FROM labmi.labmi_membership_data_temp
					WHERE user_created_date < ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
					  AND membership_created_date BETWEEN
					      (current_timestamp AT TIME ZONE 'utc') - '1 day'::interval
					      AND current_timestamp AT TIME ZONE 'utc'
					GROUP BY 1,2
				) a
				GROUP BY 1
			) b
		)
		UNION ALL
		-- NOT PURCHASED MEMBERSHIP DATA
		SELECT 
			((CASE old_no
				WHEN 1 THEN 'Blue'
				WHEN 3 THEN 'Silver'
				WHEN 4 THEN 'Gold'
				WHEN 5 THEN 'Junior'
			  END) || '_' ||
			 (CASE new_no
				WHEN 3 THEN 'Silver'
				WHEN 4 THEN 'Gold'
				WHEN 5 THEN 'Junior'
			  END)) AS type,
			0, 0, 0
		FROM (
			SELECT from_product_id AS old_no, to_product_id AS new_no
			FROM labmi.labmi_membership_product_data_temp
			EXCEPT
			SELECT old_no, new_no
			FROM labmi.labmi_membership_data_temp
			WHERE user_created_date < ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
			GROUP BY old_no, new_no
		) a
	) row;

	-- NEW USER DATA
	SELECT json_agg(row_to_json(row))::jsonb
	INTO v_new_user_data
	FROM (
		(
			SELECT type, total_membership_till_day, last_day,
				   (total_membership_till_day - last_day) AS total_membership
			FROM (
				SELECT type,
					   SUM(total_membership) AS total_membership_till_day,
					   SUM(last_day) AS last_day
				FROM (
					SELECT old || '_' || new AS type,
						   COUNT(1) AS total_membership,
						   0 AS last_day
					FROM labmi.labmi_membership_data_temp
					WHERE user_created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
					GROUP BY 1,3

					UNION ALL

					SELECT old || '_' || new,
						   0 AS total_membership,
						   COUNT(1) AS last_day
					FROM labmi.labmi_membership_data_temp
					WHERE user_created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
					  AND membership_created_date BETWEEN
					      (current_timestamp AT TIME ZONE 'utc') - '1 day'::interval
					      AND current_timestamp AT TIME ZONE 'utc'
					GROUP BY 1,2
				) a
				GROUP BY 1
			) b
		)
		UNION ALL
		SELECT 
			('Blue_' ||
			 CASE new_no
				WHEN 3 THEN 'Silver'
				WHEN 4 THEN 'Gold'
				WHEN 5 THEN 'Junior'
			 END),
			0, 0, 0
		FROM (
			SELECT from_product_id AS old_no, to_product_id AS new_no
			FROM labmi.labmi_membership_product_data_temp
			WHERE from_product_id = 1
			EXCEPT
			SELECT old_no, new_no
			FROM labmi.labmi_membership_data_temp
			WHERE user_created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
			GROUP BY old_no, new_no
		) a
	) row;

	-- ✅ TOTAL MEMBERSHIP (FIXED)
	SELECT json_agg(row_to_json(row))::jsonb
	INTO v_total_membershp
	FROM (
		(
			SELECT type,
				   total_membership_till_day,
				   last_day,
				   (total_membership_till_day - last_day) AS total_membership
			FROM (
				SELECT type,
					   SUM(total_membership) AS total_membership_till_day,
					   SUM(last_day) AS last_day
				FROM (
					SELECT new AS type, COUNT(1) AS total_membership, 0 AS last_day
					FROM labmi.labmi_membership_data_temp
					GROUP BY 1,3

					UNION ALL

					SELECT new, 0 AS total_membership, COUNT(1) AS last_day
					FROM labmi.labmi_membership_data_temp
					WHERE membership_created_date BETWEEN
					      (current_timestamp AT TIME ZONE 'utc') - '1 day'::interval
					      AND current_timestamp AT TIME ZONE 'utc'
					GROUP BY 1,2
				) a
				GROUP BY 1
			) b
		)

		UNION ALL
		-- ADD MISSING MEMBERSHIP TYPES WITH ZERO VALUES
		SELECT m.type, 0, 0, 0
		FROM (VALUES ('Gold'), ('Silver'), ('Junior')) m(type)
		WHERE NOT EXISTS (
			SELECT 1
			FROM labmi.labmi_membership_data_temp t
			WHERE t.new = m.type
		)
	) row;

	-- COUNTS
	SELECT COUNT(1) INTO v_verified_blue_memberships
	FROM labmi.labmi_web_user
	WHERE is_verified = 1
	  AND client_id = 5
	  AND campaign_id = 1
	  AND created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval);

	SELECT COUNT(1) INTO v_total_blue_memberships
	FROM labmi.labmi_web_user
	WHERE campaign_id = 1
	  AND client_id = 5
	  AND created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval);

	SELECT COUNT(1) INTO v_verified_blue_memberships_previos
	FROM labmi.labmi_web_user
	WHERE is_verified = 1
	  AND client_id = 5
	  AND campaign_id = 1
	  AND created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
	  AND created_date BETWEEN
	      (current_timestamp AT TIME ZONE 'utc') - '1 day'::interval
	      AND current_timestamp AT TIME ZONE 'utc';

	SELECT COUNT(1) INTO v_total_blue_memberships_previos
	FROM labmi.labmi_web_user
	WHERE campaign_id = 1
	  AND client_id = 5
	  AND created_date > ('2025-01-15 00:00:00'::timestamp - '5.5 hours'::interval)
	  AND created_date BETWEEN
	      (current_timestamp AT TIME ZONE 'utc') - '1 day'::interval
	      AND current_timestamp AT TIME ZONE 'utc';

	SELECT COUNT(1) INTO v_overall_verified_blue_memberships
	FROM labmi.labmi_web_user
	WHERE is_verified = 1
	  AND campaign_id = 1
	  AND client_id = 5;

	SELECT COUNT(1) INTO v_overall_blue_memberships
	FROM labmi.labmi_web_user
	WHERE campaign_id = 1
	  AND client_id = 5;

	-- FINAL JSON
	v_json := jsonb_set(v_json, '{new_user_total}', v_new_user_data, true);
	v_json := jsonb_set(v_json, '{total_membershp}', v_total_membershp, true);
	v_json := jsonb_set(v_json, '{verified_blue_memberships}', v_verified_blue_memberships::text::jsonb, true);
	v_json := jsonb_set(v_json, '{total_blue_memberships}', v_total_blue_memberships::text::jsonb, true);
	v_json := jsonb_set(v_json, '{verified_blue_memberships_previous}', v_verified_blue_memberships_previos::text::jsonb, true);
	v_json := jsonb_set(v_json, '{total_blue_memberships_previous}', v_total_blue_memberships_previos::text::jsonb, true);
	v_json := jsonb_set(v_json, '{overall_verified_blue_memberships}', v_overall_verified_blue_memberships::text::jsonb, true);
	v_json := jsonb_set(v_json, '{overall_blue_memberships}', v_overall_blue_memberships::text::jsonb, true);

	p_user_data := v_json;

END;
$$;


--
