-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_race_category tmm_race_category_race_category_id_key
-- Type: CONSTRAINT

-- Name: tmm_race_category tmm_race_category_race_category_id_key; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_race_category
    ADD CONSTRAINT tmm_race_category_race_category_id_key UNIQUE (race_category_id);


--
