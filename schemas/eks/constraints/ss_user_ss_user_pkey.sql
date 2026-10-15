-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user ss_user_pkey
-- Type: CONSTRAINT

-- Name: ss_user ss_user_pkey; Type: CONSTRAINT; Schema: eks; Owner: -
--

ALTER TABLE ONLY eks.ss_user
    ADD CONSTRAINT ss_user_pkey PRIMARY KEY (cf_userid);


--
