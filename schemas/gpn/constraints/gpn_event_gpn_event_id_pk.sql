-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_event gpn_event_id_pk
-- Type: CONSTRAINT

-- Name: gpn_event gpn_event_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_event
    ADD CONSTRAINT gpn_event_id_pk PRIMARY KEY (event_id);


--
