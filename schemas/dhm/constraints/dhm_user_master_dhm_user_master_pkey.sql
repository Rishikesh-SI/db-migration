-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_user_master dhm_user_master_pkey
-- Type: CONSTRAINT

-- Name: dhm_user_master dhm_user_master_pkey; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_user_master
    ADD CONSTRAINT dhm_user_master_pkey PRIMARY KEY (user_id);


--
