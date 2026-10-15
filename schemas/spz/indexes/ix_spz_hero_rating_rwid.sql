-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_hero_rating_rwid
-- Type: INDEX

-- Name: ix_spz_hero_rating_rwid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_hero_rating_rwid ON spz.spz_hero_rating USING btree (rating_week_id);


--
