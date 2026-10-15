-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_entity_partner hsl_entity_partner_id
-- Type: CONSTRAINT

-- Name: hsl_entity_partner hsl_entity_partner_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_entity_partner
    ADD CONSTRAINT hsl_entity_partner_id PRIMARY KEY (entity_partner_id);


--
