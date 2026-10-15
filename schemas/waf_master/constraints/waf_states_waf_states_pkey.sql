-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_states waf_states_pkey
-- Type: CONSTRAINT

-- Name: waf_states waf_states_pkey; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_states
    ADD CONSTRAINT waf_states_pkey PRIMARY KEY (state_id);


--
