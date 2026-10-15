-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_state_master upstox_state_master_pkey
-- Type: CONSTRAINT

-- Name: labupstox_state_master upstox_state_master_pkey; Type: CONSTRAINT; Schema: labupstox; Owner: -
--

ALTER TABLE ONLY labupstox.labupstox_state_master
    ADD CONSTRAINT upstox_state_master_pkey PRIMARY KEY (state_name);


--
