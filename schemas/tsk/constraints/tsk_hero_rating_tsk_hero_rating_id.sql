-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_hero_rating tsk_hero_rating_id
-- Type: CONSTRAINT

-- Name: tsk_hero_rating tsk_hero_rating_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_hero_rating
    ADD CONSTRAINT tsk_hero_rating_id PRIMARY KEY (hero_rating_id);


--
