-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_bib_collection_slots labtcs_bib_collection_slots_pkey
-- Type: CONSTRAINT

-- Name: labtcs_bib_collection_slots labtcs_bib_collection_slots_pkey; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_bib_collection_slots
    ADD CONSTRAINT labtcs_bib_collection_slots_pkey PRIMARY KEY (bib_slot_id);


--
