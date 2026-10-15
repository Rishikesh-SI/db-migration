-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labgg; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labgg.labgg_hero_rating USING btree (rating_week_id);


--
