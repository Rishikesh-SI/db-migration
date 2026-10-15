-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_hero_rating mum_hero_rating_id
-- Type: CONSTRAINT

-- Name: dhm_hero_rating mum_hero_rating_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_hero_rating
    ADD CONSTRAINT mum_hero_rating_id PRIMARY KEY (hero_rating_id);


--
