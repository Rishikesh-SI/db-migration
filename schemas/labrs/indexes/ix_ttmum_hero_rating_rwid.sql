-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labrs; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labrs.labrs_hero_rating USING btree (rating_week_id);


--
