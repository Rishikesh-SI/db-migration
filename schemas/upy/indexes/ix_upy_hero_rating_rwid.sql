-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_hero_rating_rwid
-- Type: INDEX

-- Name: ix_upy_hero_rating_rwid; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_hero_rating_rwid ON upy.upy_hero_rating USING btree (rating_week_id);


--
