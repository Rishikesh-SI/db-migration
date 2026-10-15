-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_contact_page_master waf_contact_page_id
-- Type: CONSTRAINT

-- Name: waf_contact_page_master waf_contact_page_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_contact_page_master
    ADD CONSTRAINT waf_contact_page_id PRIMARY KEY (contact_page_id);


--
