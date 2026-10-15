-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_hero_rating rfg_hero_rating_id
-- Type: CONSTRAINT

-- Name: rfg_hero_rating rfg_hero_rating_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_hero_rating
    ADD CONSTRAINT rfg_hero_rating_id PRIMARY KEY (hero_rating_id);


--
