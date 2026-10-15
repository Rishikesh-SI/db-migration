-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_hero_rating_rwid
-- Type: INDEX

-- Name: ix_dd_hero_rating_rwid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_hero_rating_rwid ON dd_30_04_24.dd_hero_rating USING btree (rating_week_id);


--
