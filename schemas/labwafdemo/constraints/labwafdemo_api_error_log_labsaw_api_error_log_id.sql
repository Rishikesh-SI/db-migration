-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwafdemo
-- Object: labwafdemo_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labwafdemo_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labwafdemo; Owner: -
--

ALTER TABLE ONLY labwafdemo.labwafdemo_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
