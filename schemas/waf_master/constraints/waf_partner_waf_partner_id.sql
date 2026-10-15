-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_partner waf_partner_id
-- Type: CONSTRAINT

-- Name: waf_partner waf_partner_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_partner
    ADD CONSTRAINT waf_partner_id PRIMARY KEY (partner_id);


--
