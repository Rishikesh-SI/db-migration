-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_race_category tmmimg_upd_race_category_race_category_id_key
-- Type: CONSTRAINT

-- Name: tmmimg_upd_race_category tmmimg_upd_race_category_race_category_id_key; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_race_category
    ADD CONSTRAINT tmmimg_upd_race_category_race_category_id_key UNIQUE (race_category_id);


--
