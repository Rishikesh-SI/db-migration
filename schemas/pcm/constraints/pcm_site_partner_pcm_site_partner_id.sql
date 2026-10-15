-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_site_partner pcm_site_partner_id
-- Type: CONSTRAINT

-- Name: pcm_site_partner pcm_site_partner_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_site_partner
    ADD CONSTRAINT pcm_site_partner_id PRIMARY KEY (site_partner_id);


--
