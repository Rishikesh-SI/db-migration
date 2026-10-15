-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_partner pcm_partner_id
-- Type: CONSTRAINT

-- Name: pcm_partner pcm_partner_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_partner
    ADD CONSTRAINT pcm_partner_id PRIMARY KEY (partner_id);


--
