-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_log ss_log_pkey
-- Type: CONSTRAINT

-- Name: ss_log ss_log_pkey; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_log
    ADD CONSTRAINT ss_log_pkey PRIMARY KEY (cf_logid);


--
