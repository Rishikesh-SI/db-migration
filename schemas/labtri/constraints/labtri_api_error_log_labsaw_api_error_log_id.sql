-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labtri_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
