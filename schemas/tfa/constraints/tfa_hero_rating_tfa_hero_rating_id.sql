-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_hero_rating tfa_hero_rating_id
-- Type: CONSTRAINT

-- Name: tfa_hero_rating tfa_hero_rating_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_hero_rating
    ADD CONSTRAINT tfa_hero_rating_id PRIMARY KEY (hero_rating_id);


--
