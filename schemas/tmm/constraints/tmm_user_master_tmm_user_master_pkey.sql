-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_user_master tmm_user_master_pkey
-- Type: CONSTRAINT

-- Name: tmm_user_master tmm_user_master_pkey; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_user_master
    ADD CONSTRAINT tmm_user_master_pkey PRIMARY KEY (user_id);


--
