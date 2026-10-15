-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labgsoc; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labgsoc.labgsoc_hero_rating USING btree (rating_week_id);


--
