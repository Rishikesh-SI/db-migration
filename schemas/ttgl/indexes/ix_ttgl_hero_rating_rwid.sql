-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttgl_hero_rating_rwid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_hero_rating_rwid ON ttgl.ttgl_hero_rating USING btree (rating_week_id);


--
