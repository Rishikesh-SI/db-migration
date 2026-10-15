-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labgt_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.labgt_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
