-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labdv_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
