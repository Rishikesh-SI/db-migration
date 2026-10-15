-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labilt.labilt_hero_rating USING btree (rating_week_id);


--
