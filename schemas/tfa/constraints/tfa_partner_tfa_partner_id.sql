-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_partner tfa_partner_id
-- Type: CONSTRAINT

-- Name: tfa_partner tfa_partner_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_partner
    ADD CONSTRAINT tfa_partner_id PRIMARY KEY (partner_id);


--
