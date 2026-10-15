-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_hero_rating_rwid
-- Type: INDEX

-- Name: ix_hsl_hero_rating_rwid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_hero_rating_rwid ON labhsl.labhsl_hero_rating USING btree (rating_week_id);


--
