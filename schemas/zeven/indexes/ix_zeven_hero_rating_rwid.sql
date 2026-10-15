-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_hero_rating_rwid
-- Type: INDEX

-- Name: ix_zeven_hero_rating_rwid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_hero_rating_rwid ON zeven.zeven_hero_rating USING btree (rating_week_id);


--
