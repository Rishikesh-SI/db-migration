-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_api_error_log labwf_api_error_log_pkey
-- Type: CONSTRAINT

-- Name: labwf_api_error_log labwf_api_error_log_pkey; Type: CONSTRAINT; Schema: fanxp_wf; Owner: -
--

ALTER TABLE ONLY fanxp_wf.labwf_api_error_log
    ADD CONSTRAINT labwf_api_error_log_pkey PRIMARY KEY (api_error_log_id);


--
