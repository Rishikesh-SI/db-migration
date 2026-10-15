-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_state_master state_master_id_pk
-- Type: CONSTRAINT

-- Name: stn_state_master state_master_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_state_master
    ADD CONSTRAINT state_master_id_pk PRIMARY KEY (state_id);


--
