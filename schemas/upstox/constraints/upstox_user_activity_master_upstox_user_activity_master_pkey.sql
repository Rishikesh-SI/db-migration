-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_user_activity_master upstox_user_activity_master_pkey
-- Type: CONSTRAINT

-- Name: upstox_user_activity_master upstox_user_activity_master_pkey; Type: CONSTRAINT; Schema: upstox; Owner: -
--

ALTER TABLE ONLY upstox.upstox_user_activity_master
    ADD CONSTRAINT upstox_user_activity_master_pkey PRIMARY KEY (user_activity_id);


--
