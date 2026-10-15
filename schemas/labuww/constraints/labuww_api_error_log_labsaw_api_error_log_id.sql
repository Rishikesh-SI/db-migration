-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labuww_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labuww; Owner: -
--

ALTER TABLE ONLY labuww.labuww_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
