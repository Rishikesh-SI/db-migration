-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_site_partner tfa_site_partner_id
-- Type: CONSTRAINT

-- Name: tfa_site_partner tfa_site_partner_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_site_partner
    ADD CONSTRAINT tfa_site_partner_id PRIMARY KEY (site_partner_id);


--
