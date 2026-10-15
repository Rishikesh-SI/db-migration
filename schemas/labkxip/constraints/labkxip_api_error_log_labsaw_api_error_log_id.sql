-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labkxip_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
