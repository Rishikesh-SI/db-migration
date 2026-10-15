-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_client_activitytoken siwaf_client_activitytoken_pkey
-- Type: CONSTRAINT

-- Name: siwaf_client_activitytoken siwaf_client_activitytoken_pkey; Type: CONSTRAINT; Schema: siwaf; Owner: -
--

ALTER TABLE ONLY siwaf.siwaf_client_activitytoken
    ADD CONSTRAINT siwaf_client_activitytoken_pkey PRIMARY KEY (client_atid);


--
