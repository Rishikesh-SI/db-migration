-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_state_master labrao_state_master_pkey
-- Type: CONSTRAINT

-- Name: labrao_state_master labrao_state_master_pkey; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_state_master
    ADD CONSTRAINT labrao_state_master_pkey PRIMARY KEY (state_name);


--
