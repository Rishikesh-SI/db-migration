-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_entity_partner mum_entity_partner_id
-- Type: CONSTRAINT

-- Name: dhm_entity_partner mum_entity_partner_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_entity_partner
    ADD CONSTRAINT mum_entity_partner_id PRIMARY KEY (entity_partner_id);


--
