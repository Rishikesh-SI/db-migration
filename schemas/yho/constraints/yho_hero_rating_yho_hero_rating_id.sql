-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_hero_rating yho_hero_rating_id
-- Type: CONSTRAINT

-- Name: yho_hero_rating yho_hero_rating_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_hero_rating
    ADD CONSTRAINT yho_hero_rating_id PRIMARY KEY (hero_rating_id);


--
