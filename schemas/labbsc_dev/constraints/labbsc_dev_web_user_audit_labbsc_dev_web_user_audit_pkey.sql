-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_web_user_audit labbsc_dev_web_user_audit_pkey
-- Type: CONSTRAINT

-- Name: labbsc_dev_web_user_audit labbsc_dev_web_user_audit_pkey; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_web_user_audit
    ADD CONSTRAINT labbsc_dev_web_user_audit_pkey PRIMARY KEY (audit_id);


--
