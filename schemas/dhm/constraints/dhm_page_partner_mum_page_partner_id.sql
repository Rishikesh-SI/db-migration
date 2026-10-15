-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_page_partner mum_page_partner_id
-- Type: CONSTRAINT

-- Name: dhm_page_partner mum_page_partner_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_page_partner
    ADD CONSTRAINT mum_page_partner_id PRIMARY KEY (page_partner_id);


--
