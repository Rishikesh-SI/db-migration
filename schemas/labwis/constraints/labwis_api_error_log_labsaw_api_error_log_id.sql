-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labwis_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
