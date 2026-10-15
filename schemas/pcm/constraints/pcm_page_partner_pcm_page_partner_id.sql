-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_page_partner pcm_page_partner_id
-- Type: CONSTRAINT

-- Name: pcm_page_partner pcm_page_partner_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_page_partner
    ADD CONSTRAINT pcm_page_partner_id PRIMARY KEY (page_partner_id);


--
