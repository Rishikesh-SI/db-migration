-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labkiyg; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labkiyg.labkiyg_hero_rating USING btree (rating_week_id);


--
