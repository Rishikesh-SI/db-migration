-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_entity_group labbr_entity_group_id
-- Type: CONSTRAINT

-- Name: labbr_entity_group labbr_entity_group_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_entity_group
    ADD CONSTRAINT labbr_entity_group_id PRIMARY KEY (entity_group_id);


--
