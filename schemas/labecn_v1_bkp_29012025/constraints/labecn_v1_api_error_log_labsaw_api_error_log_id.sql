-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labecn_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labecn_v1_bkp_29012025; Owner: -
--

ALTER TABLE ONLY labecn_v1_bkp_29012025.labecn_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
