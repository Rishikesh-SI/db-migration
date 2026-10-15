-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_entity_partner pcm_entity_partner_id
-- Type: CONSTRAINT

-- Name: pcm_entity_partner pcm_entity_partner_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_entity_partner
    ADD CONSTRAINT pcm_entity_partner_id PRIMARY KEY (entity_partner_id);


--
