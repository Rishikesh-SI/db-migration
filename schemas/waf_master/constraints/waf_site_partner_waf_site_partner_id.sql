-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_site_partner waf_site_partner_id
-- Type: CONSTRAINT

-- Name: waf_site_partner waf_site_partner_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_site_partner
    ADD CONSTRAINT waf_site_partner_id PRIMARY KEY (site_partner_id);


--
