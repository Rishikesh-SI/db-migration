-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_hero_rating khi_hero_rating_id
-- Type: CONSTRAINT

-- Name: khi_hero_rating khi_hero_rating_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_hero_rating
    ADD CONSTRAINT khi_hero_rating_id PRIMARY KEY (hero_rating_id);


--
