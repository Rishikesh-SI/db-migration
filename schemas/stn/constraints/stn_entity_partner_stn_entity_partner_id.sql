-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_entity_partner stn_entity_partner_id
-- Type: CONSTRAINT

-- Name: stn_entity_partner stn_entity_partner_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_entity_partner
    ADD CONSTRAINT stn_entity_partner_id PRIMARY KEY (entity_partner_id);


--
