-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_page_partner waf_page_partner_id
-- Type: CONSTRAINT

-- Name: waf_page_partner waf_page_partner_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_page_partner
    ADD CONSTRAINT waf_page_partner_id PRIMARY KEY (page_partner_id);


--
