-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_state_master upstox_state_master_pkey
-- Type: CONSTRAINT

-- Name: upstox_state_master upstox_state_master_pkey; Type: CONSTRAINT; Schema: upstox; Owner: -
--

ALTER TABLE ONLY upstox.upstox_state_master
    ADD CONSTRAINT upstox_state_master_pkey PRIMARY KEY (state_name);


--
