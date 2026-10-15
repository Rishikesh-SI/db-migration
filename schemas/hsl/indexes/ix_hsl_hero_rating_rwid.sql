-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_hero_rating_rwid
-- Type: INDEX

-- Name: ix_hsl_hero_rating_rwid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_hero_rating_rwid ON hsl.hsl_hero_rating USING btree (rating_week_id);


--
