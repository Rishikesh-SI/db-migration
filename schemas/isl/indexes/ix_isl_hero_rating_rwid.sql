-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_hero_rating_rwid
-- Type: INDEX

-- Name: ix_isl_hero_rating_rwid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_hero_rating_rwid ON isl.isl_hero_rating USING btree (rating_week_id);


--
