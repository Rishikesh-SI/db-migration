-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_hero_rating pcm_hero_rating_id
-- Type: CONSTRAINT

-- Name: pcm_hero_rating pcm_hero_rating_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_hero_rating
    ADD CONSTRAINT pcm_hero_rating_id PRIMARY KEY (hero_rating_id);


--
