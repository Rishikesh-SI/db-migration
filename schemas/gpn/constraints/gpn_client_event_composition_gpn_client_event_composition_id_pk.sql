-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_client_event_composition gpn_client_event_composition_id_pk
-- Type: CONSTRAINT

-- Name: gpn_client_event_composition gpn_client_event_composition_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_client_event_composition
    ADD CONSTRAINT gpn_client_event_composition_id_pk PRIMARY KEY (client_event_composition_id);


--
