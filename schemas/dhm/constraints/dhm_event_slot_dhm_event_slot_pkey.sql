-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_event_slot dhm_event_slot_pkey
-- Type: CONSTRAINT

-- Name: dhm_event_slot dhm_event_slot_pkey; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_event_slot
    ADD CONSTRAINT dhm_event_slot_pkey PRIMARY KEY (slot_id);


--
