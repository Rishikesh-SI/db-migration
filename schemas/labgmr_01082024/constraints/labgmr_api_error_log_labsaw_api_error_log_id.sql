-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labgmr_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labgmr_01082024; Owner: -
--

ALTER TABLE ONLY labgmr_01082024.labgmr_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
