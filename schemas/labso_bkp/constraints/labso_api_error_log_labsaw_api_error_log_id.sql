-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labso_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labso_bkp; Owner: -
--

ALTER TABLE ONLY labso_bkp.labso_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
