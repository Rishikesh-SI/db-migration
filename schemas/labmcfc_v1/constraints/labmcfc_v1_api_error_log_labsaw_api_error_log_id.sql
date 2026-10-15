-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labmcfc_v1_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labmcfc_v1; Owner: -
--

ALTER TABLE ONLY labmcfc_v1.labmcfc_v1_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
