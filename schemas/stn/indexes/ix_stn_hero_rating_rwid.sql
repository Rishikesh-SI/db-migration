-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_hero_rating_rwid
-- Type: INDEX

-- Name: ix_stn_hero_rating_rwid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_hero_rating_rwid ON stn.stn_hero_rating USING btree (rating_week_id);


--
