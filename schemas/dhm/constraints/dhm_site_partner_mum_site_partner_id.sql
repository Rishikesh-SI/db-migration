-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_site_partner mum_site_partner_id
-- Type: CONSTRAINT

-- Name: dhm_site_partner mum_site_partner_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_site_partner
    ADD CONSTRAINT mum_site_partner_id PRIMARY KEY (site_partner_id);


--
