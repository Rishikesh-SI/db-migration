-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_entity_type labbr_entity_type_id
-- Type: CONSTRAINT

-- Name: labbr_entity_type labbr_entity_type_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_entity_type
    ADD CONSTRAINT labbr_entity_type_id PRIMARY KEY (entity_type_id);


--
